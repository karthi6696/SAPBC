codeunit 85020 "TTS-ARAP Matching"
{
    procedure MatchTTSARAPData()
    var
        TempMatchedPairs: Record "TTS-ARAP Match Pair" temporary;
        MatchedCount: Integer;
        ProcessingDialog: Dialog;
        ProcessingMsg: Label 'Processing TTS-ARAP Matching...\Matched: #1######';
    begin
        ProcessingDialog.Open(ProcessingMsg);
        
        // Step 1 & 2: Filter and collect matching candidates
        CollectMatchingCandidates(TempMatchedPairs);
        
        // Step 3: Apply matching logic and update records
        MatchedCount := ProcessMatches(TempMatchedPairs);
        
        ProcessingDialog.Close();
        
        Message('TTS-ARAP Matching completed.\Total Matched: %1', MatchedCount);
    end;
    
    local procedure CollectMatchingCandidates(var TempMatchedPairs: Record "TTS-ARAP Match Pair" temporary)
    var
        TTS_SAP: Record TTS_SAP;
        TTS_ARAP: Record TTS_ARAP;
        TempTTSSAPGrouped: Record "TTS-ARAP Match Pair" temporary;
        TempTTSARAPGrouped: Record "TTS-ARAP Match Pair" temporary;
    begin
        // Filter and group TTS_SAP records
        TTS_SAP.Reset();
        TTS_SAP.SetRange(Scheme, 'FTTS');
        TTS_SAP.SetFilter("Matching Status", '%1|%2', 
            TTS_SAP."Matching Status"::Unmatched, 
            TTS_SAP."Matching Status"::Error);
        TTS_SAP.SetRange(Activity, 'INVOICE');
        
        if TTS_SAP.FindSet() then
            repeat
                if TTS_SAP.PaymentReference <> '' then begin
                    TempTTSSAPGrouped.Init();
                    TempTTSSAPGrouped."Reference Key" := TTS_SAP.PaymentReference;
                    if TempTTSSAPGrouped.Find() then begin
                        TempTTSSAPGrouped.Amount += TTS_SAP.TestCostWithoutVat;
                        TempTTSSAPGrouped.Modify();
                    end else begin
                        TempTTSSAPGrouped."Reference Key" := TTS_SAP.PaymentReference;
                        TempTTSSAPGrouped.Amount := TTS_SAP.TestCostWithoutVat;
                        TempTTSSAPGrouped."Source Type" := TempTTSSAPGrouped."Source Type"::TTS_SAP;
                        TempTTSSAPGrouped.Insert();
                    end;
                end;
            until TTS_SAP.Next() = 0;
        
        // Filter and group TTS_ARAP records
        TTS_ARAP.Reset();
        TTS_ARAP.SetRange(Scheme, 'FTTS');
        TTS_ARAP.SetFilter("LOB Matching Status", '%1|%2', 
            TTS_ARAP."LOB Matching Status"::Unmatched, 
            TTS_ARAP."LOB Matching Status"::Error);
        TTS_ARAP.SetRange(Activity, 'PAYMENT');
        
        if TTS_ARAP.FindSet() then
            repeat
                if TTS_ARAP.ReceiptNumber <> '' then begin
                    TempTTSARAPGrouped.Init();
                    TempTTSARAPGrouped."Reference Key" := TTS_ARAP.ReceiptNumber;
                    if TempTTSARAPGrouped.Find() then begin
                        TempTTSARAPGrouped.Amount += TTS_ARAP.ReceiptAmount;
                        TempTTSARAPGrouped.Modify();
                    end else begin
                        TempTTSARAPGrouped."Reference Key" := TTS_ARAP.ReceiptNumber;
                        TempTTSARAPGrouped.Amount := TTS_ARAP.ReceiptAmount;
                        TempTTSARAPGrouped."Source Type" := TempTTSARAPGrouped."Source Type"::TTS_ARAP;
                        TempTTSARAPGrouped.Insert();
                    end;
                end;
            until TTS_ARAP.Next() = 0;
        
        // Match grouped records where amounts are equal
        if TempTTSSAPGrouped.FindSet() then
            repeat
                TempTTSARAPGrouped.SetRange("Reference Key", TempTTSSAPGrouped."Reference Key");
                if TempTTSARAPGrouped.FindFirst() then begin
                    if TempTTSSAPGrouped.Amount = TempTTSARAPGrouped.Amount then begin
                        TempMatchedPairs.Init();
                        TempMatchedPairs."Reference Key" := TempTTSSAPGrouped."Reference Key";
                        TempMatchedPairs.Amount := TempTTSSAPGrouped.Amount;
                        TempMatchedPairs.Insert();
                    end;
                end;
                TempTTSARAPGrouped.SetRange("Reference Key");
            until TempTTSSAPGrouped.Next() = 0;
    end;
    
    local procedure ProcessMatches(var TempMatchedPairs: Record "TTS-ARAP Match Pair" temporary): Integer
    var
        TTS_SAP: Record TTS_SAP;
        TTS_ARAP: Record TTS_ARAP;
        GenLedgerSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MatchingID: Code[20];
        MatchedCount: Integer;
        CurrentDateTime: DateTime;
        MatchDetails: Text[1000];
    begin
        GenLedgerSetup.Get();
        GenLedgerSetup.TestField("TTS-ARAP Matching No. Series");
        
        CurrentDateTime := CurrentDateTime();
        MatchedCount := 0;
        
        if TempMatchedPairs.FindSet() then
            repeat
                // Generate new matching ID
                MatchingID := NoSeriesMgt.GetNextNo(GenLedgerSetup."TTS-ARAP Matching No. Series", Today(), true);
                MatchDetails := StrSubstNo('Auto-matched on %1. Reference: %2, Amount: %3', 
                    CurrentDateTime, TempMatchedPairs."Reference Key", TempMatchedPairs.Amount);
                
                // Update TTS_SAP records
                TTS_SAP.Reset();
                TTS_SAP.SetRange(Scheme, 'FTTS');
                TTS_SAP.SetFilter("Matching Status", '%1|%2', 
                    TTS_SAP."Matching Status"::Unmatched, 
                    TTS_SAP."Matching Status"::Error);
                TTS_SAP.SetRange(Activity, 'INVOICE');
                TTS_SAP.SetRange(PaymentReference, TempMatchedPairs."Reference Key");
                
                if TTS_SAP.FindSet(true) then
                    repeat
                        TTS_SAP."Matching Status" := TTS_SAP."Matching Status"::Matched;
                        TTS_SAP."Matching ID" := MatchingID;
                        TTS_SAP."Matching Processed Date Time" := CurrentDateTime;
                        TTS_SAP."Match Details" := MatchDetails;
                        TTS_SAP."Match Type" := TTS_SAP."Match Type"::Automatic;
                        TTS_SAP."Matched By" := UserId();
                        TTS_SAP.Modify(true);
                        MatchedCount += 1;
                    until TTS_SAP.Next() = 0;
                
                // Update TTS_ARAP records
                TTS_ARAP.Reset();
                TTS_ARAP.SetRange(Scheme, 'FTTS');
                TTS_ARAP.SetFilter("LOB Matching Status", '%1|%2', 
                    TTS_ARAP."LOB Matching Status"::Unmatched, 
                    TTS_ARAP."LOB Matching Status"::Error);
                TTS_ARAP.SetRange(Activity, 'PAYMENT');
                TTS_ARAP.SetRange(ReceiptNumber, TempMatchedPairs."Reference Key");
                
                if TTS_ARAP.FindSet(true) then
                    repeat
                        TTS_ARAP."LOB Matching Status" := TTS_ARAP."LOB Matching Status"::Matched;
                        TTS_ARAP."LOB Matching ID" := MatchingID;
                        TTS_ARAP."LOB Processed Date Time" := CurrentDateTime;
                        TTS_ARAP."LOB Match Details" := MatchDetails;
                        TTS_ARAP."LOB Match Type" := TTS_ARAP."LOB Match Type"::Automatic;
                        TTS_ARAP."LOB Matched By" := UserId();
                        TTS_ARAP.Modify(true);
                        MatchedCount += 1;
                    until TTS_ARAP.Next() = 0;
                    
            until TempMatchedPairs.Next() = 0;
        
        exit(MatchedCount);
    end;
}

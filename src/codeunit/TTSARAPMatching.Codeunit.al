codeunit 85020 "TTS-ARAP Matching"
{
    procedure MatchTTSARAPData()
    var
        TempMatchedPairs: Record "TTS-ARAP Match Pair" temporary;
        MatchedPairCount: Integer;
        ProcessingDialog: Dialog;
        ProcessingMsg: Label 'Processing TTS-ARAP Matching...\#1################################\Matched Pairs: #2######';
    begin
        ProcessingDialog.Open(ProcessingMsg);
        
        // Step 1 & 2: Filter and collect matching candidates
        ProcessingDialog.Update(1, 'Collecting and grouping records...');
        ProcessingDialog.Update(2, 0);
        CollectMatchingCandidates(TempMatchedPairs, ProcessingDialog);
        
        // Step 3: Apply matching logic and update records
        ProcessingDialog.Update(1, 'Updating matched records...');
        MatchedPairCount := ProcessMatches(TempMatchedPairs, ProcessingDialog);
        
        ProcessingDialog.Close();
        
        Message('TTS-ARAP Matching completed.\Total Pairs Matched: %1', MatchedPairCount);
    end;
    
    procedure SetMatchType(NewMatchType: Enum "Match Type")
    begin
        MatchType := NewMatchType;
    end;
    
    procedure SetSelectedTTSSAP(var TempTTSSAP: Record TTS_SAP temporary)
    begin
        TempSelectedTTSSAP.Reset();
        TempSelectedTTSSAP.DeleteAll();
        
        if TempTTSSAP.FindSet() then
            repeat
                TempSelectedTTSSAP := TempTTSSAP;
                TempSelectedTTSSAP.Insert();
            until TempTTSSAP.Next() = 0;
    end;
    
    procedure SetSelectedTTSARAP(var TempTTSARAP: Record TTS_ARAP temporary)
    begin
        TempSelectedTTSARAP.Reset();
        TempSelectedTTSARAP.DeleteAll();
        
        if TempTTSARAP.FindSet() then
            repeat
                TempSelectedTTSARAP := TempTTSARAP;
                TempSelectedTTSARAP.Insert();
            until TempTTSARAP.Next() = 0;
    end;
    
    local procedure CollectMatchingCandidates(var TempMatchedPairs: Record "TTS-ARAP Match Pair" temporary; var ProcessingDialog: Dialog)
    var
        TTS_SAP: Record TTS_SAP;
        TTS_ARAP: Record TTS_ARAP;
        TempTTSSAPGrouped: Record "TTS-ARAP Match Pair" temporary;
        TempTTSARAPGrouped: Record "TTS-ARAP Match Pair" temporary;
    begin
        // Filter and group TTS_SAP records
        ProcessingDialog.Update(1, 'Collecting TTS_SAP records...');
        if MatchType = MatchType::Manual then begin
            // Use selected records for manual matching
            if TempSelectedTTSSAP.FindSet() then
                repeat
                    if TempSelectedTTSSAP.PaymentReference <> '' then begin
                        TempTTSSAPGrouped.Init();
                        TempTTSSAPGrouped."Reference Key" := TempSelectedTTSSAP.PaymentReference;
                        if TempTTSSAPGrouped.Find() then begin
                            TempTTSSAPGrouped.Amount += TempSelectedTTSSAP.TestCostWithoutVat;
                            TempTTSSAPGrouped.Modify();
                        end else begin
                            TempTTSSAPGrouped."Reference Key" := TempSelectedTTSSAP.PaymentReference;
                            TempTTSSAPGrouped.Amount := TempSelectedTTSSAP.TestCostWithoutVat;
                            TempTTSSAPGrouped."Source Type" := TempTTSSAPGrouped."Source Type"::TTS_SAP;
                            TempTTSSAPGrouped.Insert();
                        end;
                    end;
                until TempSelectedTTSSAP.Next() = 0;
        end else begin
            // Use all records for automatic matching - optimized with SetCurrentKey
            TTS_SAP.Reset();
            TTS_SAP.SetCurrentKey(Scheme, Activity, "Matching Status", PaymentReference);
            TTS_SAP.SetRange(Scheme, 'FTTS');
            TTS_SAP.SetRange(Activity, 'INVOICE');
            TTS_SAP.SetFilter("Matching Status", '%1|%2', 
                TTS_SAP."Matching Status"::Unmatched, 
                TTS_SAP."Matching Status"::Error);
            TTS_SAP.SetLoadFields(PaymentReference, TestCostWithoutVat);
            
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
        end;
        
        // Filter and group TTS_ARAP records
        ProcessingDialog.Update(1, 'Collecting TTS_ARAP records...');
        if MatchType = MatchType::Manual then begin
            // Use selected records for manual matching
            if TempSelectedTTSARAP.FindSet() then
                repeat
                    if TempSelectedTTSARAP.ReceiptNumber <> '' then begin
                        TempTTSARAPGrouped.Init();
                        TempTTSARAPGrouped."Reference Key" := TempSelectedTTSARAP.ReceiptNumber;
                        if TempTTSARAPGrouped.Find() then begin
                            TempTTSARAPGrouped.Amount += TempSelectedTTSARAP.ReceiptAmount;
                            TempTTSARAPGrouped.Modify();
                        end else begin
                            TempTTSARAPGrouped."Reference Key" := TempSelectedTTSARAP.ReceiptNumber;
                            TempTTSARAPGrouped.Amount := TempSelectedTTSARAP.ReceiptAmount;
                            TempTTSARAPGrouped."Source Type" := TempTTSARAPGrouped."Source Type"::TTS_ARAP;
                            TempTTSARAPGrouped.Insert();
                        end;
                    end;
                until TempSelectedTTSARAP.Next() = 0;
        end else begin
            // Use all records for automatic matching - optimized with SetCurrentKey
            TTS_ARAP.Reset();
            TTS_ARAP.SetCurrentKey(Scheme, Activity, "LOB Matching Status", ReceiptNumber);
            TTS_ARAP.SetRange(Scheme, 'FTTS');
            TTS_ARAP.SetRange(Activity, 'PAYMENT');
            TTS_ARAP.SetFilter("LOB Matching Status", '%1|%2', 
                TTS_ARAP."LOB Matching Status"::Unmatched, 
                TTS_ARAP."LOB Matching Status"::Error);
            TTS_ARAP.SetLoadFields(ReceiptNumber, ReceiptAmount);
            
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
        end;
        
        // Match grouped records where amounts are equal
        ProcessingDialog.Update(1, 'Finding matching pairs...');
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
    
    local procedure ProcessMatches(var TempMatchedPairs: Record "TTS-ARAP Match Pair" temporary; var ProcessingDialog: Dialog): Integer
    var
        TTS_SAP: Record TTS_SAP;
        TTS_ARAP: Record TTS_ARAP;
        TempTTSSAP: Record TTS_SAP temporary;
        TempTTSARAP: Record TTS_ARAP temporary;
        GenLedgerSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MatchingID: Code[20];
        MatchedPairCount: Integer;
        CurrentDateTime: DateTime;
        MatchDetails: Text[1000];
        TotalPairs: Integer;
        CurrentPair: Integer;
        LastUpdateCount: Integer;
        PaymentRefFilter: Text;
        ReceiptNoFilter: Text;
    begin
        GenLedgerSetup.Get();
        GenLedgerSetup.TestField("TTS-ARAP Matching No. Series");
        
        CurrentDateTime := CurrentDateTime();
        MatchedPairCount := 0;
        LastUpdateCount := 0;
        TotalPairs := TempMatchedPairs.Count();
        CurrentPair := 0;
        
        // Pre-fetch all TTS_SAP and TTS_ARAP records in ONE query each
        // This eliminates N SELECT queries (one per pair)
        // Note: Filter string limited to ~1000 chars. For >50 pairs with long refs, consider chunking.
        ProcessingDialog.Update(1, 'Pre-fetching records for matching...');
        
        // Build filter for all PaymentReferences from matched pairs
        PaymentRefFilter := '';
        ReceiptNoFilter := '';
        if TempMatchedPairs.FindSet() then
            repeat
                if PaymentRefFilter <> '' then
                    PaymentRefFilter += '|';
                PaymentRefFilter += TempMatchedPairs."Reference Key";
                
                if ReceiptNoFilter <> '' then
                    ReceiptNoFilter += '|';
                ReceiptNoFilter += TempMatchedPairs."Reference Key";
            until TempMatchedPairs.Next() = 0;
        
        // Validate filter string size (AL text limit is ~1000-2000 chars)
        if StrLen(PaymentRefFilter) > 1000 then
            Error('Too many matching pairs (%1). Filter exceeds size limit. Please process in smaller batches.', TotalPairs);
        
        // Pre-fetch ALL TTS_SAP records that match ANY pair - ONE query
        TTS_SAP.Reset();
        TTS_SAP.SetCurrentKey(Scheme, Activity, PaymentReference, "Matching Status");
        TTS_SAP.SetRange(Scheme, 'FTTS');
        TTS_SAP.SetRange(Activity, 'INVOICE');
        TTS_SAP.SetFilter(PaymentReference, PaymentRefFilter);
        TTS_SAP.SetFilter("Matching Status", '%1|%2', 
            TTS_SAP."Matching Status"::Unmatched, 
            TTS_SAP."Matching Status"::Error);
        
        if TTS_SAP.FindSet() then
            repeat
                TempTTSSAP := TTS_SAP;
                TempTTSSAP.Insert();
            until TTS_SAP.Next() = 0;
        
        // Pre-fetch ALL TTS_ARAP records that match ANY pair - ONE query
        TTS_ARAP.Reset();
        TTS_ARAP.SetCurrentKey(Scheme, Activity, ReceiptNumber, "LOB Matching Status");
        TTS_ARAP.SetRange(Scheme, 'FTTS');
        TTS_ARAP.SetRange(Activity, 'PAYMENT');
        TTS_ARAP.SetFilter(ReceiptNumber, ReceiptNoFilter);
        TTS_ARAP.SetFilter("LOB Matching Status", '%1|%2', 
            TTS_ARAP."LOB Matching Status"::Unmatched, 
            TTS_ARAP."LOB Matching Status"::Error);
        
        if TTS_ARAP.FindSet() then
            repeat
                TempTTSARAP := TTS_ARAP;
                TempTTSARAP.Insert();
            until TTS_ARAP.Next() = 0;
        
        // Now process each pair using the pre-fetched temporary records
        if TempMatchedPairs.FindSet() then
            repeat
                CurrentPair += 1;
                // Update dialog every 10 pairs or on last pair to reduce UI overhead
                if (CurrentPair mod 10 = 0) or (CurrentPair = TotalPairs) then
                    ProcessingDialog.Update(1, StrSubstNo('Processing pair %1 of %2...', CurrentPair, TotalPairs));
                
                // Generate new matching ID
                MatchingID := NoSeriesMgt.GetNextNo(GenLedgerSetup."TTS-ARAP Matching No. Series", Today(), true);
                MatchDetails := CopyStr(StrSubstNo('Auto-matched on %1. Reference: %2, Amount: %3', 
                    CurrentDateTime, TempMatchedPairs."Reference Key", TempMatchedPairs.Amount), 1, 1000);
                
                // Update TTS_SAP records from temporary table (no SELECT query)
                TempTTSSAP.Reset();
                TempTTSSAP.SetRange(PaymentReference, TempMatchedPairs."Reference Key");
                if TempTTSSAP.FindSet() then
                    repeat
                        // Get the actual record for updating (with error handling)
                        if TTS_SAP.Get(TempTTSSAP."Entry No.") then begin
                            TTS_SAP."Matching Status" := TTS_SAP."Matching Status"::Matched;
                            TTS_SAP."Matching ID" := MatchingID;
                            TTS_SAP."Matching Processed Date Time" := CurrentDateTime;
                            TTS_SAP."Match Details" := MatchDetails;
                            TTS_SAP."Match Type" := MatchType;
                            TTS_SAP."Matched By" := UserId();
                            TTS_SAP.Modify(false);
                        end;
                    until TempTTSSAP.Next() = 0;
                
                // Update TTS_ARAP records from temporary table (no SELECT query)
                TempTTSARAP.Reset();
                TempTTSARAP.SetRange(ReceiptNumber, TempMatchedPairs."Reference Key");
                if TempTTSARAP.FindSet() then
                    repeat
                        // Get the actual record for updating (with error handling)
                        if TTS_ARAP.Get(TempTTSARAP."Entry No.") then begin
                            TTS_ARAP."LOB Matching Status" := TTS_ARAP."LOB Matching Status"::Matched;
                            TTS_ARAP."LOB Matching ID" := MatchingID;
                            TTS_ARAP."LOB Processed Date Time" := CurrentDateTime;
                            TTS_ARAP."LOB Match Details" := MatchDetails;
                            TTS_ARAP."LOB Match Type" := MatchType;
                            TTS_ARAP."LOB Matched By" := UserId();
                            TTS_ARAP.Modify(false);
                        end;
                    until TempTTSARAP.Next() = 0;
                
                // Increment pair count once per matched pair (not per record)
                MatchedPairCount += 1;
                
                // Update matched pair count every 10 pairs or on last pair to reduce UI overhead
                if (MatchedPairCount - LastUpdateCount >= 10) or (CurrentPair = TotalPairs) then begin
                    ProcessingDialog.Update(2, MatchedPairCount);
                    LastUpdateCount := MatchedPairCount;
                end;
                    
            until TempMatchedPairs.Next() = 0;
        
        exit(MatchedPairCount);
    end;
    
    var
        TempSelectedTTSSAP: Record TTS_SAP temporary;
        TempSelectedTTSARAP: Record TTS_ARAP temporary;
        MatchType: Enum "Match Type";
}

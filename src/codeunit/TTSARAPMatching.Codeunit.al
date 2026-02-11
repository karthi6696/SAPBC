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
        TempChunkPairs: Record "TTS-ARAP Match Pair" temporary;
        TotalPairs: Integer;
        MatchedPairCount: Integer;
        ChunkStartPair: Integer;
        ChunkEndPair: Integer;
        ChunkSize: Integer;
        CurrentPair: Integer;
        TotalChunks: Integer;
        CurrentChunk: Integer;
    begin
        TotalPairs := TempMatchedPairs.Count();
        MatchedPairCount := 0;
        ChunkSize := 50;  // Process 50 pairs per chunk to avoid filter size limit
        TotalChunks := (TotalPairs + ChunkSize - 1) div ChunkSize;  // Round up
        
        // Process pairs in chunks to avoid filter string size limit (AL text ~1000 chars)
        // For 10,000 pairs: 200 chunks × 2 queries = 400 queries (vs 20,000 without chunking)
        CurrentPair := 0;
        CurrentChunk := 0;
        
        if TempMatchedPairs.FindSet() then
            repeat
                CurrentPair += 1;
                
                // Add to chunk temporary table
                TempChunkPairs := TempMatchedPairs;
                TempChunkPairs.Insert();
                
                // Process chunk when full or at end
                if (CurrentPair mod ChunkSize = 0) or (CurrentPair = TotalPairs) then begin
                    CurrentChunk += 1;
                    ProcessingDialog.Update(1, StrSubstNo('Processing chunk %1 of %2 (%3 pairs)...', 
                        CurrentChunk, TotalChunks, TempChunkPairs.Count()));
                    
                    // Process this chunk
                    MatchedPairCount += ProcessChunk(TempChunkPairs, ProcessingDialog);
                    
                    // Clear chunk for next batch
                    TempChunkPairs.DeleteAll();
                    
                    // Update overall count
                    ProcessingDialog.Update(2, MatchedPairCount);
                end;
                
            until TempMatchedPairs.Next() = 0;
        
        exit(MatchedPairCount);
    end;
    
    local procedure ProcessChunk(var TempChunkPairs: Record "TTS-ARAP Match Pair" temporary; var ProcessingDialog: Dialog): Integer
    var
        TTS_SAP: Record TTS_SAP;
        TTS_ARAP: Record TTS_ARAP;
        TempTTSSAP: Record TTS_SAP temporary;
        TempTTSARAP: Record TTS_ARAP temporary;
        GenLedgerSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MatchingID: Code[20];
        CurrentDateTime: DateTime;
        MatchDetails: Text[1000];
        PaymentRefFilter: Text;
        ReceiptNoFilter: Text;
        ChunkMatchedCount: Integer;
    begin
        GenLedgerSetup.Get();
        GenLedgerSetup.TestField("TTS-ARAP Matching No. Series");
        CurrentDateTime := CurrentDateTime();
        ChunkMatchedCount := 0;
        
        // Build filter for this chunk's PaymentReferences
        PaymentRefFilter := '';
        ReceiptNoFilter := '';
        if TempChunkPairs.FindSet() then
            repeat
                if PaymentRefFilter <> '' then
                    PaymentRefFilter += '|';
                PaymentRefFilter += TempChunkPairs."Reference Key";
                
                if ReceiptNoFilter <> '' then
                    ReceiptNoFilter += '|';
                ReceiptNoFilter += TempChunkPairs."Reference Key";
            until TempChunkPairs.Next() = 0;
        
        // Pre-fetch TTS_SAP records for this chunk - ONE query per chunk
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
        
        // Pre-fetch TTS_ARAP records for this chunk - ONE query per chunk
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
        
        // Process each pair in this chunk using the pre-fetched temporary records
        if TempChunkPairs.FindSet() then
            repeat
                // Generate new matching ID
                MatchingID := NoSeriesMgt.GetNextNo(GenLedgerSetup."TTS-ARAP Matching No. Series", Today(), true);
                MatchDetails := CopyStr(StrSubstNo('Auto-matched on %1. Reference: %2, Amount: %3', 
                    CurrentDateTime, TempChunkPairs."Reference Key", TempChunkPairs.Amount), 1, 1000);
                
                // Update TTS_SAP records from temporary table (no SELECT query)
                TempTTSSAP.Reset();
                TempTTSSAP.SetRange(PaymentReference, TempChunkPairs."Reference Key");
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
                TempTTSARAP.SetRange(ReceiptNumber, TempChunkPairs."Reference Key");
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
                
                // Increment pair count for this chunk
                ChunkMatchedCount += 1;
                
            until TempChunkPairs.Next() = 0;
        
        exit(ChunkMatchedCount);
    end;
    
    var
        TempSelectedTTSSAP: Record TTS_SAP temporary;
        TempSelectedTTSARAP: Record TTS_ARAP temporary;
        MatchType: Enum "Match Type";
}

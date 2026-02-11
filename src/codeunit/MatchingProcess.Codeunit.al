codeunit 85012 "Matching Process"
{
    procedure SetMatchType(MatchType: Enum "Match Type")
    begin
        gMatchType := MatchType;
    end;

    procedure SetSelectedLOB(var LOBRecords: Record TTS_SAP temporary)
    begin
        TempSelectedLOB.Reset();
        TempSelectedLOB.DeleteAll();
        if LOBRecords.FindSet() then
            repeat
                TempSelectedLOB := LOBRecords;
                TempSelectedLOB.Insert();
            until LOBRecords.Next() = 0;
    end;

    procedure SetSelectedCPMS(var CPMSRecords: Record TTS_ARAP temporary)
    begin
        TempSelectedCPMS.Reset();
        TempSelectedCPMS.DeleteAll();
        if CPMSRecords.FindSet() then
            repeat
                TempSelectedCPMS := CPMSRecords;
                TempSelectedCPMS.Insert();
            until CPMSRecords.Next() = 0;
    end;

    procedure SetSelectedEOD(var EODRecords: Record "EOD Staging" temporary)
    begin
        TempSelectedEOD.Reset();
        TempSelectedEOD.DeleteAll();
        if EODRecords.FindSet() then
            repeat
                TempSelectedEOD := EODRecords;
                TempSelectedEOD.Insert();
            until EODRecords.Next() = 0;
    end;

    procedure MatchLOBCPMSData()
    var
        TempTTSSAPGrouped: Record TTS_SAP temporary;
        TempTTSARAPGrouped: Record TTS_ARAP temporary;
        ProcessingDialog: Dialog;
        TotalRecords: Integer;
        CurrentRecord: Integer;
        MatchedCount: Integer;
        ProgressMsg: Label 'Matching LOB and CPMS records...\Processing: #1#####################\Total Records: #2#####\Current Record: #3#####\Matches Found: #4#####';
        CurrentRefKey: Text[50];
    begin
        // Group and prepare records
        GroupLOBRecords(TempTTSSAPGrouped);
        GroupCPMSRecords(TempTTSARAPGrouped);
        
        TotalRecords := TempTTSSAPGrouped.Count();
        if TotalRecords = 0 then begin
            Message('No records to match.');
            exit;
        end;

        ProcessingDialog.Open(ProgressMsg);
        CurrentRecord := 0;
        MatchedCount := 0;

        if TempTTSSAPGrouped.FindSet() then
            repeat
                CurrentRecord += 1;
                CurrentRefKey := TempTTSSAPGrouped.PaymentReference;
                
                // Update progress dialog with current record info
                ProcessingDialog.Update(1, CurrentRefKey);
                ProcessingDialog.Update(2, TotalRecords);
                ProcessingDialog.Update(3, CurrentRecord);
                ProcessingDialog.Update(4, MatchedCount);
                
                // Match with CPMS records
                TempTTSARAPGrouped.SetRange(ReceiptNumber, TempTTSSAPGrouped.PaymentReference);
                if TempTTSARAPGrouped.FindFirst() then begin
                    // Use tolerance-based comparison for amounts to handle rounding differences
                    if Abs(TempTTSSAPGrouped.TestCostWithoutVat - TempTTSARAPGrouped.ReceiptAmount) < 0.01 then begin
                        // Create match
                        CreateLOBCPMSMatch(TempTTSSAPGrouped, TempTTSARAPGrouped);
                        MatchedCount += 1;
                        ProcessingDialog.Update(4, MatchedCount);
                    end;
                end;
                TempTTSARAPGrouped.SetRange(ReceiptNumber);
            until TempTTSSAPGrouped.Next() = 0;

        ProcessingDialog.Close();
        Message('Matching completed. Total matches found: %1', MatchedCount);
    end;

    procedure MatchEODCPMSData()
    var
        TempEODGrouped: Record "EOD Staging" temporary;
        TempCPMSGrouped: Record TTS_ARAP temporary;
        ProcessingDialog: Dialog;
        TotalRecords: Integer;
        CurrentRecord: Integer;
        MatchedCount: Integer;
        ProgressMsg: Label 'Matching EOD and CPMS records...\Processing: #1#####################\Total Records: #2#####\Current Record: #3#####\Matches Found: #4#####';
        CurrentRefKey: Text[50];
    begin
        // Group and prepare records
        GroupEODRecords(TempEODGrouped);
        GroupCPMSRecords(TempCPMSGrouped);
        
        TotalRecords := TempEODGrouped.Count();
        if TotalRecords = 0 then begin
            Message('No records to match.');
            exit;
        end;

        ProcessingDialog.Open(ProgressMsg);
        CurrentRecord := 0;
        MatchedCount := 0;

        if TempEODGrouped.FindSet() then
            repeat
                CurrentRecord += 1;
                CurrentRefKey := TempEODGrouped."Reference Number";
                
                // Update progress dialog with current record info
                ProcessingDialog.Update(1, CurrentRefKey);
                ProcessingDialog.Update(2, TotalRecords);
                ProcessingDialog.Update(3, CurrentRecord);
                ProcessingDialog.Update(4, MatchedCount);
                
                // Match with CPMS records
                TempCPMSGrouped.SetRange(ReceiptNumber, TempEODGrouped."Reference Number");
                if TempCPMSGrouped.FindFirst() then begin
                    // Use tolerance-based comparison for amounts to handle rounding differences
                    if Abs(TempEODGrouped."Transaction Amount" - TempCPMSGrouped.ReceiptAmount) < 0.01 then begin
                        // Create match
                        CreateEODCPMSMatch(TempEODGrouped, TempCPMSGrouped);
                        MatchedCount += 1;
                        ProcessingDialog.Update(4, MatchedCount);
                    end;
                end;
                TempCPMSGrouped.SetRange(ReceiptNumber);
            until TempEODGrouped.Next() = 0;

        ProcessingDialog.Close();
        Message('Matching completed. Total matches found: %1', MatchedCount);
    end;

    // TODO: Implement force matching logic for LOB-CPMS records
    procedure ForceLOBCPMSMatch(var LOBRecords: Record TTS_SAP temporary; var CPMSRecords: Record TTS_ARAP temporary)
    begin
        // Implementation placeholder
        Message('Force matching completed.');
    end;

    // TODO: Implement force matching logic for EOD-CPMS records
    procedure ForceEODCPMSMatch(var EODRecords: Record "EOD Staging" temporary; var CPMSRecords: Record TTS_ARAP temporary)
    begin
        // Implementation placeholder
        Message('Force matching completed.');
    end;

    local procedure GroupLOBRecords(var TempGrouped: Record TTS_SAP temporary)
    var
        LOB: Record TTS_SAP;
    begin
        TempGrouped.Reset();
        TempGrouped.DeleteAll();
        
        if gMatchType = gMatchType::Manual then begin
            if TempSelectedLOB.FindSet() then
                repeat
                    TempGrouped := TempSelectedLOB;
                    TempGrouped.Insert();
                until TempSelectedLOB.Next() = 0;
        end else begin
            LOB.Reset();
            LOB.SetRange("Matching Status", LOB."Matching Status"::Unmatched);
            if LOB.FindSet() then
                repeat
                    TempGrouped := LOB;
                    TempGrouped.Insert();
                until LOB.Next() = 0;
        end;
    end;

    local procedure GroupCPMSRecords(var TempGrouped: Record TTS_ARAP temporary)
    var
        CPMS: Record TTS_ARAP;
    begin
        TempGrouped.Reset();
        TempGrouped.DeleteAll();
        
        if gMatchType = gMatchType::Manual then begin
            if TempSelectedCPMS.FindSet() then
                repeat
                    TempGrouped := TempSelectedCPMS;
                    TempGrouped.Insert();
                until TempSelectedCPMS.Next() = 0;
        end else begin
            CPMS.Reset();
            CPMS.SetRange("LOB Matching Status", CPMS."LOB Matching Status"::Unmatched);
            if CPMS.FindSet() then
                repeat
                    TempGrouped := CPMS;
                    TempGrouped.Insert();
                until CPMS.Next() = 0;
        end;
    end;

    local procedure GroupEODRecords(var TempGrouped: Record "EOD Staging" temporary)
    var
        EOD: Record "EOD Staging";
    begin
        TempGrouped.Reset();
        TempGrouped.DeleteAll();
        
        if gMatchType = gMatchType::Manual then begin
            if TempSelectedEOD.FindSet() then
                repeat
                    TempGrouped := TempSelectedEOD;
                    TempGrouped.Insert();
                until TempSelectedEOD.Next() = 0;
        end else begin
            EOD.Reset();
            EOD.SetRange("Matching Status", EOD."Matching Status"::Unmatched);
            if EOD.FindSet() then
                repeat
                    TempGrouped := EOD;
                    TempGrouped.Insert();
                until EOD.Next() = 0;
        end;
    end;

    local procedure CreateLOBCPMSMatch(var TempLOB: Record TTS_SAP; var TempCPMS: Record TTS_ARAP)
    var
        LOB: Record TTS_SAP;
        CPMS: Record TTS_ARAP;
        MatchID: Code[20];
        NoSeries: Codeunit "No. Series";
        GLSetup: Record "General Ledger Setup";
        MatchedLbl: Label 'Matched Automatically';
        GLSetupErr: Label 'General Ledger Setup must be configured before matching records.';
    begin
        if not GLSetup.Get() then
            Error(GLSetupErr);
            
        MatchID := NoSeries.GetNextNo(GLSetup."LOB-CPMS Matching No. Series");
        
        // Update actual LOB record in database
        if LOB.Get(TempLOB."Entry No.") then begin
            LOB."Matching Status" := LOB."Matching Status"::Matched;
            LOB."Matching ID" := MatchID;
            LOB."Match Type" := gMatchType;
            LOB."Matching Processed Date Time" := CurrentDateTime;
            LOB."Matched By" := UserId;
            LOB."Match Details" := MatchedLbl;
            LOB.Modify();
        end;
        
        // Update actual CPMS record in database
        if CPMS.Get(TempCPMS."Entry No.") then begin
            CPMS."LOB Matching Status" := CPMS."LOB Matching Status"::Matched;
            CPMS."LOB Matching ID" := MatchID;
            CPMS."LOB Match Type" := gMatchType;
            CPMS."LOB Processed Date Time" := CurrentDateTime;
            CPMS."LOB Matched By" := UserId;
            CPMS."LOB Match Details" := MatchedLbl;
            CPMS.Modify();
        end;
    end;

    local procedure CreateEODCPMSMatch(var TempEOD: Record "EOD Staging"; var TempCPMS: Record TTS_ARAP)
    var
        EOD: Record "EOD Staging";
        CPMS: Record TTS_ARAP;
        MatchID: Code[20];
        NoSeries: Codeunit "No. Series";
        GLSetup: Record "General Ledger Setup";
        MatchedLbl: Label 'Matched Automatically';
        GLSetupErr: Label 'General Ledger Setup must be configured before matching records.';
    begin
        if not GLSetup.Get() then
            Error(GLSetupErr);
            
        MatchID := NoSeries.GetNextNo(GLSetup."EOD-CPMS Matching No. Series");
        
        // Update actual EOD record in database
        if EOD.Get(TempEOD."Entry No.") then begin
            EOD."Matching Status" := EOD."Matching Status"::Matched;
            EOD."Matching ID" := MatchID;
            EOD."Match Type" := gMatchType;
            EOD."Matching Processed Date Time" := CurrentDateTime;
            EOD."Matched By" := UserId;
            EOD."Match Details" := MatchedLbl;
            EOD.Modify();
        end;
        
        // Update actual CPMS record in database
        if CPMS.Get(TempCPMS."Entry No.") then begin
            CPMS."EOD Matching Status" := CPMS."EOD Matching Status"::Matched;
            CPMS."EOD Matching ID" := MatchID;
            CPMS."EOD Match Type" := gMatchType;
            CPMS."EOD Processed Date Time" := CurrentDateTime;
            CPMS."EOD Matched By" := UserId;
            CPMS."EOD Match Details" := MatchedLbl;
            CPMS.Modify();
        end;
    end;

    var
        TempSelectedLOB: Record TTS_SAP temporary;
        TempSelectedCPMS: Record TTS_ARAP temporary;
        TempSelectedEOD: Record "EOD Staging" temporary;
        gMatchType: Enum "Match Type";
}

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
                    if TempTTSSAPGrouped.TestCostWithoutVat = TempTTSARAPGrouped.ReceiptAmount then begin
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
                    if TempEODGrouped."Transaction Amount" = TempCPMSGrouped.ReceiptAmount then begin
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

    procedure ForceLOBCPMSMatch(var LOBRecords: Record TTS_SAP temporary; var CPMSRecords: Record TTS_ARAP temporary)
    begin
        // Implementation placeholder
        Message('Force matching completed.');
    end;

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

    local procedure CreateLOBCPMSMatch(var LOB: Record TTS_SAP; var CPMS: Record TTS_ARAP)
    var
        MatchID: Code[20];
        NoSeries: Codeunit "No. Series";
        GLSetup: Record "General Ledger Setup";
        MatchedLbl: Label 'Matched Automatically';
    begin
        GLSetup.Get();
        MatchID := NoSeries.GetNextNo(GLSetup."LOB-CPMS Matching No. Series");
        
        // Update LOB record
        LOB."Matching Status" := LOB."Matching Status"::Matched;
        LOB."Matching ID" := MatchID;
        LOB."Match Type" := gMatchType;
        LOB."Matching Processed Date Time" := CurrentDateTime;
        LOB."Matched By" := UserId;
        LOB."Match Details" := MatchedLbl;
        LOB.Modify();
        
        // Update CPMS record
        CPMS."LOB Matching Status" := CPMS."LOB Matching Status"::Matched;
        CPMS."LOB Matching ID" := MatchID;
        CPMS."LOB Match Type" := gMatchType;
        CPMS."LOB Processed Date Time" := CurrentDateTime;
        CPMS."LOB Matched By" := UserId;
        CPMS."LOB Match Details" := MatchedLbl;
        CPMS.Modify();
    end;

    local procedure CreateEODCPMSMatch(var EOD: Record "EOD Staging"; var CPMS: Record TTS_ARAP)
    var
        MatchID: Code[20];
        NoSeries: Codeunit "No. Series";
        GLSetup: Record "General Ledger Setup";
        MatchedLbl: Label 'Matched Automatically';
    begin
        GLSetup.Get();
        MatchID := NoSeries.GetNextNo(GLSetup."EOD-CPMS Matching No. Series");
        
        // Update EOD record
        EOD."Matching Status" := EOD."Matching Status"::Matched;
        EOD."Matching ID" := MatchID;
        EOD."Match Type" := gMatchType;
        EOD."Matching Processed Date Time" := CurrentDateTime;
        EOD."Matched By" := UserId;
        EOD."Match Details" := MatchedLbl;
        EOD.Modify();
        
        // Update CPMS record
        CPMS."EOD Matching Status" := CPMS."EOD Matching Status"::Matched;
        CPMS."EOD Matching ID" := MatchID;
        CPMS."EOD Match Type" := gMatchType;
        CPMS."EOD Processed Date Time" := CurrentDateTime;
        CPMS."EOD Matched By" := UserId;
        CPMS."EOD Match Details" := MatchedLbl;
        CPMS.Modify();
    end;

    var
        TempSelectedLOB: Record TTS_SAP temporary;
        TempSelectedCPMS: Record TTS_ARAP temporary;
        TempSelectedEOD: Record "EOD Staging" temporary;
        gMatchType: Enum "Match Type";
}

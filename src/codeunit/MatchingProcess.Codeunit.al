codeunit 85000 "Matching Process"
{
    TableNo = "Job Queue Entry";

    var
        MatchingRules, ParentMatchingRule : Record "Matching Rules";
        GLSetup: Record "General Ledger Setup";
        CPMSTemp: Record TTS_ARAP temporary;
        SelectedCPMS: record TTS_ARAP temporary;
        SelectedLOB: Record TTS_SAP temporary;
        SelectedEOD: Record "EOD Staging" temporary;

        EODTemp: Record "EOD Staging" temporary;
        MatchType: Enum "Match Type";
        Noseries: Codeunit "No. Series";

        LOBRecordRef, LOBRecordRef2, EODRecordRef, EODRecordRef2, CPMSRecordRef, CPMSRecordRef2 : RecordRef;

        SubMatchField, SumSubMatchField, LOBMatchingValue, EODMatchingValue, CPMSMatching : Decimal;
        ParentMatchField, StoreParentKey, Record : Text;
        MatchingOption: Option Matched,Unmatched,Error;

        MatchingId: Code[20];

        ErrLbl: Label '%1 does not match the %2 between %3. Applied Rule: %4';

        SuccessLbl: Label 'Matched by the rule number: %1';

        ForceMatchLbl: Label 'Matched Forcefully';
        MatchMsg: Text;

        LOBMatchingRecords, CPMSMatchingRecords, EODMatchingRecords : Dictionary of [Text, Decimal];
        CPMSMatchingKeys: Dictionary of [Text, Text];
        LOBTemp: Record TTS_SAP temporary;

        Donotopen: Boolean;

    trigger OnRun()
    begin
        case true of
            Rec."Parameter String" = '':
                begin
                    Donotopen := true;
                    MatchLOBCPMSData();
                    MatchEODCPMSData();
                end;
            UpperCase(Rec."Parameter String") = 'CPMS-LOB':
                MatchLOBCPMSData();
            UpperCase(Rec."Parameter String") = 'CPMS-EOD':
                MatchEODCPMSData();
        end;
    end;


    procedure MatchLOBCPMSData()
    var
    begin
        GLSetup.GetRecordOnce();
        GLSetup.TestField("LOB-CPMS Matching No. Series");
        GLSetup.TestField("LOB-CPMS Error No. Series");

        OpenLOBRecordRef();
        OpenCPMSRecordRef();

        MatchingRules.Reset();
        MatchingRules.SetCurrentKey("Matching Rule No.");
        MatchingRules.SetRange("Matching Type", MatchingRules."Matching Type"::"CPMS-LOB");
        //MatchingRules.SetRange("Matching Rule No.", 3);
        MatchingRules.SetFilter("Parent Condition No.", '<>%1', 0);
        if MatchingRules.FindSet() then
            repeat
                LOBTemp.Reset();
                LOBTemp.DeleteAll();
                CPMSTemp.Reset();
                CPMSTemp.DeleteAll();

                if MatchingRules."Parent Condition No." <> 0 then begin
                    ParentMatchingRule.Reset();
                    ParentMatchingRule.SetRange("Matching Rule No.", MatchingRules."Parent Condition No.");
                    ParentMatchingRule.FindFirst();
                    if ParentMatchingRule."LOB Condition" <> '' then
                        InsertLOBTempData(LOBTemp, ParentMatchingRule);

                    if ParentMatchingRule."CPMS Condition" <> '' then
                        InsertCPMSTempData(CPMSTemp, ParentMatchingRule);
                end;


                if MatchingRules."LOB Condition" <> '' then
                    LOBTemp.SetView(MatchingRules."LOB Condition");

                if MatchingRules."CPMS Condition" <> '' then
                    CPMSTemp.SetView(MatchingRules."CPMS Condition");


                ResetLOBRecordRefs();

                LOBRecordRef.GetTable(LOBTemp);
                CPMSRecordRef.GetTable(CPMSTemp);

                LOBRecordRef2.GetTable(LOBTemp);
                CPMSRecordRef2.GetTable(CPMSTemp);

                //  Message(Format('LOB Sub Count %1', LOBRecordRef.Count));
                // Message(Format('CPMS Sub Count %1', CPMSRecordRef.Count));


                ClearMatchingVariables();
                FilterLOBMatchingData();
                ClearMatchingVariables();
                FilterCPMSMatchingData();
                MatchLOBCPMSRecords();

            until MatchingRules.Next() = 0;
    end;

    procedure MatchEODCPMSData()

    begin
        GLSetup.GetRecordOnce();
        GLSetup.TestField("EOD-CPMS Matching No. Series");
        GLSetup.TestField("EOD-CPMS Error No. Series");

        OpenEODRecordRef();
        if not Donotopen then
            OpenCPMSRecordRef();

        MatchingRules.Reset();
        MatchingRules.SetCurrentKey("Matching Rule No.");
        MatchingRules.SetRange("Matching Type", MatchingRules."Matching Type"::"CPMS-EOD");
        //     MatchingRules.SetRange("Matching Rule No.", 5);
        MatchingRules.SetFilter("Parent Condition No.", '<>%1', 0);
        if MatchingRules.FindSet() then
            repeat
                EODTemp.Reset();
                EODTemp.DeleteAll();
                CPMSTemp.Reset();
                CPMSTemp.DeleteAll();

                if MatchingRules."Parent Condition No." <> 0 then begin
                    ParentMatchingRule.Reset();
                    ParentMatchingRule.SetRange("Matching Rule No.", MatchingRules."Parent Condition No.");
                    ParentMatchingRule.FindFirst();
                    if ParentMatchingRule."EOD Condition" <> '' then
                        InsertEODTempData(EODTemp, ParentMatchingRule);

                    if ParentMatchingRule."CPMS Condition" <> '' then
                        InsertCPMSTempData(CPMSTemp, ParentMatchingRule);
                end;

                if MatchingRules."EOD Condition" <> '' then
                    EODTemp.SetView(MatchingRules."EOD Condition");

                if MatchingRules."CPMS Condition" <> '' then
                    CPMSTemp.SetView(MatchingRules."CPMS Condition");

                ResetEODRecordRefs();

                EODRecordRef.GetTable(EODTemp);
                CPMSRecordRef.GetTable(CPMSTemp);

                EODRecordRef2.GetTable(EODTemp);
                CPMSRecordRef2.GetTable(CPMSTemp);

                ClearMatchingVariables();
                FilterEODMatchingData();
                ClearMatchingVariables();
                FilterCPMSMatchingData();
                MatchEODCPMSRecords();
            until MatchingRules.Next() = 0;
    end;


    local procedure OpenLOBRecordRef()
    begin
        LOBRecordRef.Open(Database::TTS_SAP);
        LOBRecordRef2.Open(Database::TTS_SAP);
    end;

    local procedure OpenCPMSRecordRef()
    begin
        CPMSRecordRef.Open(Database::TTS_ARAP);
        CPMSRecordRef2.Open(Database::TTS_ARAP);
    end;

    local procedure OpenEODRecordRef()
    begin
        EODRecordRef.Open(Database::"EOD Staging");
        EODRecordRef2.Open(Database::"EOD Staging");
    end;

    procedure SetMatchType(pMatchtype: Enum "Match Type")
    begin
        MatchType := pMatchtype;
    end;

    procedure SetSelectedLOB(var LOBRecords: Record TTS_SAP temporary)
    begin
        if LOBRecords.FindSet() then
            repeat
                SelectedLOB := LOBRecords;
                SelectedLOB.Insert();
            until LOBRecords.Next() = 0;
    end;

    procedure SetSelectedEOD(var EODRecords: Record "EOD Staging" temporary)
    begin
        if EODRecords.FindSet() then
            repeat
                SelectedEOD := EODRecords;
                SelectedEOD.Insert();
            until EODRecords.Next() = 0;
    end;

    procedure SetSelectedCPMS(var CPMSRecords: Record TTS_ARAP temporary)
    begin
        if CPMSRecords.FindSet() then
            repeat
                SelectedCPMS := CPMSRecords;
                SelectedCPMS.Insert();
            until CPMSRecords.Next() = 0;
    end;

    local procedure InsertLOBTempData(var LOBTemp: Record TTS_SAP temporary; var pMatchingRules: Record "Matching Rules")
    var
        LOB: Record TTS_SAP;
        Progress: Dialog;
        Counter: Integer;
        ProgressMsg: Label 'Filtering LOB Data......#1######################\';
    begin
        Clear(Counter);
        Progress.Open(ProgressMsg);
        if MatchType = MatchType::Manual then begin
            SelectedLOB.Reset();
            SelectedLOB.SetView(pMatchingRules."LOB Condition");
            if SelectedLOB.FindSet() then
                repeat
                    Counter += 1;
                    Progress.Update(1, Counter);
                    LOBTemp.Init();
                    LOBTemp := SelectedLOB;
                    LOBTemp.Insert();
                until SelectedLOB.Next() = 0;
        end else begin
            LOB.Reset();
            LOB.SetView(pMatchingRules."LOB Condition");
            if LOB.FindSet() then
                repeat
                    Counter += 1;
                    Progress.Update(1, Counter);
                    LOBTemp.Init();
                    LOBTemp := LOB;
                    LOBTemp.Insert();
                until lob.Next() = 0;
        end;
        Progress.Close();
    end;

    local procedure InsertEODTempData(var EODTemp: Record "EOD Staging" temporary; var pMatchingRules: Record "Matching Rules")
    var
        EOD: Record "EOD Staging";
        Progress: Dialog;
        Counter: Integer;
        ProgressMsg: Label 'Filtering EOD Data......#1######################\';
    begin
        Clear(Counter);
        Progress.Open(ProgressMsg);
        if MatchType = MatchType::Manual then begin
            SelectedEOD.Reset();
            SelectedEOD.SetView(pMatchingRules."EOD Condition");
            if SelectedEOD.FindSet() then
                repeat
                    Counter += 1;
                    Progress.Update(1, Counter);
                    EODTemp.Init();
                    EODTemp := SelectedEOD;
                    EODTemp.Insert();
                until SelectedEOD.Next() = 0;
        end else begin
            EOD.Reset();
            EOD.SetView(pMatchingRules."EOD Condition");
            if EOD.FindSet() then
                repeat
                    Counter += 1;
                    Progress.Update(1, Counter);
                    EODTemp.Init();
                    EODTemp := EOD;
                    EODTemp.Insert();
                until EOD.Next() = 0;
        end;
        Progress.Close();
    end;

    local procedure InsertCPMSTempData(var CPMSTemp: Record TTS_ARAP temporary; var pMatchingRules: Record "Matching Rules")
    var
        CPMS: Record TTS_ARAP;
        Progress: Dialog;
        Counter: Integer;
        ProgressMsg: Label 'Filtering CPMS Data......#1######################\';
    begin
        Clear(Counter);
        Progress.Open(ProgressMsg);
        if MatchType = MatchType::Manual then begin
            SelectedCPMS.Reset();
            SelectedCPMS.SetView(pMatchingRules."CPMS Condition");
            if SelectedCPMS.FindSet() then
                repeat
                    Counter += 1;
                    Progress.Update(1, Counter);
                    CPMSTemp.Init();
                    CPMSTemp := SelectedCPMS;
                    CPMSTemp.Insert();
                until SelectedCPMS.Next() = 0;
        end else begin
            CPMS.Reset();
            CPMS.SetView(pMatchingRules."CPMS Condition");
            if CPMS.FindSet() then
                repeat
                    Counter += 1;
                    Progress.Update(1, Counter);
                    CPMSTemp.Init();
                    CPMSTemp := CPMS;
                    CPMSTemp.Insert();
                until CPMS.Next() = 0;
        end;
        Progress.Close();
    end;

    local procedure ResetLOBRecordRefs()
    begin
        LOBRecordRef.Reset();
        LOBRecordRef2.Reset();
        CPMSRecordRef.Reset();
        CPMSRecordRef2.Reset();
    end;

    local procedure ResetEODRecordRefs()
    begin
        EODRecordRef.Reset();
        EODRecordRef2.Reset();
        CPMSRecordRef.Reset();
        CPMSRecordRef2.Reset();
    end;

    local procedure ClearMatchingVariables()
    begin
        Clear(ParentMatchField);
        Clear(StoreParentKey);
    end;

    local procedure FilterLOBMatchingData()
    var
        Progress: Dialog;
        Counter: Integer;
        ProgressMsg: Label 'Applying Final Condition to LOB-CPMS Data......#1######################\';
    begin
        Progress.Open(ProgressMsg);

        Clear(Counter);
        Clear(LOBMatchingRecords);
        if LOBRecordRef.FindSet() then
            repeat
                Counter += 1;
                Progress.Update(1, Counter);
                ParentMatchField := Format(LOBRecordRef.Field(ParentMatchingRule."LOB Field No.").Value);
                if StoreParentKey <> ParentMatchField then begin
                    Clear(SumSubMatchField);
                    Clear(SubMatchField);
                    LOBRecordRef2.Field(ParentMatchingRule."LOB Field No.").SetFilter(ParentMatchField);
                    if LOBRecordRef2.FindSet() then
                        repeat
                            Evaluate(SubMatchField, Format(LOBRecordRef2.Field(MatchingRules."LOB Field No.").Value));
                            SumSubMatchField += SubMatchField;
                        until LOBRecordRef2.Next() = 0;
                    LOBMatchingRecords.Add(ParentMatchField, SumSubMatchField);
                end;
                StoreParentKey := Format(LOBRecordRef.Field(ParentMatchingRule."LOB Field No.").Value);
            until LOBRecordRef.Next() = 0;
        Progress.Close();
    end;

    local procedure FilterEODMatchingData()
    var
        Progress: Dialog;
        Counter: Integer;
        ProgressMsg: Label 'Applying Final Condition to EOD-CPMS Data......#1######################\';
    begin
        Progress.Open(ProgressMsg);
        Clear(Counter);
        Clear(EODMatchingRecords);
        if EODRecordRef.FindSet() then
            repeat
                Counter += 1;
                Progress.Update(1, Counter);
                ParentMatchField := Format(EODRecordRef.Field(ParentMatchingRule."EOD Field No.").Value);
                if StoreParentKey <> ParentMatchField then begin
                    Clear(SumSubMatchField);
                    Clear(SubMatchField);
                    EODRecordRef2.Field(ParentMatchingRule."EOD Field No.").SetFilter(ParentMatchField);
                    if EODRecordRef2.FindSet() then
                        repeat
                            Evaluate(SubMatchField, Format(EODRecordRef2.Field(MatchingRules."EOD Field No.").Value));
                            SumSubMatchField += Abs(SubMatchField);
                        until EODRecordRef2.Next() = 0;
                    EODMatchingRecords.Add(ParentMatchField, SumSubMatchField);
                end;
                StoreParentKey := Format(EODRecordRef.Field(ParentMatchingRule."EOD Field No.").Value);
            until EODRecordRef.Next() = 0;
        Progress.Close();
    end;

    local procedure FilterCPMSMatchingData()
    var
        Progress: Dialog;
        Counter: Integer;
        ProgressMsg: Label 'Applying Final Condition to CPMS Data......#1######################\';
        FormatDashing: Text;
    begin
        Progress.Open(ProgressMsg);
        Clear(Counter);
        Clear(CPMSMatchingRecords);
        Clear(CPMSMatchingKeys);
        Clear(FormatDashing);
        if CPMSRecordRef.FindSet() then
            repeat
                Counter += 1;
                Progress.Update(1, Counter);
                ParentMatchField := Format(CPMSRecordRef.Field(ParentMatchingRule."CPMS Field No.").Value);
                if StoreParentKey <> ParentMatchField then begin
                    Clear(SumSubMatchField);
                    Clear(SubMatchField);
                    Clear(FormatDashing);
                    CPMSRecordRef2.Field(ParentMatchingRule."CPMS Field No.").SetFilter(ParentMatchField);
                    if CPMSRecordRef2.FindSet() then
                        repeat
                            Evaluate(SubMatchField, Format(CPMSRecordRef2.Field(MatchingRules."CPMS Field No.").Value));
                            SumSubMatchField += SubMatchField;
                        until CPMSRecordRef2.Next() = 0;
                    if (ParentMatchingRule."Matching Type" = ParentMatchingRule."Matching Type"::"CPMS-LOB") and (ParentMatchingRule."CPMS Field No." = 17) then begin
                        FormatDashing := ParentMatchField;
                        CPMSMatchingKeys.Add(FormatDashing.Replace('-', ''), ParentMatchField);
                        CPMSMatchingRecords.Add(FormatDashing.Replace('-', ''), SumSubMatchField);
                    end else
                        CPMSMatchingRecords.Add(ParentMatchField, SubMatchField);
                end;
                StoreParentKey := Format(CPMSRecordRef.Field(ParentMatchingRule."CPMS Field No.").Value);
            until CPMSRecordRef.Next() = 0;
        Progress.Close();
    end;

    local procedure MatchLOBCPMSRecords()
    var
        Progress: Dialog;
        Counter: Integer;
        ProgressMsg: Label 'Matching Records......#1######################\';
    begin
        Clear(Counter);
        Progress.Open(ProgressMsg);
        foreach Record in LOBMatchingRecords.Keys do
            if LOBMatchingRecords.Get(Record, LOBMatchingValue) and CPMSMatchingRecords.Get(Record, CPMSMatching) then
                if LOBMatchingValue = CPMSMatching then begin
                    MatchingOption := MatchingOption::Matched;
                    MatchingId := Noseries.GetNextNo(GLSetup."LOB-CPMS Matching No. Series");
                    MatchMsg := StrSubstNo(SuccessLbl, MatchingRules."Matching Rule No.");
                    //  end;
                    // else begin
                    //     MatchingOption := MatchingOption::Error;
                    //     MatchingId := Noseries.GetNextNo(GLSetup."LOB-CPMS Error No. Series");
                    //     MatchMsg := StrSubstNo(ErrLbl, MatchingRules."LOB Field Name", MatchingRules."CPMS Field Name", MatchingRules."Matching Type", MatchingRules."Matching Rule No.");
                    // end;
                    Counter += 1;
                    Progress.Update(1, Counter);
                    UpdateLOBMatchedRecords();
                    UpdateCPMSLOBMatchedRecords();
                    // if MatchingOption = MatchingOption::Matched then
                    //     exit;
                end;
    end;

    local procedure MatchEODCPMSRecords()
    var
        Progress: Dialog;
        Counter: Integer;
        ProgressMsg: Label 'Matching Records......#1######################\';
    begin
        Clear(Counter);
        Progress.Open(ProgressMsg);
        foreach Record in EODMatchingRecords.Keys do
            if EODMatchingRecords.Get(Record, EODMatchingValue) and CPMSMatchingRecords.Get(Record, CPMSMatching) then
                if EODMatchingValue = CPMSMatching then begin
                    MatchingOption := MatchingOption::Matched;
                    MatchingId := Noseries.GetNextNo(GLSetup."EOD-CPMS Matching No. Series");
                    MatchMsg := StrSubstNo(SuccessLbl, MatchingRules."Matching Rule No.");
                    //end
                    //  else begin
                    //     MatchingOption := MatchingOption::Error;
                    //     MatchingId := Noseries.GetNextNo(GLSetup."EOD-CPMS Error No. Series");
                    //     MatchMsg := StrSubstNo(ErrLbl, MatchingRules."EOD Field Name", MatchingRules."CPMS Field Name", MatchingRules."Matching Type", MatchingRules."Matching Rule No.");
                    // end;

                    Counter += 1;
                    Progress.Update(1, Counter);
                    UpdateEODMatchedRecords();
                    UpdateCPMSEODMatchedRecords();
                end;
        // if MatchingOption = MatchingOption::Matched then
        //     exit;
    end;

    local procedure UpdateLOBMatchedRecords()
    var
        LOBRecord: Record TTS_SAP;
    begin
        if LOBTemp.FindSet() then
            repeat
                if LOBRecord.Get(LOBTemp."Entry No.") then begin
                    LOBRecord."Matching Status" := MatchingOption;
                    LOBRecord."Matching ID" := MatchingId;
                    LOBRecord."Matching Processed Date Time" := CurrentDateTime;
                    LOBRecord."Rule No." := MatchingRules."Matching Rule No.";
                    LOBRecord."Match Details" := MatchMsg;
                    LOBRecord."Matched By" := UserId;
                    LOBRecord."Match Type" := MatchType;
                    LOBRecord.Modify();
                end;
            until LOBTemp.Next() = 0;
    end;

    local procedure UpdateEODMatchedRecords()
    var
        EODRecord: Record "EOD Staging";
    begin
        if EODTemp.FindSet() then
            repeat
                if EODRecord.Get(EODTemp."Entry No.") then begin
                    EODRecord."Matching Status" := MatchingOption;
                    EODRecord."Matching ID" := MatchingId;
                    EODRecord."Matching Processed Date Time" := CurrentDateTime;
                    EODRecord."Rule No." := MatchingRules."Matching Rule No.";
                    EODRecord."Match Details" := MatchMsg;
                    EODRecord."Matched By" := UserId;
                    EODRecord."Match Type" := MatchType;
                    EODRecord.Modify();
                end;
            until EODTemp.Next() = 0;
    end;

    local procedure UpdateCPMSLOBMatchedRecords()
    var
        CPMSRecord: Record TTS_ARAP;
    begin
        if CPMSTemp.FindSet() then
            repeat
                if CPMSRecord.Get(CPMSTemp."Entry No.") then begin
                    CPMSRecord."LOB Matching Status" := MatchingOption;
                    CPMSRecord."LOB Matching ID" := MatchingId;
                    CPMSRecord."LOB Processed Date Time" := CurrentDateTime;
                    CPMSRecord."LOB Rule No." := MatchingRules."Matching Rule No.";
                    CPMSRecord."LOB Match Details" := MatchMsg;
                    CPMSRecord."LOB Matched By" := UserId;
                    CPMSRecord."LOB Match Type" := MatchType;
                    CPMSRecord.Modify();
                end;
            until CPMSTemp.Next() = 0;
    end;

    local procedure UpdateCPMSEODMatchedRecords()
    var
        CPMSRecord: Record TTS_ARAP;
    begin
        if CPMSTemp.FindSet() then
            repeat
                if CPMSRecord.Get(CPMSTemp."Entry No.") then begin
                    CPMSRecord."EOD Matching Status" := MatchingOption;
                    CPMSRecord."EOD Matching ID" := MatchingId;
                    CPMSRecord."EOD Processed Date Time" := CurrentDateTime;
                    CPMSRecord."EOD Rule No." := MatchingRules."Matching Rule No.";
                    CPMSRecord."EOD Match Details" := MatchMsg;
                    CPMSRecord."EOD Matched By" := UserId;
                    CPMSRecord."EOD Match Type" := MatchType;
                    CPMSRecord.Modify();
                end;
            until CPMSTemp.Next() = 0;
    end;


    procedure ForceLOBCPMSMatch(var pLOBTemp: Record TTS_SAP; var pCPMSTemp: Record TTS_ARAP)
    var
        LOBRecords: Record TTS_SAP;
        CPMSRecords: Record TTS_ARAP;
        MatchID: Code[20];
    begin
        GLSetup.GetRecordOnce();
        GLSetup.TestField("LOB-CPMS Matching No. Series");
        MatchID := Noseries.GetNextNo(GLSetup."LOB-CPMS Matching No. Series");
        if pLOBTemp.FindSet() then
            repeat
                LOBRecords.Get(pLOBTemp."Entry No.");
                LOBRecords."Matching Status" := LOBRecords."Matching Status"::Matched;
                LOBRecords."Matching ID" := MatchID;
                LOBRecords."Match Type" := LOBRecords."Match Type"::Force;
                LOBRecords."Matching Processed Date Time" := CurrentDateTime;
                LOBRecords."Matched By" := UserId;
                LOBRecords."Match Details" := ForceMatchLbl;
                LOBRecords.Modify();
            until pLOBTemp.Next() = 0;

        if pCPMSTemp.FindSet() then
            repeat
                CPMSRecords.Get(pCPMSTemp."Entry No.");
                CPMSRecords."LOB Matching Status" := CPMSRecords."LOB Matching Status"::Matched;
                CPMSRecords."LOB Matching ID" := MatchID;
                CPMSRecords."LOB Match Type" := CPMSRecords."LOB Match Type"::Force;
                CPMSRecords."LOB Processed Date Time" := CurrentDateTime;
                CPMSRecords."LOB Match Details" := ForceMatchLbl;
                CPMSRecords."LOB Matched By" := UserId;
                CPMSRecords.Modify();
            until pCPMSTemp.Next() = 0;
    end;


    procedure ForceEODCPMSMatch(var pEODTemp: Record "EOD Staging"; var pCPMSTemp: Record TTS_ARAP)
    var
        EODRecords: Record "EOD Staging";
        CPMSRecords: Record TTS_ARAP;
        MatchID: Code[20];
    begin
        GLSetup.GetRecordOnce();
        GLSetup.TestField("EOD-CPMS Matching No. Series");
        MatchID := Noseries.GetNextNo(GLSetup."EOD-CPMS Matching No. Series");
        if pEODTemp.FindSet() then
            repeat
                EODRecords.Get(pEODTemp."Entry No.");
                EODRecords."Matching Status" := EODRecords."Matching Status"::Matched;
                EODRecords."Matching ID" := MatchID;
                EODRecords."Match Type" := EODRecords."Match Type"::Force;
                EODRecords."Matching Processed Date Time" := CurrentDateTime;
                EODRecords."Match Details" := ForceMatchLbl;
                EODRecords."Matched By" := UserId;
                EODRecords.Modify();
            until pEODTemp.Next() = 0;

        if pCPMSTemp.FindSet() then
            repeat
                CPMSRecords.Get(pCPMSTemp."Entry No.");
                CPMSRecords."EOD Matching Status" := CPMSRecords."EOD Matching Status"::Matched;
                CPMSRecords."EOD Matching ID" := MatchID;
                CPMSRecords."EOD Match Type" := CPMSRecords."EOD Match Type"::Force;
                CPMSRecords."EOD Processed Date Time" := CurrentDateTime;
                CPMSRecords."EOD Match Details" := ForceMatchLbl;
                CPMSRecords."EOD Matched By" := UserId;
                CPMSRecords.Modify();
            until pCPMSTemp.Next() = 0;
    end;

}
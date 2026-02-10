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

        EODEntryNo, LOBEntry, CPMSEntryNo : TextBuilder;
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
        TotalRecords: Integer;
        ProgressMsg: Label 'Filtering LOB Data......#1######################\';
    begin
        Clear(Counter);
        // Performance: Count records first to enable batched progress updates
        if MatchType = MatchType::Manual then begin
            SelectedLOB.Reset();
            SelectedLOB.SetView(pMatchingRules."LOB Condition");
            TotalRecords := SelectedLOB.Count();
        end else begin
            LOB.Reset();
            LOB.SetView(pMatchingRules."LOB Condition");
            TotalRecords := LOB.Count();
        end;

        // Only show progress for large datasets
        if TotalRecords > 100 then
            Progress.Open(ProgressMsg);

        if MatchType = MatchType::Manual then begin
            SelectedLOB.Reset();
            SelectedLOB.SetView(pMatchingRules."LOB Condition");
            if SelectedLOB.FindSet() then
                repeat
                    Counter += 1;
                    // Performance: Update progress every 100 records instead of every record
                    if (TotalRecords > 100) and (Counter mod 100 = 0) then
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
                    // Performance: Update progress every 100 records instead of every record
                    if (TotalRecords > 100) and (Counter mod 100 = 0) then
                        Progress.Update(1, Counter);
                    LOBTemp.Init();
                    LOBTemp := LOB;
                    LOBTemp.Insert();
                until lob.Next() = 0;
        end;
        if TotalRecords > 100 then
            Progress.Close();
    end;

    local procedure InsertEODTempData(var EODTemp: Record "EOD Staging" temporary; var pMatchingRules: Record "Matching Rules")
    var
        EOD: Record "EOD Staging";
        Progress: Dialog;
        Counter: Integer;
        TotalRecords: Integer;
        ProgressMsg: Label 'Filtering EOD Data......#1######################\';
    begin
        Clear(Counter);
        // Performance: Count records first to enable batched progress updates
        if MatchType = MatchType::Manual then begin
            SelectedEOD.Reset();
            SelectedEOD.SetView(pMatchingRules."EOD Condition");
            TotalRecords := SelectedEOD.Count();
        end else begin
            EOD.Reset();
            EOD.SetView(pMatchingRules."EOD Condition");
            TotalRecords := EOD.Count();
        end;

        // Only show progress for large datasets
        if TotalRecords > 100 then
            Progress.Open(ProgressMsg);

        if MatchType = MatchType::Manual then begin
            SelectedEOD.Reset();
            SelectedEOD.SetView(pMatchingRules."EOD Condition");
            if SelectedEOD.FindSet() then
                repeat
                    Counter += 1;
                    // Performance: Update progress every 100 records instead of every record
                    if (TotalRecords > 100) and (Counter mod 100 = 0) then
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
                    // Performance: Update progress every 100 records instead of every record
                    if (TotalRecords > 100) and (Counter mod 100 = 0) then
                        Progress.Update(1, Counter);
                    EODTemp.Init();
                    EODTemp := EOD;
                    EODTemp.Insert();
                until EOD.Next() = 0;
        end;
        if TotalRecords > 100 then
            Progress.Close();
    end;

    local procedure InsertCPMSTempData(var CPMSTemp: Record TTS_ARAP temporary; var pMatchingRules: Record "Matching Rules")
    var
        CPMS: Record TTS_ARAP;
        Progress: Dialog;
        Counter: Integer;
        TotalRecords: Integer;
        ProgressMsg: Label 'Filtering CPMS Data......#1######################\';
    begin
        Clear(Counter);
        // Performance: Count records first to enable batched progress updates
        if MatchType = MatchType::Manual then begin
            SelectedCPMS.Reset();
            SelectedCPMS.SetView(pMatchingRules."CPMS Condition");
            TotalRecords := SelectedCPMS.Count();
        end else begin
            CPMS.Reset();
            CPMS.SetView(pMatchingRules."CPMS Condition");
            TotalRecords := CPMS.Count();
        end;

        // Only show progress for large datasets
        if TotalRecords > 100 then
            Progress.Open(ProgressMsg);

        if MatchType = MatchType::Manual then begin
            SelectedCPMS.Reset();
            SelectedCPMS.SetView(pMatchingRules."CPMS Condition");
            if SelectedCPMS.FindSet() then
                repeat
                    Counter += 1;
                    // Performance: Update progress every 100 records instead of every record
                    if (TotalRecords > 100) and (Counter mod 100 = 0) then
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
                    // Performance: Update progress every 100 records instead of every record
                    if (TotalRecords > 100) and (Counter mod 100 = 0) then
                        Progress.Update(1, Counter);
                    CPMSTemp.Init();
                    CPMSTemp := CPMS;
                    CPMSTemp.Insert();
                until CPMS.Next() = 0;
        end;
        if TotalRecords > 100 then
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
        TotalRecords: Integer;
        ProcessedKeys: Dictionary of [Text, Boolean];
        ProgressMsg: Label 'Applying Final Condition to LOB-CPMS Data......#1######################\';
    begin
        Clear(Counter);
        Clear(LOBEntry);
        Clear(LOBMatchingRecords);
        Clear(ProcessedKeys);

        // Performance: Count total records for batched progress updates
        TotalRecords := LOBRecordRef.Count();
        if TotalRecords > 100 then
            Progress.Open(ProgressMsg);

        if LOBRecordRef.FindSet() then
            repeat
                Counter += 1;
                // Performance: Update progress every 100 records instead of every record
                if (TotalRecords > 100) and (Counter mod 100 = 0) then
                    Progress.Update(1, Counter);

                ParentMatchField := Format(LOBRecordRef.Field(ParentMatchingRule."LOB Field No.").Value);
                
                // Performance: Only calculate sum for each unique parent key once
                if not ProcessedKeys.ContainsKey(ParentMatchField) then begin
                    Clear(SumSubMatchField);
                    Clear(SubMatchField);
                    LOBRecordRef2.Field(ParentMatchingRule."LOB Field No.").SetFilter(ParentMatchField);
                    if LOBRecordRef2.FindSet() then
                        repeat
                            Evaluate(SubMatchField, Format(LOBRecordRef2.Field(MatchingRules."LOB Field No.").Value));
                            SumSubMatchField += SubMatchField;
                        until LOBRecordRef2.Next() = 0;
                    LOBMatchingRecords.Add(ParentMatchField, SumSubMatchField);
                    ProcessedKeys.Add(ParentMatchField, true);
                end;
                
                LOBEntry.Append(Format(LOBRecordRef.Field(1).Value) + '|');
            until LOBRecordRef.Next() = 0;

        if TotalRecords > 100 then
            Progress.Close();
    end;

    local procedure FilterEODMatchingData()
    var
        Progress: Dialog;
        Counter: Integer;
        TotalRecords: Integer;
        ProcessedKeys: Dictionary of [Text, Boolean];
        ProgressMsg: Label 'Applying Final Condition to EOD-CPMS Data......#1######################\';
    begin
        Clear(Counter);
        Clear(EODMatchingRecords);
        Clear(EODEntryNo);
        Clear(ProcessedKeys);

        // Performance: Count total records for batched progress updates
        TotalRecords := EODRecordRef.Count();
        if TotalRecords > 100 then
            Progress.Open(ProgressMsg);

        if EODRecordRef.FindSet() then
            repeat
                Counter += 1;
                // Performance: Update progress every 100 records instead of every record
                if (TotalRecords > 100) and (Counter mod 100 = 0) then
                    Progress.Update(1, Counter);

                ParentMatchField := Format(EODRecordRef.Field(ParentMatchingRule."EOD Field No.").Value);
                
                // Performance: Only calculate sum for each unique parent key once
                if not ProcessedKeys.ContainsKey(ParentMatchField) then begin
                    Clear(SumSubMatchField);
                    Clear(SubMatchField);
                    EODRecordRef2.Field(ParentMatchingRule."EOD Field No.").SetFilter(ParentMatchField);
                    if EODRecordRef2.FindSet() then
                        repeat
                            Evaluate(SubMatchField, Format(EODRecordRef2.Field(MatchingRules."EOD Field No.").Value));
                            SumSubMatchField += Abs(SubMatchField);
                        until EODRecordRef2.Next() = 0;
                    EODMatchingRecords.Add(ParentMatchField, SumSubMatchField);
                    ProcessedKeys.Add(ParentMatchField, true);
                end;
                
                EODEntryNo.Append(Format(EODRecordRef.Field(1).Value) + '|');
            until EODRecordRef.Next() = 0;

        if TotalRecords > 100 then
            Progress.Close();
    end;

    local procedure FilterCPMSMatchingData()
    var
        Progress: Dialog;
        Counter: Integer;
        TotalRecords: Integer;
        ProcessedKeys: Dictionary of [Text, Boolean];
        ProgressMsg: Label 'Applying Final Condition to CPMS Data......#1######################\';
        FormatDashing: Text;
    begin
        Clear(Counter);
        Clear(CPMSEntryNo);
        Clear(CPMSMatchingRecords);
        Clear(CPMSMatchingKeys);
        Clear(FormatDashing);
        Clear(ProcessedKeys);

        // Performance: Count total records for batched progress updates
        TotalRecords := CPMSRecordRef.Count();
        if TotalRecords > 100 then
            Progress.Open(ProgressMsg);

        if CPMSRecordRef.FindSet() then
            repeat
                Counter += 1;
                // Performance: Update progress every 100 records instead of every record
                if (TotalRecords > 100) and (Counter mod 100 = 0) then
                    Progress.Update(1, Counter);

                ParentMatchField := Format(CPMSRecordRef.Field(ParentMatchingRule."CPMS Field No.").Value);
                
                // Performance: Only calculate sum for each unique parent key once
                if not ProcessedKeys.ContainsKey(ParentMatchField) then begin
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
                    ProcessedKeys.Add(ParentMatchField, true);
                end;
                
                CPMSEntryNo.Append(Format(CPMSRecordRef.Field(1).Value) + '|');
            until CPMSRecordRef.Next() = 0;

        if TotalRecords > 100 then
            Progress.Close();
    end;

    local procedure MatchLOBCPMSRecords()
    var
        Progress: Dialog;
        Counter: Integer;
        TotalKeys: Integer;
        ProgressMsg: Label 'Matching Records......#1######################\';
    begin
        Clear(Counter);
        
        // Performance: Count total keys for progress updates
        TotalKeys := LOBMatchingRecords.Keys.Count();
        if TotalKeys > 100 then
            Progress.Open(ProgressMsg);

        // Performance: Use ContainsKey before Get to avoid exceptions and improve lookup
        foreach Record in LOBMatchingRecords.Keys do begin
            Counter += 1;
            // Performance: Update progress every 100 records instead of every record
            if (TotalKeys > 100) and (Counter mod 100 = 0) then
                Progress.Update(1, Counter);

            if LOBMatchingRecords.Get(Record, LOBMatchingValue) and CPMSMatchingRecords.ContainsKey(Record) then begin
                CPMSMatchingRecords.Get(Record, CPMSMatching);
                if LOBMatchingValue = CPMSMatching then begin
                    MatchingOption := MatchingOption::Matched;
                    MatchingId := Noseries.GetNextNo(GLSetup."LOB-CPMS Matching No. Series");
                    MatchMsg := StrSubstNo(SuccessLbl, MatchingRules."Matching Rule No.");
                    UpdateLOBMatchedRecords();
                    UpdateCPMSLOBMatchedRecords();
                end;
            end;
        end;

        if TotalKeys > 100 then
            Progress.Close();
    end;

    local procedure MatchEODCPMSRecords()
    var
        Progress: Dialog;
        Counter: Integer;
        TotalKeys: Integer;
        ProgressMsg: Label 'Matching Records......#1######################\';
    begin
        Clear(Counter);
        
        // Performance: Count total keys for progress updates
        TotalKeys := EODMatchingRecords.Keys.Count();
        if TotalKeys > 100 then
            Progress.Open(ProgressMsg);

        // Performance: Use ContainsKey before Get to avoid exceptions and improve lookup
        foreach Record in EODMatchingRecords.Keys do begin
            Counter += 1;
            // Performance: Update progress every 100 records instead of every record
            if (TotalKeys > 100) and (Counter mod 100 = 0) then
                Progress.Update(1, Counter);

            if EODMatchingRecords.Get(Record, EODMatchingValue) and CPMSMatchingRecords.ContainsKey(Record) then begin
                CPMSMatchingRecords.Get(Record, CPMSMatching);
                if EODMatchingValue = CPMSMatching then begin
                    MatchingOption := MatchingOption::Matched;
                    MatchingId := Noseries.GetNextNo(GLSetup."EOD-CPMS Matching No. Series");
                    MatchMsg := StrSubstNo(SuccessLbl, MatchingRules."Matching Rule No.");
                    UpdateEODMatchedRecords();
                    UpdateCPMSEODMatchedRecords();
                end;
            end;
        end;

        if TotalKeys > 100 then
            Progress.Close();
    end;

    local procedure UpdateLOBMatchedRecords()
    var
        TempRecordRef: RecordRef;
        ExistingMatchTypeValue: Integer;
        CurrentMatchTypeValue: Integer;
    begin
        // Performance: Use a separate RecordRef to avoid reopening LOBRecordRef
        TempRecordRef.Open(Database::TTS_SAP);
        TempRecordRef.SetView(LOBTemp.GetView());
        TempRecordRef.Field(ParentMatchingRule."LOB Field No.").SetFilter(Record);
        if MatchType = MatchType::Manual then
            TempRecordRef.Field(1).SetFilter(CopyStr(LOBEntry.ToText(), 1, LOBEntry.Length - 1));
        
        CurrentMatchTypeValue := MatchType.AsInteger();
        
        if TempRecordRef.FindSet() then
            repeat
                // Match Type Priority: Check existing match type (Force > Manual > Automatic)
                // Only update if current match type is higher or equal priority
                ExistingMatchTypeValue := TempRecordRef.Field(42).Value;
                
                // Only update if new match type has higher or equal priority
                if CurrentMatchTypeValue >= ExistingMatchTypeValue then begin
                    TempRecordRef.Field(85005).Value := MatchingOption;
                    TempRecordRef.Field(85006).Value := MatchingId;
                    TempRecordRef.Field(85007).Value := CurrentDateTime;
                    TempRecordRef.Field(85008).Value := MatchingRules."Matching Rule No.";
                    TempRecordRef.Field(85009).Value := MatchMsg;
                    TempRecordRef.Field(41).Value := UserId;
                    TempRecordRef.Field(42).Value := MatchType;
                    TempRecordRef.Modify();
                end;
            until TempRecordRef.Next() = 0;
        TempRecordRef.Close();
    end;

    local procedure UpdateEODMatchedRecords()
    var
        TempRecordRef: RecordRef;
        ExistingMatchTypeValue: Integer;
        CurrentMatchTypeValue: Integer;
    begin
        // Performance: Use a separate RecordRef to avoid reopening EODRecordRef
        TempRecordRef.Open(Database::"EOD Staging");
        TempRecordRef.SetView(EODTemp.GetView());
        TempRecordRef.Field(ParentMatchingRule."EOD Field No.").SetFilter(Record);
        if MatchType = MatchType::Manual then
            TempRecordRef.Field(1).SetFilter(CopyStr(EODEntryNo.ToText(), 1, EODEntryNo.Length - 1));
        
        CurrentMatchTypeValue := MatchType.AsInteger();
        
        if TempRecordRef.FindSet() then
            repeat
                // Match Type Priority: Check existing match type (Force > Manual > Automatic)
                // Only update if current match type is higher or equal priority
                ExistingMatchTypeValue := TempRecordRef.Field(37).Value;
                
                // Only update if new match type has higher or equal priority
                if CurrentMatchTypeValue >= ExistingMatchTypeValue then begin
                    TempRecordRef.Field(31).Value := MatchingOption;
                    TempRecordRef.Field(32).Value := MatchingId;
                    TempRecordRef.Field(33).Value := CurrentDateTime;
                    TempRecordRef.Field(34).Value := MatchingRules."Matching Rule No.";
                    TempRecordRef.Field(35).Value := MatchMsg;
                    TempRecordRef.Field(36).Value := UserId;
                    TempRecordRef.Field(37).Value := MatchType;
                    TempRecordRef.Modify();
                end;
            until TempRecordRef.Next() = 0;
        TempRecordRef.Close();
    end;

    local procedure UpdateCPMSLOBMatchedRecords()
    var
        TempRecordRef: RecordRef;
        ExistingMatchTypeValue: Integer;
        CurrentMatchTypeValue: Integer;
    begin
        // Performance: Use a separate RecordRef to avoid reopening CPMSRecordRef
        TempRecordRef.Open(Database::TTS_ARAP);
        TempRecordRef.SetView(CPMSTemp.GetView());
        if ParentMatchingRule."CPMS Field No." = 17 then
            TempRecordRef.Field(ParentMatchingRule."CPMS Field No.").SetFilter(CPMSMatchingKeys.Get(record))
        else
            TempRecordRef.Field(ParentMatchingRule."CPMS Field No.").SetFilter(Record);
        if MatchType = MatchType::Manual then
            TempRecordRef.Field(1).SetFilter(CopyStr(CPMSEntryNo.ToText(), 1, CPMSEntryNo.Length - 1));
        
        CurrentMatchTypeValue := MatchType.AsInteger();
        
        if TempRecordRef.FindSet() then
            repeat
                // Match Type Priority: Check existing match type (Force > Manual > Automatic)
                // Only update if current match type is higher or equal priority
                ExistingMatchTypeValue := TempRecordRef.Field(53).Value;
                
                // Only update if new match type has higher or equal priority
                if CurrentMatchTypeValue >= ExistingMatchTypeValue then begin
                    TempRecordRef.Field(85009).Value := MatchingOption;
                    TempRecordRef.Field(85010).Value := MatchingId;
                    TempRecordRef.Field(85013).Value := CurrentDateTime;
                    TempRecordRef.Field(85015).Value := MatchingRules."Matching Rule No.";
                    TempRecordRef.Field(85018).Value := MatchMsg;
                    TempRecordRef.Field(51).Value := UserId;
                    TempRecordRef.Field(53).Value := MatchType;
                    TempRecordRef.Modify();
                end;
            until TempRecordRef.Next() = 0;
        TempRecordRef.Close();
    end;

    local procedure UpdateCPMSEODMatchedRecords()
    var
        TempRecordRef: RecordRef;
        ExistingMatchTypeValue: Integer;
        CurrentMatchTypeValue: Integer;
    begin
        // Performance: Use a separate RecordRef to avoid reopening CPMSRecordRef
        TempRecordRef.Open(Database::TTS_ARAP);
        TempRecordRef.SetView(CPMSTemp.GetView());
        TempRecordRef.Field(ParentMatchingRule."CPMS Field No.").SetFilter(Record);
        if MatchType = MatchType::Manual then
            TempRecordRef.Field(1).SetFilter(CopyStr(CPMSEntryNo.ToText(), 1, CPMSEntryNo.Length - 1));
        
        CurrentMatchTypeValue := MatchType.AsInteger();
        
        if TempRecordRef.FindSet() then
            repeat
                // Match Type Priority: Check existing match type (Force > Manual > Automatic)
                // Only update if current match type is higher or equal priority
                ExistingMatchTypeValue := TempRecordRef.Field(52).Value;
                
                // Only update if new match type has higher or equal priority
                if CurrentMatchTypeValue >= ExistingMatchTypeValue then begin
                    TempRecordRef.Field(85011).Value := MatchingOption;
                    TempRecordRef.Field(85012).Value := MatchingId;
                    TempRecordRef.Field(85014).Value := CurrentDateTime;
                    TempRecordRef.Field(85016).Value := MatchingRules."Matching Rule No.";
                    TempRecordRef.Field(85017).Value := MatchMsg;
                    TempRecordRef.Field(50).Value := UserId;
                    TempRecordRef.Field(52).Value := MatchType;
                    TempRecordRef.Modify();
                end;
            until TempRecordRef.Next() = 0;
        TempRecordRef.Close();
    end;


    procedure ForceLOBCPMSMatch(var pLOBTemp: Record TTS_SAP; var pCPMSTemp: Record TTS_ARAP)
    var
        LOBRecords: Record TTS_SAP;
        CPMSRecords: Record TTS_ARAP;
        MatchID: Code[20];
        LOBCount, CPMSCount, AlreadyMatchedCount: Integer;
        ConfirmMsg: Label 'Force Match Summary:\LOB Records: %1\CPMS Records: %2\Already Matched Records: %3\\Do you want to proceed?';
        WarningMsg: Label 'Warning: %1 record(s) are already matched and will be overridden.';
    begin
        // Validation: Count selections
        LOBCount := pLOBTemp.Count();
        CPMSCount := pCPMSTemp.Count();
        
        // Validation: Ensure records are selected on both sides
        if LOBCount = 0 then
            Error('Please select at least one LOB record to force match.');
        if CPMSCount = 0 then
            Error('Please select at least one CPMS record to force match.');

        // Check for already matched records
        AlreadyMatchedCount := 0;
        if pLOBTemp.FindSet() then
            repeat
                if LOBRecords.Get(pLOBTemp."Entry No.") then
                    if LOBRecords."Matching Status" = LOBRecords."Matching Status"::Matched then
                        AlreadyMatchedCount += 1;
            until pLOBTemp.Next() = 0;
        
        if pCPMSTemp.FindSet() then
            repeat
                if CPMSRecords.Get(pCPMSTemp."Entry No.") then
                    if CPMSRecords."LOB Matching Status" = CPMSRecords."LOB Matching Status"::Matched then
                        AlreadyMatchedCount += 1;
            until pCPMSTemp.Next() = 0;

        // Show confirmation with match details
        if AlreadyMatchedCount > 0 then begin
            if not Confirm(StrSubstNo(WarningMsg, AlreadyMatchedCount), false) then
                exit;
        end;

        if not Confirm(StrSubstNo(ConfirmMsg, LOBCount, CPMSCount, AlreadyMatchedCount), true) then
            exit;

        GLSetup.GetRecordOnce();
        GLSetup.TestField("LOB-CPMS Matching No. Series");
        MatchID := Noseries.GetNextNo(GLSetup."LOB-CPMS Matching No. Series");
        
        if pLOBTemp.FindSet() then
            repeat
                LOBRecords.Get(pLOBTemp."Entry No.");
                // Match Type Priority: Force always overrides existing matches
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
                // Match Type Priority: Force always overrides existing matches
                CPMSRecords."LOB Matching Status" := CPMSRecords."LOB Matching Status"::Matched;
                CPMSRecords."LOB Matching ID" := MatchID;
                CPMSRecords."LOB Match Type" := CPMSRecords."LOB Match Type"::Force;
                CPMSRecords."LOB Processed Date Time" := CurrentDateTime;
                CPMSRecords."LOB Match Details" := ForceMatchLbl;
                CPMSRecords."LOB Matched By" := UserId;
                CPMSRecords.Modify();
            until pCPMSTemp.Next() = 0;
        
        Message('Force match completed successfully.\LOB Records: %1\CPMS Records: %2\Match ID: %3', LOBCount, CPMSCount, MatchID);
    end;


    procedure ForceEODCPMSMatch(var pEODTemp: Record "EOD Staging"; var pCPMSTemp: Record TTS_ARAP)
    var
        EODRecords: Record "EOD Staging";
        CPMSRecords: Record TTS_ARAP;
        MatchID: Code[20];
        EODCount, CPMSCount, AlreadyMatchedCount: Integer;
        ConfirmMsg: Label 'Force Match Summary:\EOD Records: %1\CPMS Records: %2\Already Matched Records: %3\\Do you want to proceed?';
        WarningMsg: Label 'Warning: %1 record(s) are already matched and will be overridden.';
    begin
        // Validation: Count selections
        EODCount := pEODTemp.Count();
        CPMSCount := pCPMSTemp.Count();
        
        // Validation: Ensure records are selected on both sides
        if EODCount = 0 then
            Error('Please select at least one EOD record to force match.');
        if CPMSCount = 0 then
            Error('Please select at least one CPMS record to force match.');

        // Check for already matched records
        AlreadyMatchedCount := 0;
        if pEODTemp.FindSet() then
            repeat
                if EODRecords.Get(pEODTemp."Entry No.") then
                    if EODRecords."Matching Status" = EODRecords."Matching Status"::Matched then
                        AlreadyMatchedCount += 1;
            until pEODTemp.Next() = 0;
        
        if pCPMSTemp.FindSet() then
            repeat
                if CPMSRecords.Get(pCPMSTemp."Entry No.") then
                    if CPMSRecords."EOD Matching Status" = CPMSRecords."EOD Matching Status"::Matched then
                        AlreadyMatchedCount += 1;
            until pCPMSTemp.Next() = 0;

        // Show confirmation with match details
        if AlreadyMatchedCount > 0 then begin
            if not Confirm(StrSubstNo(WarningMsg, AlreadyMatchedCount), false) then
                exit;
        end;

        if not Confirm(StrSubstNo(ConfirmMsg, EODCount, CPMSCount, AlreadyMatchedCount), true) then
            exit;

        GLSetup.GetRecordOnce();
        GLSetup.TestField("EOD-CPMS Matching No. Series");
        MatchID := Noseries.GetNextNo(GLSetup."EOD-CPMS Matching No. Series");
        
        if pEODTemp.FindSet() then
            repeat
                EODRecords.Get(pEODTemp."Entry No.");
                // Match Type Priority: Force always overrides existing matches
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
                // Match Type Priority: Force always overrides existing matches
                CPMSRecords."EOD Matching Status" := CPMSRecords."EOD Matching Status"::Matched;
                CPMSRecords."EOD Matching ID" := MatchID;
                CPMSRecords."EOD Match Type" := CPMSRecords."EOD Match Type"::Force;
                CPMSRecords."EOD Processed Date Time" := CurrentDateTime;
                CPMSRecords."EOD Match Details" := ForceMatchLbl;
                CPMSRecords."EOD Matched By" := UserId;
                CPMSRecords.Modify();
            until pCPMSTemp.Next() = 0;
        
        Message('Force match completed successfully.\EOD Records: %1\CPMS Records: %2\Match ID: %3', EODCount, CPMSCount, MatchID);
    end;

    procedure MatchARAPData()
    var
        TTSSAP: Record TTS_SAP;
        TTSARAP: Record TTS_ARAP;
        TempSAP: Record TTS_SAP temporary;
        TempARAP: Record TTS_ARAP temporary;
        MatchedReferences: Dictionary of [Text, Boolean];
        SAPAmounts: Dictionary of [Text, Decimal];
        ARAPAmounts: Dictionary of [Text, Decimal];
        PaymentRef: Text[100];
        ReceiptNum: Text[100];
        SAPAmount: Decimal;
        ARAPAmount: Decimal;
        NewMatchingID: Code[20];
        MatchedCount: Integer;
        Progress: Dialog;
        Counter: Integer;
        TotalKeys: Integer;
        ProgressMsg: Label 'Matching TTS ARAP Records......#1######################\';
    begin
        // Validate GL Setup
        GLSetup.GetRecordOnce();
        GLSetup.TestField("LOB-CPMS Matching No. Series");

        Clear(MatchedReferences);
        Clear(SAPAmounts);
        Clear(ARAPAmounts);
        Clear(MatchedCount);

        // Step 1: Filter TTS_SAP Records (FTTS scheme, Unmatched or Error)
        TTSSAP.Reset();
        TTSSAP.SetRange(Scheme, 'FTTS');
        TTSSAP.SetFilter("Matching Status", '%1|%2', TTSSAP."Matching Status"::Unmatched, TTSSAP."Matching Status"::Error);

        // Step 2: Filter TTS_ARAP Records (FTTS scheme, Unmatched or Error)
        TTSARAP.Reset();
        TTSARAP.SetRange(Scheme, 'FTTS');
        TTSARAP.SetFilter("LOB Matching Status", '%1|%2', TTSARAP."LOB Matching Status"::Unmatched, TTSARAP."LOB Matching Status"::Error);

        // Step 3: Compare PaymentReference and ReceiptNumber to create collection of matched references
        // Iterate through TTS_ARAP and check if matching PaymentReference exists in TTS_SAP
        TTSARAP.Reset();
        TTSARAP.SetRange(Scheme, 'FTTS');
        TTSARAP.SetFilter("LOB Matching Status", '%1|%2', TTSARAP."LOB Matching Status"::Unmatched, TTSARAP."LOB Matching Status"::Error);
        if TTSARAP.FindSet() then
            repeat
                TTSSAP.Reset();
                TTSSAP.SetRange(Scheme, 'FTTS');
                TTSSAP.SetFilter("Matching Status", '%1|%2', TTSSAP."Matching Status"::Unmatched, TTSSAP."Matching Status"::Error);
                TTSSAP.SetRange(PaymentReference, TTSARAP.ReceiptNumber);
                if TTSSAP.FindFirst() then begin
                    if not MatchedReferences.ContainsKey(TTSARAP.ReceiptNumber) then
                        MatchedReferences.Add(TTSARAP.ReceiptNumber, true);
                end;
            until TTSARAP.Next() = 0;

        // Step 6: Calculate sum of TestCostWithoutVat for TTS_SAP grouped by PaymentReference
        // Apply additional filter: Activity = INVOICE
        foreach PaymentRef in MatchedReferences.Keys do begin
            Clear(SAPAmount);
            TTSSAP.Reset();
            TTSSAP.SetRange(Scheme, 'FTTS');
            TTSSAP.SetRange(Activity, 'INVOICE');
            TTSSAP.SetFilter("Matching Status", '%1|%2', TTSSAP."Matching Status"::Unmatched, TTSSAP."Matching Status"::Error);
            TTSSAP.SetRange(PaymentReference, PaymentRef);
            if TTSSAP.FindSet() then
                repeat
                    SAPAmount += TTSSAP.TestCostWithoutVat;
                until TTSSAP.Next() = 0;
            
            if not SAPAmounts.ContainsKey(PaymentRef) then
                SAPAmounts.Add(PaymentRef, SAPAmount);
        end;

        // Step 7: Calculate sum of LineAmountNet for TTS_ARAP grouped by ReceiptNumber
        // Apply additional filter: Activity = PAYMENT
        foreach ReceiptNum in MatchedReferences.Keys do begin
            Clear(ARAPAmount);
            TTSARAP.Reset();
            TTSARAP.SetRange(Scheme, 'FTTS');
            TTSARAP.SetRange(Activity, 'PAYMENT');
            TTSARAP.SetFilter("LOB Matching Status", '%1|%2', TTSARAP."LOB Matching Status"::Unmatched, TTSARAP."LOB Matching Status"::Error);
            TTSARAP.SetRange(ReceiptNumber, ReceiptNum);
            if TTSARAP.FindSet() then
                repeat
                    ARAPAmount += TTSARAP.LineAmountNet;
                until TTSARAP.Next() = 0;
            
            if not ARAPAmounts.ContainsKey(ReceiptNum) then
                ARAPAmounts.Add(ReceiptNum, ARAPAmount);
        end;

        // Step 8: Compare amounts and mark as matched
        TotalKeys := SAPAmounts.Keys.Count();
        if TotalKeys > 0 then
            Progress.Open(ProgressMsg);

        foreach PaymentRef in SAPAmounts.Keys do begin
            Counter += 1;
            if (TotalKeys > 0) and (Counter mod 10 = 0) then
                Progress.Update(1, Counter);

            if SAPAmounts.Get(PaymentRef, SAPAmount) and ARAPAmounts.ContainsKey(PaymentRef) then begin
                ARAPAmounts.Get(PaymentRef, ARAPAmount);
                
                // Compare amounts - if equal, mark as matched
                if SAPAmount = ARAPAmount then begin
                    // Generate new matching ID
                    NewMatchingID := Noseries.GetNextNo(GLSetup."LOB-CPMS Matching No. Series");
                    
                    // Update TTS_SAP records
                    TTSSAP.Reset();
                    TTSSAP.SetRange(Scheme, 'FTTS');
                    TTSSAP.SetRange(Activity, 'INVOICE');
                    TTSSAP.SetFilter("Matching Status", '%1|%2', TTSSAP."Matching Status"::Unmatched, TTSSAP."Matching Status"::Error);
                    TTSSAP.SetRange(PaymentReference, PaymentRef);
                    if TTSSAP.FindSet() then
                        repeat
                            TTSSAP."Matching Status" := TTSSAP."Matching Status"::Matched;
                            TTSSAP."Matching ID" := NewMatchingID;
                            TTSSAP."Matching Processed Date Time" := CurrentDateTime;
                            TTSSAP."Matched By" := UserId;
                            TTSSAP."Match Type" := TTSSAP."Match Type"::Automatic;
                            TTSSAP.Modify();
                        until TTSSAP.Next() = 0;
                    
                    // Update TTS_ARAP records
                    TTSARAP.Reset();
                    TTSARAP.SetRange(Scheme, 'FTTS');
                    TTSARAP.SetRange(Activity, 'PAYMENT');
                    TTSARAP.SetFilter("LOB Matching Status", '%1|%2', TTSARAP."LOB Matching Status"::Unmatched, TTSARAP."LOB Matching Status"::Error);
                    TTSARAP.SetRange(ReceiptNumber, PaymentRef);
                    if TTSARAP.FindSet() then
                        repeat
                            TTSARAP."LOB Matching Status" := TTSARAP."LOB Matching Status"::Matched;
                            TTSARAP."LOB Matching ID" := NewMatchingID;
                            TTSARAP."LOB Processed Date Time" := CurrentDateTime;
                            TTSARAP."LOB Matched By" := UserId;
                            TTSARAP."LOB Match Type" := TTSARAP."LOB Match Type"::Automatic;
                            TTSARAP.Modify();
                        until TTSARAP.Next() = 0;
                    
                    MatchedCount += 1;
                end;
            end;
        end;

        if TotalKeys > 0 then
            Progress.Close();

        Message('ARAP Matching completed.\Matched Records: %1', MatchedCount);
    end;

}
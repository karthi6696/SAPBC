codeunit 85008 "Common Functions"
{
    procedure AllowonlySuperUser()
    var
        AccessControl: Record "Access Control";
        PermissionErr: Label 'You don’t have permission to view the data.';
    begin
        AccessControl.SetRange("User Security ID", UserSecurityId());
        AccessControl.SetRange("Role ID", 'SUPER');
        AccessControl.SetFilter("Company Name", '%1|%2', '', CompanyName);
        if AccessControl.IsEmpty then
            Error(PermissionErr);
    end;


    [EventSubscriber(ObjectType::Table, Database::TTS_SAP, OnAfterInsertEvent, '', false, false)]
    local procedure OnAfterInsertLOBData(var Rec: Record TTS_SAP)
    begin
        if Rec.IsTemporary then
            exit;

        ErrorCheckRecord(Rec);

    end;

    [EventSubscriber(ObjectType::Table, Database::TTS_SAP, OnAfterModifyEvent, '', false, false)]
    local procedure OnAfterModifyLOBData(var Rec: Record TTS_SAP; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary then
            exit;

        if not RunTrigger then
            exit;

        ErrorCheckRecord(Rec);

    end;

    [EventSubscriber(ObjectType::Table, Database::TTS_ARAP, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertCPMSData(var Rec: Record TTS_ARAP; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary then
            exit;

        ErrorCheckRecord(Rec);
    end;


    [EventSubscriber(ObjectType::Table, Database::TTS_ARAP, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyCPMSData(var Rec: Record TTS_ARAP; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary then
            exit;
        if not RunTrigger then
            exit;
        ErrorCheckRecord(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"EOD Staging", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEODData(var Rec: Record "EOD Staging")
    begin
        if Rec.IsTemporary then
            exit;

        ErrorCheckRecord(Rec);

    end;

    [EventSubscriber(ObjectType::Table, Database::"EOD Staging", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyEODData(var Rec: Record "EOD Staging"; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary then
            exit;
        if not RunTrigger then
            exit;
        ErrorCheckRecord(Rec);

    end;



    procedure ErrorCheckRecord(var TTS_SAP: Record TTS_SAP): Boolean
    var
        IntegrationError: Record Integration_Errors;
        SalespersonMapping: Record "Salesperson/Purchaser";
        NoSalespersonMapping: Label 'No Salesperson can be found for this record.';
        NoProduct: Label 'No Product can be found for this record.';
        FieldCannotBeBlank: Label 'Field %1 cannot be blank';
        Item: Record Item;
    begin
        // Remove Errors
        IntegrationError.reset();
        IntegrationError.setrange("Record Type", IntegrationError."Record Type"::LOB);
        IntegrationError.SetRange("Record Entry No.", TTS_SAP."Entry No.");
        IntegrationError.DeleteAll();

        if TTS_SAP.Scheme = '' then
            AddErrorRecord(IntegrationError."Record Type"::LOB, TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(Scheme)));

        if TTS_SAP.Country = '' then
            AddErrorRecord(IntegrationError."Record Type"::LOB, TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(Country)));

        if TTS_SAP.Activity = '' then
            AddErrorRecord(IntegrationError."Record Type"::LOB, TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(Activity)));

        if TTS_SAP.Product = '' then
            AddErrorRecord(IntegrationError."Record Type"::LOB, TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(Product)));

        if TTS_SAP.SalesPerson = '' then
            AddErrorRecord(IntegrationError."Record Type"::LOB, TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(SalesPerson)))
        else begin
            SalespersonMapping.Reset();
            SalespersonMapping.SetRange(Name, TTS_SAP.SalesPerson);
            if SalespersonMapping.FindFirst() then;
        end;

        if not SalespersonMapping."Ignore Payment Ref" then
            if TTS_SAP.PaymentReference = '' then
                AddErrorRecord(IntegrationError."Record Type"::LOB, TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(PaymentReference)));

        if TTS_SAP.TestCostWithoutVat = 0 then
            AddErrorRecord(IntegrationError."Record Type"::LOB, TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(TestCostWithoutVat)));

        if TTS_SAP.SalesPerson <> '' then begin
            SalespersonMapping.Reset();
            SalespersonMapping.SetRange(Name, TTS_SAP.SalesPerson);
            if SalespersonMapping.IsEmpty then
                AddErrorRecord(IntegrationError."Record Type"::LOB, TTS_SAP."Entry No.", NoSalespersonMapping);
        end;

        if TTS_SAP.Product <> '' then begin
            Item.Reset();
            Item.SetRange(Description, TTS_SAP.Product);
            if Item.IsEmpty then
                AddErrorRecord(IntegrationError."Record Type"::LOB, TTS_SAP."Entry No.", NoProduct);
        end;

        IntegrationError.reset();
        IntegrationError.setrange("Record Type", IntegrationError."Record Type"::LOB);
        IntegrationError.SetRange("Record Entry No.", TTS_SAP."Entry No.");
        exit(not IntegrationError.IsEmpty);
    end;


    procedure ErrorCheckRecord(var CPMS: Record TTS_ARAP): Boolean
    var
        IntegrationError: Record Integration_Errors;
        SalespersonMapping: Record "Salesperson/Purchaser";
        NoSalespersonMapping: Label 'No Salesperson can be found for this record.';
        NoProduct: Label 'No Product can be found for this record.';
        FieldCannotBeBlank: Label 'Field %1 cannot be blank';
        Item: Record Item;
    begin
        // Remove Errors
        IntegrationError.reset();
        IntegrationError.setrange("Record Type", IntegrationError."Record Type"::CPMS);
        IntegrationError.SetRange("Record Entry No.", CPMS."Entry No.");
        IntegrationError.DeleteAll();

        if CPMS.Scheme = '' then
            AddErrorRecord(IntegrationError."Record Type"::CPMS, CPMS."Entry No.", StrSubstNo(FieldCannotBeBlank, CPMS.FieldCaption(Scheme)));

        if CPMS.Country = '' then
            AddErrorRecord(IntegrationError."Record Type"::CPMS, CPMS."Entry No.", StrSubstNo(FieldCannotBeBlank, CPMS.FieldCaption(Country)));

        if CPMS.Activity = '' then
            AddErrorRecord(IntegrationError."Record Type"::CPMS, CPMS."Entry No.", StrSubstNo(FieldCannotBeBlank, CPMS.FieldCaption(Activity)));

        IntegrationSetup.Get();
        if CPMS.TestType = '' then
            if IntegrationSetup."TestType Validation Activity".Contains(CPMS.Activity) then
                AddErrorRecord(IntegrationError."Record Type"::CPMS, CPMS."Entry No.", StrSubstNo(FieldCannotBeBlank, CPMS.FieldCaption(TestType)));

        if CPMS.SalesPerson = '' then
            AddErrorRecord(IntegrationError."Record Type"::CPMS, CPMS."Entry No.", StrSubstNo(FieldCannotBeBlank, CPMS.FieldCaption(SalesPerson)));

        if CPMS.ReceiptNumber = '' then
            AddErrorRecord(IntegrationError."Record Type"::CPMS, CPMS."Entry No.", StrSubstNo(FieldCannotBeBlank, CPMS.FieldCaption(ReceiptNumber)));

        if CPMS.ReceiptMethod = '' then
            AddErrorRecord(IntegrationError."Record Type"::CPMS, CPMS."Entry No.", StrSubstNo(FieldCannotBeBlank, CPMS.FieldCaption(ReceiptMethod)));

        if (CPMS.RefundAmount = 0) and (CPMS.ReceiptAmount = 0) then
            AddErrorRecord(IntegrationError."Record Type"::CPMS, CPMS."Entry No.", StrSubstNo(FieldCannotBeBlank, 'Both receipt and refund amount'));

        if CPMS.SalesPerson <> '' then begin
            SalespersonMapping.Reset();
            SalespersonMapping.SetRange(Name, CPMS.SalesPerson);
            if SalespersonMapping.IsEmpty then
                AddErrorRecord(IntegrationError."Record Type"::CPMS, CPMS."Entry No.", NoSalespersonMapping);
        end;

        if CPMS.TestType <> '' then begin
            Item.Reset();
            Item.SetRange(Description, CPMS.TestType);
            if Item.IsEmpty then
                AddErrorRecord(IntegrationError."Record Type"::CPMS, CPMS."Entry No.", NoProduct);
        end;

        IntegrationError.reset();
        IntegrationError.setrange("Record Type", IntegrationError."Record Type"::CPMS);
        IntegrationError.SetRange("Record Entry No.", CPMS."Entry No.");
        exit(not IntegrationError.IsEmpty);
    end;

    local procedure ErrorCheckRecord(var EOD: Record "EOD Staging"): Boolean
    var
        IntegrationError: Record Integration_Errors;
        SalespersonMapping: Record "Salesperson/Purchaser";
        NoSalespersonMapping: Label 'No Salesperson can be found for this record.';
        NoProduct: Label 'No Product can be found for this record.';
        FieldCannotBeBlank: Label 'Field %1 cannot be blank';
        Item: Record Item;
    begin
        // Remove Errors
        IntegrationError.reset();
        IntegrationError.setrange("Record Type", IntegrationError."Record Type"::EOD);
        IntegrationError.SetRange("Record Entry No.", EOD."Entry No.");
        IntegrationError.DeleteAll();

        if EOD."Reference Number" = '' then
            AddErrorRecord(IntegrationError."Record Type"::EOD, EOD."Entry No.", StrSubstNo(FieldCannotBeBlank, EOD.FieldCaption("Reference Number")));

        if EOD."Transaction Amount" = 0 then
            AddErrorRecord(IntegrationError."Record Type"::EOD, EOD."Entry No.", StrSubstNo(FieldCannotBeBlank, EOD.FieldCaption("Transaction Amount")));

        IntegrationError.reset();
        IntegrationError.setrange("Record Type", IntegrationError."Record Type"::EOD);
        IntegrationError.SetRange("Record Entry No.", EOD."Entry No.");
        exit(not IntegrationError.IsEmpty);
    end;


    local procedure AddErrorRecord(RecordType: Enum Type; RecordEntryNo: Integer; ErrorMessage: Text[250])
    var
        IntegrationError: Record Integration_Errors;
    begin
        IntegrationError.init();
        IntegrationError."Record Type" := RecordType;
        IntegrationError."Record Entry No." := RecordEntryNo;
        IntegrationError."Error Message" := ErrorMessage;
        if IntegrationError.insert(true) then;
    end;


    procedure ExcludeActivity(scheme: code[20]; ptype: Option LOB,"LOB-CPMS","CPMS-EOD"): Text
    var
        ExcludeMatchingAct: Record "Exclude Matching Activities";
        Exclude: Text;
    begin
        ExcludeMatchingAct.Reset();
        if scheme <> '' then
            ExcludeMatchingAct.SetRange("Scheme Code", scheme);
        case true of
            ptype = ptype::LOB:
                if ExcludeMatchingAct.FindSet(false) then begin
                    repeat
                        Exclude := ExcludeMatchingAct."LOB Activity" + '&';
                    until ExcludeMatchingAct.Next() = 0;
                    exit(CopyStr(Exclude, 1, StrLen(Exclude) - 1));
                end;
            ptype = ptype::"LOB-CPMS":
                if ExcludeMatchingAct.FindSet(false) then begin
                    repeat
                        Exclude := ExcludeMatchingAct."LOB-CPMS Activity" + '&';
                    until ExcludeMatchingAct.Next() = 0;
                    exit(CopyStr(Exclude, 1, StrLen(Exclude) - 1));
                end;
            ptype = ptype::"CPMS-EOD":
                if ExcludeMatchingAct.FindSet(false) then begin
                    repeat
                        Exclude := ExcludeMatchingAct."CPMS-EOD Activity" + '&';
                    until ExcludeMatchingAct.Next() = 0;
                    exit(CopyStr(Exclude, 1, StrLen(Exclude) - 1));
                end;
        end;
    end;

    procedure ProcessTTSFilteredRecords(var Rec: Record TTS_SAP)
    var
        TTSSAPSummary: Codeunit "Export SAP Summary";
        TTS: Record TTS_SAP;
        WindowDialog: Dialog;
        Pagefilters: Text;
        ActivityFilter: Text;
    begin
        if Confirm('Do you want to process the filtered records?') then begin

            tts.Reset();
            tts.SetRange(Select, true);
            tts.SetLoadFields(Select);
            if tts.FindSet(true) then
                tts.ModifyAll(Select, false, false);

            Pagefilters := Rec.GetView();
            if Pagefilters = 'VERSION(1) SORTING(Entry No.)' then
                Error('Please apply the filter to complete the action.')
            else begin
                Rec.SetFilter(posted, '%1', false);
                tts.Reset();
                tts.SetView(Rec.GetView());
                tts.SetLoadFields(Select);
                if tts.FindSet(true) then begin
                    WindowDialog.Open('Filtering the records...');
                    tts.ModifyAll(Select, true, false);
                    WindowDialog.Close();
                    rec.SetRange(Posted);
                end else begin
                    Message('Nothing to process.');
                    exit;
                end;
            end;

            Clear(TTSSAPSummary);
            ActivityFilter := Rec.GetFilter(Activity);
            TTSSAPSummary.CreateTTSSummary(Enum::"Summary Export Type"::Selected, ActivityFilter);

            WindowDialog.Open('Completing the process...');
            tts.Reset();
            tts.SetView(Rec.GetView());
            tts.SetLoadFields(Select);
            if tts.FindSet(true) then
                tts.ModifyAll(Select, false, false);
            WindowDialog.Close();
        end;
    end;


    procedure ProcessCPMSFilteredRecords(var Rec: Record TTS_ARAP)
    var
        CPMSSAPSummary: Codeunit "Export SAP Summary";
        CPMS: Record TTS_ARAP;
        WindowDialog: Dialog;
        Pagefilters: Text;
        ActivityFilter: Text;
    begin
        if Confirm('Do you want to process the filtered records?') then begin

            CPMS.Reset();
            CPMS.SetRange(Select, true);
            CPMS.SetLoadFields(Select);
            if CPMS.FindSet(true) then
                CPMS.ModifyAll(Select, false, false);

            Pagefilters := Rec.GetView();
            if Pagefilters = 'VERSION(1) SORTING(Entry No.)' then
                Error('Please apply the filter to complete the action.')
            else begin
                Rec.SetFilter(posted, '%1', false);

                CPMS.Reset();
                CPMS.SetView(rec.GetView());
                CPMS.SetLoadFields(Select);
                if CPMS.FindSet(true) then begin
                    WindowDialog.Open('Filtering the records...');
                    CPMS.ModifyAll(Select, true);
                    WindowDialog.Close();
                    Rec.SetRange(Posted);
                end else begin
                    Message('Nothing to process.');
                    exit;
                end;
            end;

            Clear(CPMSSAPSummary);
            ActivityFilter := Rec.GetFilter(Activity);
            CPMSSAPSummary.CreateCPMSSummary(Enum::"Summary Export Type"::Selected, ActivityFilter);

            WindowDialog.Open('Completing the process...');
            CPMS.Reset();
            CPMS.SetView(Rec.GetView());
            CPMS.SetLoadFields(Select);
            if CPMS.FindSet(true) then
                CPMS.ModifyAll(Select, false);
            WindowDialog.Close();
        end;
    end;

    var
        IntegrationSetup: Record "Integration Setup";
}
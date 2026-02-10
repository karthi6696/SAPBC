codeunit 85001 "TTS SAP Journal"
{
    trigger OnRun()
    begin

    end;

    procedure Handler()
    var
        TTS_SAP: Record TTS_SAP;
        StartEntry: Integer;
        EndEntry: Integer;
    begin
        TTS_SAP.Reset();
        TTS_SAP.SetRange(Posted, false);
        If TTS_SAP.FindFirst() then
            repeat
                if ErrorCheckRecord(TTS_SAP) then
                    InsertSummaryRecord(TTS_SAP);
            until TTS_SAP.Next() = 0;
    end;

    procedure IndividualHandler(var TTS_SAP: Record TTS_SAP)
    begin
        if ErrorCheckRecord(TTS_SAP) then
            InsertSummaryRecord(TTS_SAP);
    end;

    local procedure ErrorCheckRecord(var TTS_SAP: Record TTS_SAP): Boolean
    var
        SAPMapping: Record "SAP Journal Rules";
        IntegrationError: Record Integration_Errors;
        SalespersonMapping: Record "Salesperson/Purchaser";
        NoSalespersonMapping: Label 'No Salesperson Mapping can be found for this record.';
        NoSAPMapping: Label 'No SAP Mapping can be found for this record.';
        FieldCannotBeBlank: Label 'Field %1 cannot be blank';
    begin
        // Remove Errors
        IntegrationError.reset;
        //   IntegrationError.setrange("Record Type", 'TTSSAP');
        IntegrationError.SetRange("Record Entry No.", TTS_SAP."Entry No.");
        IntegrationError.DeleteAll();

        if TTS_SAP.Scheme = '' then
            AddErrorRecord('TTSSAP', TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(Scheme)));

        if TTS_SAP.Country = '' then
            AddErrorRecord('TTSSAP', TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(Country)));

        if TTS_SAP.Activity = '' then
            AddErrorRecord('TTSSAP', TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(Activity)));

        if TTS_SAP.Product = '' then
            AddErrorRecord('TTSSAP', TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(Product)));

        if TTS_SAP.SalesPerson = '' then
            AddErrorRecord('TTSSAP', TTS_SAP."Entry No.", StrSubstNo(FieldCannotBeBlank, TTS_SAP.FieldCaption(SalesPerson)));

        if not SalespersonMapping.Get(TTS_SAP.SalesPerson) then
            AddErrorRecord('TTSSAP', TTS_SAP."Entry No.", NoSalespersonMapping);

        SAPMapping.reset;
        if not SAPMapping.get(TTS_SAP.Scheme, TTS_SAP.Country, TTS_SAP.Activity, TTS_SAP.Product) then
            AddErrorRecord('TTSSAP', TTS_SAP."Entry No.", NoSAPMapping);

        IntegrationError.reset;
        //  IntegrationError.setrange("Record Type", 'TTSSAP');
        IntegrationError.SetRange("Record Entry No.", TTS_SAP."Entry No.");
        if IntegrationError.findfirst then
            exit(false)
        else
            exit(true);
    end;

    local procedure InsertSummaryRecord(var TTS_SAP: Record TTS_SAP)
    var
        SAPMapping: Record "SAP Journal Rules";
        SalespersonMapping: Record "Salesperson/Purchaser";
        SAPSummary: Record "SAP Journal";
    begin
        if TTS_SAP.Posted = true then
            exit;
        clear(SAPMapping);
        clear(SalespersonMapping);

        SalespersonMapping.get(TTS_SAP.SalesPerson);
        SAPMapping.get(TTS_SAP.Scheme, TTS_SAP.Country, TTS_SAP.Activity, TTS_SAP.Product);

        // InsertModifyDebitRecord(TTS_SAP, SAPMapping, SalespersonMapping);
        // InsertModifyCreditRecord(TTS_SAP, SAPMapping, SalespersonMapping);

        //InsertSAPRegster();

        TTS_SAP.Posted := true;
        TTS_SAP."Processed Date" := Today;
        TTS_SAP.Modify();
    end;

    local procedure InsertModifyDebitRecord(var TTS_SAP: Record TTS_SAP; var SAPMapping: Record "SAP Journal Rules"; var Salesperson: Record "Salesperson/Purchaser")
    var
        SAPSummary: Record "SAP Journal";
        EvalDec: Decimal;
        EvalDec2: Decimal;
    begin
        SAPSummary.Reset();
        SAPSummary.SetRange(Scheme, TTS_SAP.Scheme);
        SAPSummary.SetRange(Country, TTS_SAP.Country);
        SAPSummary.SetRange(Activity, TTS_SAP.Activity);
        SAPSummary.SetRange(Product, TTS_SAP.Product);
        SAPSummary.SetRange(Salesperson, TTS_SAP.SalesPerson);
        SAPSummary.SetRange(Debit, true);
        if not SAPSummary.FindFirst() then begin
            SAPSummary.Init();
            SAPSummary.Insert(true);
            SAPSummary."Column 1" := '';
            SAPSummary."Column 2" := '';
            SAPSummary."Column 3" := '';
            SAPSummary."Column 4" := '';
            SAPSummary."Column 5" := '';
            SAPSummary."Column 6" := '';
            SAPSummary."Column 7" := '';
            SAPSummary."Column 8" := '';
            SAPSummary."Column 9" := SAPMapping."SAP Account (Debit)";
            SAPSummary."Column 11" := SAPMapping."SAP Posting Key (Debit)";
            // SAPSummary."Column 12" := Salesperson."SAP Profit Center";
            // SAPSummary."Column 15" := Salesperson."SAP Profit Center";
            SAPSummary."Column 16" := 'DVSA_9999';
            SAPSummary."Column 17" := SAPMapping."VAT Code";
            SAPSummary."Column 18" := TTS_SAP.Country + ' - ' + TTS_SAP.SalesPerson + ' - ' + TTS_SAP.Activity + ' - ' + TTS_SAP.Product;
            SAPSummary.Scheme := TTS_SAP.Scheme;
            SAPSummary.Country := TTS_SAP.Country;
            SAPSummary.Activity := TTS_SAP.Activity;
            SAPSummary.Product := TTS_SAP.Product;
            SAPSummary.Salesperson := TTS_SAP.SalesPerson;
            SAPSummary.Debit := true;
            SAPSummary."Created Date" := today;
            SAPSummary."Record Type" := 'TTS SAP';
            SAPSummary.Modify()
        end;

        if SAPSummary."Column 10" = '' then
            EvalDec := 0
        else
            Evaluate(EvalDec, SAPSummary."Column 10");
        // Evaluate(EvalDec2, TTS_SAP.TestCostWithoutVat);
        EvalDec := EvalDec + TTS_SAP.TestCostWithoutVat;
        SAPSummary."Column 10" := format(EvalDec, 0, '<Precision,2:2><Standard Format,2>');
        SAPSummary.Modify();
    end;

    local procedure InsertModifyCreditRecord(var TTS_SAP: Record TTS_SAP; var SAPMapping: Record "SAP Journal Rules"; var Salesperson: Record "Salesperson/Purchaser")
    var
        SAPSummary: Record "SAP Journal";
        EvalDec: Decimal;
        EvalDec2: Decimal;
    begin
        SAPSummary.Reset();
        SAPSummary.SetRange(Scheme, TTS_SAP.Scheme);
        SAPSummary.SetRange(Country, TTS_SAP.Country);
        SAPSummary.SetRange(Activity, TTS_SAP.Activity);
        SAPSummary.SetRange(Product, TTS_SAP.Product);
        SAPSummary.SetRange(Salesperson, TTS_SAP.SalesPerson);
        SAPSummary.SetRange(Debit, false);
        if not SAPSummary.FindFirst() then begin
            SAPSummary.Init();
            SAPSummary.Insert(true);
            SAPSummary."Column 1" := '';
            SAPSummary."Column 2" := '';
            SAPSummary."Column 3" := '';
            SAPSummary."Column 4" := '';
            SAPSummary."Column 5" := '';
            SAPSummary."Column 6" := '';
            SAPSummary."Column 7" := '';
            SAPSummary."Column 8" := '';
            SAPSummary."Column 9" := SAPMapping."SAP Account (Credit)";
            SAPSummary."Column 11" := SAPMapping."SAP Posting Key (Credit)";
            // SAPSummary."Column 12" := Salesperson."SAP Profit Center";
            // SAPSummary."Column 15" := Salesperson."SAP Profit Center";
            SAPSummary."Column 16" := 'DVSA_9999';
            SAPSummary."Column 17" := SAPMapping."VAT Code";
            SAPSummary."Column 18" := TTS_SAP.Country + ' - ' + TTS_SAP.SalesPerson + ' - ' + TTS_SAP.Activity + ' - ' + TTS_SAP.Product;
            SAPSummary.Scheme := TTS_SAP.Scheme;
            SAPSummary.Country := TTS_SAP.Country;
            SAPSummary.Activity := TTS_SAP.Activity;
            SAPSummary.Product := TTS_SAP.Product;
            SAPSummary.Salesperson := TTS_SAP.SalesPerson;
            SAPSummary.Debit := false;
            SAPSummary."Created Date" := today;
            SAPSummary."Record Type" := 'TTS SAP';
            SAPSummary.Modify();
        end;
        if SAPSummary."Column 10" = '' then
            EvalDec := 0
        else
            Evaluate(EvalDec, SAPSummary."Column 10");
        // Evaluate(EvalDec2, TTS_SAP.TestCostWithoutVat);
        EvalDec := EvalDec + TTS_SAP.TestCostWithoutVat;
        SAPSummary."Column 10" := format(EvalDec, 0, '<Precision,2:2><Standard Format,2>');
        SAPSummary.Modify();
    end;

    local procedure InsertSAPRegster(ptype: Enum Type)
    var
        SAPRegister: Record SAP_Summary_Register;
    begin
        SAPRegister.reset;
        SAPRegister.SetRange(Scheme, 'FTTS');
        SAPRegister.SetRange("Posting Date", today);
        SAPRegister.SetRange("Type", ptype);
        if not SAPRegister.FindFirst() then begin
            SAPRegister.reset;
            SAPRegister.Init();
            SAPRegister.Insert(true);
            SAPRegister.Validate(Scheme, 'FTTS');
            SAPRegister.Validate("Posting Date", today);
            SAPRegister.Validate("Type", ptype);
            SAPRegister.Modify();
        end
    end;

    local procedure AddErrorRecord(RecordType: Text[20]; RecordEntryNo: Integer; ErrorMessage: Text[250])
    var
        IntegrationError: Record Integration_Errors;
    begin
        IntegrationError.reset;
        IntegrationError.init;
        //   IntegrationError."Record Type" := RecordType;
        IntegrationError."Record Entry No." := RecordEntryNo;
        IntegrationError.insert(true);
        IntegrationError."Error Message" := ErrorMessage;
        IntegrationError.Modify();
    end;

    procedure ExportToExcel(FilterDate: Date)
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        SheetFileName: Label '"SAP Journal" %1';
        SAPSummary: Record "SAP Journal";
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        // Add column headings
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Column 1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 6', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 7', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 8', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 9', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 10', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 11', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 12', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 13', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 14', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 15', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 16', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 17', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 18', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Column 19', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        SAPSummary.Reset();
        SAPSummary.SetRange("Created Date", FilterDate);
        if SAPSummary.FindFirst() then
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(SAPSummary."Column 1", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 2", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 3", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 4", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 5", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 6", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 7", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 8", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 9", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 10", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 11", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 12", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 13", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 14", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 15", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 16", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 17", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 18", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(SAPSummary."Column 19", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            until SAPSummary.Next() = 0;

        TempExcelBuffer.CreateNewBook(StrSubstNo(SheetFileName, Today));
        TempExcelBuffer.WriteSheet(SheetFileName, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(SheetFileName, Today));
        TempExcelBuffer.OpenExcel();
    end;

    var
        myInt: Integer;
}
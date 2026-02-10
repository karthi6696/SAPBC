codeunit 85009 "Export SAP Summary"
{
    trigger OnRun()
    begin
        CreateTTSSummary(enum::"Summary Export Type"::All, '');
        CreateCPMSSummary(Enum::"Summary Export Type"::All, '');
    end;

    procedure CreateTTSSummary(ExportType: Enum "Summary Export Type"; ActivityFilter: Text)
    var
        TTSMaterials: Query FilterTTSMaterials;
        GetTTSSummary: Query GetTTSSummary;
        GetTTSStaging: Query GetTTSStaging;
        TTS: Record TTS_SAP;
        TTSUnsummarised: Record "TTS Unsummarised Lines";
        MarkTransaction: Boolean;
    begin
        InsertSAPRegster(enum::Type::LOB);

        Clear(Counter);
        Clear(FromEntry);
        Clear(ToEntry);
        Progress.Open(ProgressMsg);
        SalesPerson.Reset();
        if SalesPerson.FindSet() then
            repeat
                SAPIntegrationSetup.Reset();
                if ActivityFilter <> '' then
                    SAPIntegrationSetup.SetFilter("Source Activity", ActivityFilter);

#pragma warning disable AA0005
                SAPIntegrationSetup.SetRange(Type, SAPIntegrationSetup.Type::LOB);
                if SAPIntegrationSetup.FindSet(false) then
                    repeat
                        Clear(TTSMaterials);
                        Clear(Item);
                        if SAPIntegrationSetup."Material Code" then begin
                            if ExportType = ExportType::Selected then
                                TTSMaterials.SetRange(select, true);
                            //TTSMaterials.SetFilter(Entry_No_, CopyStr(LOBEntries.ToText(), 1, LOBEntries.Length - 1));
                            TTSMaterials.SetRange(Scheme, SAPIntegrationSetup.Scheme);
                            TTSMaterials.SetRange(country, SAPIntegrationSetup."Country Code");
                            TTSMaterials.SetRange(activity, SAPIntegrationSetup."Source Activity");
                            TTSMaterials.SetRange(salesperson, SalesPerson.Name);
                            if SAPIntegrationSetup."No TestMatch" then
                                TTSMaterials.SetRange(testmatch, 'NO INVOICE');
                            if SAPIntegrationSetup.TestMatch then
                                TTSMaterials.SetRange(testmatch, 'INVOICE');
                            if SAPIntegrationSetup.RefundOAB then
                                TTSMaterials.SetRange(REFUNDOAB, 'REFUNDOAB');
                            if TTSMaterials.Open() then
                                while TTSMaterials.Read() do begin
                                    Item.Reset();
                                    Item.SetRange(Description, TTSMaterials.product);
                                    if Item.FindFirst() then begin
                                        Clear(GetTTSSummary);
                                        Clear(MarkTransaction);
                                        if ExportType = ExportType::Selected then
                                            GetTTSSummary.SetRange(select, true);
                                        //GetTTSSummary.SetFilter(Entry_No_, CopyStr(LOBEntries.ToText(), 1, LOBEntries.Length - 1));
                                        if SAPIntegrationSetup.Scheme <> '' then
                                            GetTTSSummary.SetRange(Scheme, SAPIntegrationSetup.Scheme);
                                        if SAPIntegrationSetup."Country Code" <> '' then
                                            GetTTSSummary.SetRange(country, SAPIntegrationSetup."Country Code");
                                        GetTTSSummary.SetRange(activity, SAPIntegrationSetup."Source Activity");
                                        GetTTSSummary.SetRange(product, TTSMaterials.product);
                                        GetTTSSummary.SetRange(salesperson, SalesPerson.Name);
                                        if SAPIntegrationSetup."No TestMatch" then
                                            GetTTSSummary.SetRange(testmatch, 'NO INVOICE');
                                        if SAPIntegrationSetup.TestMatch then
                                            GetTTSSummary.SetRange(testmatch, 'INVOICE');
                                        if SAPIntegrationSetup.RefundOAB then
                                            GetTTSSummary.SetRange(REFUNDOAB, 'REFUNDOAB');
                                        if GetTTSSummary.Open() then begin
                                            while GetTTSSummary.Read() do begin
                                                Counter += 1;
                                                Progress.Update(1, Counter);
                                                InsertCreditLine(GetTTSSummary.Scheme, GetTTSSummary.TestCostWithoutVat, GetTTSSummary.country, GetTTSSummary.activity, SalesPerson.Code, Enum::Type::LOB, '');
                                                InsertDebitLine(GetTTSSummary.Scheme, GetTTSSummary.TestCostWithoutVat, GetTTSSummary.country, GetTTSSummary.activity, SalesPerson.Code, Enum::Type::LOB, '');
                                                MarkTransaction := true;
                                            end;
                                            //    MarkTTSRecordsasPosted(ExportType, TTSMaterials.product);
                                        end;

                                        if MarkTransaction then begin
                                            Clear(GetTTSStaging);
                                            if ExportType = ExportType::Selected then
                                                GetTTSStaging.SetRange(select, true);
                                            // GetTTSStaging.SetFilter(Entry_No_, CopyStr(LOBEntries.ToText(), 1, LOBEntries.Length - 1));
                                            if SAPIntegrationSetup.Scheme <> '' then
                                                GetTTSStaging.SetRange(Scheme, SAPIntegrationSetup.Scheme);
                                            if SAPIntegrationSetup."Country Code" <> '' then
                                                GetTTSStaging.SetRange(country, SAPIntegrationSetup."Country Code");
                                            GetTTSStaging.SetRange(activity, SAPIntegrationSetup."Source Activity");
                                            GetTTSStaging.SetRange(product, TTSMaterials.product);
                                            GetTTSStaging.SetRange(salesperson, SalesPerson.Name);
                                            if SAPIntegrationSetup."No TestMatch" then
                                                GetTTSStaging.SetRange(testmatch, 'NO INVOICE');
                                            if SAPIntegrationSetup.TestMatch then
                                                GetTTSStaging.SetRange(testmatch, 'INVOICE');
                                            if SAPIntegrationSetup.RefundOAB then
                                                GetTTSStaging.SetRange(REFUNDOAB, 'REFUNDOAB');
                                            if GetTTSStaging.Open() then begin
                                                while GetTTSStaging.Read() do begin
                                                    if TTS.Get(GetTTSStaging.Entry_No_) then begin
                                                        TTS.Posted := true;
                                                        TTS."SAP Register No." := SAPRegister."Entry No.";
                                                        TTS."Credit Acc No." := SAPIntegrationSetup."SAP Account (Credit)";
                                                        if TTS."Credit Acc No." = '' then
                                                            TTS."Credit Acc No." := Item."SAP Chart of Account";
                                                        TTS."Debit Acc No." := SAPIntegrationSetup."SAP Account (Debit)";
                                                        if TTS."Debit Acc No." = '' then
                                                            TTS."Debit Acc No." := Item."SAP Chart of Account";
                                                        //   TTS."Journal Entry No." := SAPSummary."Credit Entry No.";
                                                        TTS.Modify(false);
                                                        TTSUnsummarised.Init();
                                                        TTSUnsummarised.TransferFields(tts);
                                                        TTSUnsummarised."Credit Entry No." := CreditEntryNo;
                                                        TTSUnsummarised."Debit Entry No." := DebitEntryNo;
                                                        TTSUnsummarised."Staging Entry No." := tts."Entry No.";
                                                        TTSUnsummarised."Processed Date" := Today;
                                                        TTSUnsummarised.Insert(true);
                                                    end;
                                                end;
                                                //   MarkTTSRecordsasPosted(ExportType, TTSMaterials.product);
                                            end;
                                        end;
                                    end;
                                end;
                        end else begin
                            Clear(GetTTSSummary);
                            Clear(MarkTransaction);
                            if ExportType = ExportType::Selected then
                                GetTTSSummary.SetRange(select, true);
                            // GetTTSSummary.SetFilter(Entry_No_, CopyStr(LOBEntries.ToText(), 1, LOBEntries.Length - 1));
                            if SAPIntegrationSetup.Scheme <> '' then
                                GetTTSSummary.SetRange(Scheme, SAPIntegrationSetup.Scheme);
                            if SAPIntegrationSetup."Country Code" <> '' then
                                GetTTSSummary.SetRange(country, SAPIntegrationSetup."Country Code");
                            GetTTSSummary.SetRange(activity, SAPIntegrationSetup."Source Activity");
                            GetTTSSummary.SetRange(salesperson, SalesPerson.Name);
                            if SAPIntegrationSetup."No TestMatch" then
                                GetTTSSummary.SetRange(testmatch, 'NO INVOICE');
                            if SAPIntegrationSetup.TestMatch then
                                GetTTSSummary.SetRange(testmatch, 'INVOICE');
                            if SAPIntegrationSetup.RefundOAB then
                                GetTTSSummary.SetRange(REFUNDOAB, 'REFUNDOAB');
                            if GetTTSSummary.Open() then begin
                                while GetTTSSummary.Read() do begin
                                    Counter += 1;
                                    Progress.Update(1, Counter);
                                    InsertCreditLine(GetTTSSummary.Scheme, GetTTSSummary.TestCostWithoutVat, GetTTSSummary.country, GetTTSSummary.activity, SalesPerson.Code, Enum::Type::LOB, '');
                                    InsertDebitLine(GetTTSSummary.Scheme, GetTTSSummary.TestCostWithoutVat, GetTTSSummary.country, GetTTSSummary.activity, SalesPerson.Code, Enum::Type::LOB, '');
                                    MarkTransaction := true;
                                end;
                                // MarkTTSRecordsasPosted(ExportType, '');
                            end;

                            if MarkTransaction then begin
                                Clear(GetTTSStaging);
                                if ExportType = ExportType::Selected then
                                    GetTTSStaging.SetRange(select, true);
                                // GetTTSStaging.SetFilter(Entry_No_, CopyStr(LOBEntries.ToText(), 1, LOBEntries.Length - 1));
                                if SAPIntegrationSetup.Scheme <> '' then
                                    GetTTSStaging.SetRange(Scheme, SAPIntegrationSetup.Scheme);
                                if SAPIntegrationSetup."Country Code" <> '' then
                                    GetTTSStaging.SetRange(country, SAPIntegrationSetup."Country Code");
                                GetTTSStaging.SetRange(activity, SAPIntegrationSetup."Source Activity");
                                GetTTSStaging.SetRange(salesperson, SalesPerson.Name);
                                if SAPIntegrationSetup."No TestMatch" then
                                    GetTTSStaging.SetRange(testmatch, 'NO INVOICE');
                                if SAPIntegrationSetup.TestMatch then
                                    GetTTSStaging.SetRange(testmatch, 'INVOICE');
                                if SAPIntegrationSetup.RefundOAB then
                                    GetTTSStaging.SetRange(REFUNDOAB, 'REFUNDOAB');
                                if GetTTSStaging.Open() then begin
                                    while GetTTSStaging.Read() do begin
                                        if TTS.Get(GetTTSStaging.Entry_No_) then begin
                                            TTS.Posted := true;
                                            TTS."SAP Register No." := SAPRegister."Entry No.";
                                            tts."Credit Acc No." := SAPIntegrationSetup."SAP Account (Credit)";
                                            tts."Debit Acc No." := SAPIntegrationSetup."SAP Account (Debit)";
                                            // tts."Credit Entry No." := CreditEntryNo;
                                            // tts."Debit Entry No." := DebitEntryNo;
                                            TTS.Modify(false);
                                            TTSUnsummarised.Init();
                                            TTSUnsummarised.TransferFields(tts, true);
                                            TTSUnsummarised."Credit Entry No." := CreditEntryNo;
                                            TTSUnsummarised."Debit Entry No." := DebitEntryNo;
                                            TTSUnsummarised."Staging Entry No." := tts."Entry No.";
                                            TTSUnsummarised."Processed Date" := Today;
                                            TTSUnsummarised.Insert(true);
                                        end;
                                    end;
                                    //   MarkTTSRecordsasPosted(ExportType, TTSMaterials.product);
                                end;
                            end;
                        end;
                    until SAPIntegrationSetup.Next() = 0;
            until SalesPerson.Next() = 0;

        ToEntry := SAPSummary."Entry No.";

        if FromEntry > 0 then begin
            SAPRegister."From Entry No." := FromEntry;
            SAPRegister."To Entry No." := ToEntry;
            SAPRegister.Modify(false);
            UpdateSAPRegisterNoInSAPJoural(SAPRegister."Entry No.");
        end else begin
            SAPRegister.Delete();
            Message('No journal lines were created.');
        end;

        Progress.Close();
    end;

    procedure CreateCPMSSummary(ExportType: Enum "Summary Export Type"; ActivityFilter: Text)
    var
        GetCPMSSummary: Query GetCPMSSummary;
        GetCPMSStaging: Query GetCPMSStaging;
        CPMSMaterials: Query FilterCPMSMaterials;
        CPMS: Record TTS_ARAP;
        CPMSUnsummarised: Record "CPMS Unsummarised Lines";
        Amt: Decimal;
        MarkTransaction: Boolean;
    begin
        InsertSAPRegster(enum::Type::CPMS);

        Clear(Counter);
        Clear(FromEntry);
        Clear(ToEntry);
        Progress.Open(ProgressMsg);
        SalesPerson.Reset();
        if SalesPerson.FindSet() then
            repeat
                SAPIntegrationSetup.Reset();
#pragma warning disable AA0005
                if ActivityFilter <> '' then
                    SAPIntegrationSetup.SetFilter("Source Activity", ActivityFilter);
                SAPIntegrationSetup.SetRange(Type, SAPIntegrationSetup.Type::CPMS);
                //  SAPIntegrationSetup.SetFilter("Source Activity", '%1', 'PAYMENT');
                // SAPIntegrationSetup.SetRange(Notes, '1');
                if SAPIntegrationSetup.FindSet(false) then
                    repeat
                        Clear(Item);
                        Clear(CPMSMaterials);
                        Clear(Amt);
                        if SAPIntegrationSetup."Material Code" then begin
                            if ExportType = ExportType::Selected then
                                CPMSMaterials.SetRange(select, true);
                            CPMSMaterials.SetRange(Scheme, SAPIntegrationSetup.Scheme);
                            CPMSMaterials.SetRange(country, SAPIntegrationSetup."Country Code");
                            CPMSMaterials.SetRange(activity, SAPIntegrationSetup."Source Activity");
                            CPMSMaterials.SetRange(salesperson, SalesPerson.Name);
                            if SAPIntegrationSetup."No TestMatch" then
                                CPMSMaterials.SetRange(testmatch, 'NO INVOICE');
                            if SAPIntegrationSetup.TestMatch then
                                CPMSMaterials.SetRange(testmatch, 'INVOICE');
                            if SAPIntegrationSetup.RefundOAB then
                                CPMSMaterials.SetRange(REFUNDOAB, 'REFUNDOAB');
                            if SAPIntegrationSetup."Receipt Method" <> '' then
                                CPMSMaterials.SetFilter(ReceiptMethod, SAPIntegrationSetup."Receipt Method");
                            if SAPIntegrationSetup."Source Activity-Origin" <> '' then
                                CPMSMaterials.SetFilter(Source_Activity_Origin, SAPIntegrationSetup."Source Activity-Origin");
                            if SAPIntegrationSetup."Payment Duplicate" then
                                CPMSMaterials.SetFilter(Payment_Duplicate, '<>%1', 'Pay Ref Dup');
                            if CPMSMaterials.Open() then
                                while CPMSMaterials.Read() do begin
                                    Counter += 1;
                                    Progress.Update(1, Counter);
                                    Item.Reset();
                                    Item.SetRange(Description, CPMSMaterials.product);
                                    if Item.FindFirst() then begin
                                        Clear(GetCPMSSummary);
                                        Clear(MarkTransaction);
                                        if ExportType = ExportType::Selected then
                                            GetCPMSSummary.SetRange(select, true);
                                        if SAPIntegrationSetup.Scheme <> '' then
                                            GetCPMSSummary.SetRange(Scheme, SAPIntegrationSetup.Scheme);
                                        if SAPIntegrationSetup."Country Code" <> '' then
                                            GetCPMSSummary.SetRange(country, SAPIntegrationSetup."Country Code");
                                        GetCPMSSummary.SetRange(activity, SAPIntegrationSetup."Source Activity");
                                        GetCPMSSummary.SetRange(product, CPMSMaterials.product);
                                        GetCPMSSummary.SetRange(salesperson, SalesPerson.Name);
                                        if SAPIntegrationSetup."Receipt Method" <> '' then
                                            GetCPMSSummary.SetFilter(ReceiptMethod, SAPIntegrationSetup."Receipt Method");
                                        if SAPIntegrationSetup."No TestMatch" then
                                            GetCPMSSummary.SetRange(testmatch, 'NO INVOICE');
                                        if SAPIntegrationSetup.TestMatch then
                                            GetCPMSSummary.SetRange(testmatch, 'INVOICE');
                                        if SAPIntegrationSetup.RefundOAB then
                                            GetCPMSSummary.SetRange(REFUNDOAB, 'REFUNDOAB');
                                        if SAPIntegrationSetup."Source Activity-Origin" <> '' then
                                            GetCPMSSummary.SetFilter(Source_Activity_Origin, SAPIntegrationSetup."Source Activity-Origin");
                                        if SAPIntegrationSetup."Payment Duplicate" then
                                            GetCPMSSummary.SetFilter(Payment_Duplicate, '<>%1', 'Pay Ref Dup');
                                        if GetCPMSSummary.Open() then begin
                                            while GetCPMSSummary.Read() do begin
                                                Counter += 1;
                                                Progress.Update(1, Counter);
                                                if GetCPMSSummary.ReceiptAmount = 0 then
                                                    Amt := GetCPMSSummary.RefundAmount
                                                else
                                                    Amt := GetCPMSSummary.ReceiptAmount;
                                                InsertCreditLine(GetCPMSSummary.Scheme, Amt, GetCPMSSummary.country, GetCPMSSummary.activity, SalesPerson.code, Enum::Type::CPMS, '');
                                                InsertDebitLine(GetCPMSSummary.Scheme, Amt, GetCPMSSummary.country, GetCPMSSummary.activity, SalesPerson.Code, Enum::Type::CPMS, '');
                                                MarkTransaction := true;
                                            end;
                                            //MarkCPMSRecordsasPosted(ExportType, CPMSMaterials.product);
                                        end;
                                        if MarkTransaction then begin
                                            Clear(GetCPMSStaging);
                                            if ExportType = ExportType::Selected then
                                                GetCPMSStaging.SetRange(select, true);
                                            // GetCPMSStaging.SetFilter(Entry_No_, CopyStr(CPMSEntries.ToText(), 1, CPMSEntries.Length - 1));
                                            if SAPIntegrationSetup.Scheme <> '' then
                                                GetCPMSStaging.SetRange(Scheme, SAPIntegrationSetup.Scheme);
                                            if SAPIntegrationSetup."Country Code" <> '' then
                                                GetCPMSStaging.SetRange(country, SAPIntegrationSetup."Country Code");
                                            GetCPMSStaging.SetRange(activity, SAPIntegrationSetup."Source Activity");
                                            GetCPMSStaging.SetRange(salesperson, SalesPerson.Name);
                                            GetCPMSStaging.SetRange(product, CPMSMaterials.product);
                                            if SAPIntegrationSetup."Receipt Method" <> '' then
                                                GetCPMSStaging.SetFilter(ReceiptMethod, SAPIntegrationSetup."Receipt Method");
                                            if SAPIntegrationSetup."No TestMatch" then
                                                GetCPMSStaging.SetRange(testmatch, 'NO INVOICE');
                                            if SAPIntegrationSetup.TestMatch then
                                                GetCPMSStaging.SetRange(testmatch, 'INVOICE');
                                            if SAPIntegrationSetup.RefundOAB then
                                                GetCPMSStaging.SetRange(REFUNDOAB, 'REFUNDOAB');
                                            if SAPIntegrationSetup."Source Activity-Origin" <> '' then
                                                GetCPMSSummary.SetFilter(Source_Activity_Origin, SAPIntegrationSetup."Source Activity-Origin");
                                            if SAPIntegrationSetup."Payment Duplicate" then
                                                GetCPMSSummary.SetFilter(Payment_Duplicate, '<>%1', 'Pay Ref Dup');
                                            if GetCPMSStaging.Open() then
                                                while GetCPMSStaging.Read() do begin
                                                    if CPMS.Get(GetCPMSStaging.Entry_No_) then begin
                                                        CPMS.Posted := true;
                                                        CPMS."SAP Register No." := SAPRegister."Entry No.";
                                                        CPMS."Credit Acc No." := SAPIntegrationSetup."SAP Account (Credit)";
                                                        CPMS."Debit Acc No." := SAPIntegrationSetup."SAP Account (Debit)";
                                                        if CPMS."Credit Acc No." = '' then
                                                            CPMS."Credit Acc No." := Item."SAP Chart of Account";
                                                        if CPMS."Debit Acc No." = '' then
                                                            CPMS."Debit Acc No." := Item."SAP Chart of Account";
                                                        CPMS.Modify(false);

                                                        CPMSUnsummarised.Init();
                                                        CPMSUnsummarised.TransferFields(CPMS, true);
                                                        CPMSUnsummarised."Credit Entry No." := CreditEntryNo;
                                                        CPMSUnsummarised."Debit Entry No." := DebitEntryNo;
                                                        CPMSUnsummarised."Processed Date" := Today;
                                                        CPMSUnsummarised."Staging Entry No." := CPMS."Entry No.";
                                                        CPMSUnsummarised.Insert(true);
                                                    end;
                                                end;
                                        end;
                                    end;
                                end;
                        end else begin
                            Clear(GetCPMSSummary);
                            Clear(MarkTransaction);
                            if ExportType = ExportType::Selected then
                                GetCPMSSummary.SetRange(select, true);
                            //  GetCPMSSummary.SetFilter(Entry_No_, CopyStr(CPMSEntries.ToText(), 1, CPMSEntries.Length - 1));
                            if SAPIntegrationSetup.Scheme <> '' then
                                GetCPMSSummary.SetRange(Scheme, SAPIntegrationSetup.Scheme);
                            if SAPIntegrationSetup."Country Code" <> '' then
                                GetCPMSSummary.SetRange(country, SAPIntegrationSetup."Country Code");
                            GetCPMSSummary.SetRange(activity, SAPIntegrationSetup."Source Activity");
                            GetCPMSSummary.SetRange(salesperson, SalesPerson.Name);
                            if SAPIntegrationSetup."Receipt Method" <> '' then
                                GetCPMSSummary.SetFilter(ReceiptMethod, SAPIntegrationSetup."Receipt Method");
                            if SAPIntegrationSetup."No TestMatch" then
                                GetCPMSSummary.SetRange(testmatch, 'NO INVOICE');
                            if SAPIntegrationSetup.TestMatch then
                                GetCPMSSummary.SetRange(testmatch, 'INVOICE');
                            if SAPIntegrationSetup.RefundOAB then
                                GetCPMSSummary.SetRange(REFUNDOAB, 'REFUNDOAB');
                            if SAPIntegrationSetup."Source Activity-Origin" <> '' then
                                GetCPMSSummary.SetFilter(Source_Activity_Origin, SAPIntegrationSetup."Source Activity-Origin");
                            if SAPIntegrationSetup."Payment Duplicate" then
                                GetCPMSSummary.SetFilter(Payment_Duplicate, '<>%1', 'Pay Ref Dup');
                            if GetCPMSSummary.Open() then begin
                                while GetCPMSSummary.Read() do begin
                                    Counter += 1;
                                    Progress.Update(1, Counter);
                                    if GetCPMSSummary.ReceiptAmount = 0 then
                                        Amt := GetCPMSSummary.RefundAmount
                                    else
                                        Amt := GetCPMSSummary.ReceiptAmount;
                                    InsertCreditLine(GetCPMSSummary.Scheme, Amt, GetCPMSSummary.country, GetCPMSSummary.activity, SalesPerson.code, Enum::Type::CPMS, '');
                                    InsertDebitLine(GetCPMSSummary.Scheme, Amt, GetCPMSSummary.country, GetCPMSSummary.activity, SalesPerson.Code, Enum::Type::CPMS, '');
                                    MarkTransaction := true;
                                end;
                                //  MarkCPMSRecordsasPosted(ExportType, '');
                            end;

                            if MarkTransaction then begin
                                Clear(GetCPMSStaging);
                                if ExportType = ExportType::Selected then
                                    GetCPMSStaging.SetRange(select, true);
                                // GetCPMSStaging.SetFilter(Entry_No_, CopyStr(CPMSEntries.ToText(), 1, CPMSEntries.Length - 1));
                                if SAPIntegrationSetup.Scheme <> '' then
                                    GetCPMSStaging.SetRange(Scheme, SAPIntegrationSetup.Scheme);
                                if SAPIntegrationSetup."Country Code" <> '' then
                                    GetCPMSStaging.SetRange(country, SAPIntegrationSetup."Country Code");
                                GetCPMSStaging.SetRange(activity, SAPIntegrationSetup."Source Activity");
                                GetCPMSStaging.SetRange(salesperson, SalesPerson.Name);
                                if SAPIntegrationSetup."Receipt Method" <> '' then
                                    GetCPMSStaging.SetFilter(ReceiptMethod, SAPIntegrationSetup."Receipt Method");
                                if SAPIntegrationSetup."No TestMatch" then
                                    GetCPMSStaging.SetRange(testmatch, 'NO INVOICE');
                                if SAPIntegrationSetup.TestMatch then
                                    GetCPMSStaging.SetRange(testmatch, 'INVOICE');
                                if SAPIntegrationSetup.RefundOAB then
                                    GetCPMSStaging.SetRange(REFUNDOAB, 'REFUNDOAB');
                                if SAPIntegrationSetup."Source Activity-Origin" <> '' then
                                    GetCPMSStaging.SetFilter(Source_Activity_Origin, SAPIntegrationSetup."Source Activity-Origin");
                                if SAPIntegrationSetup."Payment Duplicate" then
                                    GetCPMSStaging.SetFilter(Payment_Duplicate, '<>%1', 'Pay Ref Dup');
                                if GetCPMSStaging.Open() then
                                    while GetCPMSStaging.Read() do begin
                                        if CPMS.Get(GetCPMSStaging.Entry_No_) then begin
                                            CPMS.Posted := true;
                                            CPMS."SAP Register No." := SAPRegister."Entry No.";
                                            CPMS."Credit Acc No." := SAPIntegrationSetup."SAP Account (Credit)";
                                            CPMS."Debit Acc No." := SAPIntegrationSetup."SAP Account (Debit)";

                                            CPMS.Modify(false);
                                            CPMSUnsummarised.Init();
                                            CPMSUnsummarised.TransferFields(CPMS, true);
                                            CPMSUnsummarised."Credit Entry No." := CreditEntryNo;
                                            CPMSUnsummarised."Debit Entry No." := DebitEntryNo;
                                            CPMSUnsummarised."Staging Entry No." := CPMS."Entry No.";
                                            CPMSUnsummarised."Processed Date" := Today;
                                            CPMSUnsummarised.Insert(true);
                                        end;
                                    end;
                            end;
                        end;
                    until SAPIntegrationSetup.Next() = 0;
            until SalesPerson.Next() = 0;
        ToEntry := SAPSummary."Entry No.";

        if FromEntry > 0 then begin
            SAPRegister."From Entry No." := FromEntry;
            SAPRegister."To Entry No." := ToEntry;
            SAPRegister.Modify(false);
            UpdateSAPRegisterNoInSAPJoural(SAPRegister."Entry No.");
        end else begin
            SAPRegister.Delete();
            Message('No journal lines were created.');
        end;
        Progress.Close();
    end;

    local procedure InsertCreditLine(Scheme: Code[20]; Amount: decimal;
country: Code[10];
activity: code[20];
AccountNo: Code[20];
ptype: Enum Type;
SelectEntries: Text)
    var
        GLAcc: record "G/L Account";
    begin
        if Amount = 0 then
            exit;
        SAPSummary.Init();
        SAPSummary."Column 1" := Scheme;
        SAPSummary."Column 3" := 'ZF';
        SAPSummary."Column 4" := 'GBP';
        SAPSummary."Column 5" := Scheme + ' ' + Format(Today);
        SAPSummary."Column 6" := Scheme + ' ' + Format(Today);
        SAPSummary."Column 7" := Format(Today);
        SAPSummary."Column 8" := Format(Today);
        SAPSummary."Column 9" := SAPIntegrationSetup."SAP Account (Credit)";
        if SAPSummary."Column 9" = '' then
            SAPSummary."Column 9" := Item."SAP Chart of Account";
        SAPSummary."Column 10" := Format(Amount);
        SAPSummary."Column 11" := SAPIntegrationSetup."SAP Posting Key (Credit)";
        //SAPSummary."Column 12" := SalesPerson.Code;
        SAPSummary."Column 15" := SalesPerson.Code;
        SAPSummary."Column 16" := 'DVSA_9999';
        if GLAcc.Get(SAPSummary."Column 9") then begin
            SAPSummary."Column 17" := GLAcc."VAT Prod. Posting Group";
            if GLAcc."Hide DVSA_9999" then
                SAPSummary."Column 16" := '';
        end;
        if Item.Description = '' then
            SAPSummary."Column 18" := country + '-' + SalesPerson.Name + '-' + activity
        else
            SAPSummary."Column 18" := country + '-' + SalesPerson.Name + '-' + activity + '-' + Item.Description;
        SAPSummary.Type := ptype;
        SAPSummary."SAP Mapping ID" := SAPIntegrationSetup.SystemId;
        SAPSummary."Selected Entries" := SelectEntries;
        SAPSummary.Insert(true);
        if FromEntry = 0 then
            FromEntry := SAPSummary."Entry No.";
        CreditEntryNo := SAPSummary."Entry No.";
    end;

    local procedure InsertDebitLine(Scheme: Code[20];
Amount: decimal;
country: Code[10];
activity: code[20];
AccountNo: Code[20];
ptype: Enum Type;
SelectEntries: Text)

    var
        GLAcc: record "G/L Account";
        SAPJournalEntries: Record "SAP Journal";
    begin
        if Amount = 0 then
            exit;
        SAPSummary.Init();
        SAPSummary."Column 1" := Scheme;
        SAPSummary."Column 3" := 'ZF';
        SAPSummary."Column 4" := 'GBP';
        SAPSummary."Column 5" := Scheme + ' ' + Format(Today);
        SAPSummary."Column 6" := Scheme + ' ' + Format(Today);
        SAPSummary."Column 7" := Format(Today);
        SAPSummary."Column 8" := Format(Today);
        SAPSummary."Column 9" := SAPIntegrationSetup."SAP Account (Debit)";
        if SAPSummary."Column 9" = '' then
            SAPSummary."Column 9" := Item."SAP Chart of Account";
        SAPSummary."Column 10" := Format(Amount);
        SAPSummary."Column 11" := SAPIntegrationSetup."SAP Posting Key (Debit)";
        // SAPSummary."Column 12" := SalesPerson.Code;
        SAPSummary."Column 15" := SalesPerson.Code;
        SAPSummary."Column 16" := 'DVSA_9999';
        if GLAcc.Get(SAPSummary."Column 9") then begin
            SAPSummary."Column 17" := GLAcc."VAT Prod. Posting Group";
            if GLAcc."Hide DVSA_9999" then
                SAPSummary."Column 16" := '';
        end;
        if Item.Description = '' then
            SAPSummary."Column 18" := country + '-' + SalesPerson.Name + '-' + activity
        else
            SAPSummary."Column 18" := country + '-' + SalesPerson.Name + '-' + activity + '-' + Item.Description;
        SAPSummary.Type := ptype;
        SAPSummary."Credit Entry No." := CreditEntryNo;
        SAPSummary."SAP Mapping ID" := SAPIntegrationSetup.SystemId;
        //  SAPSummary."Selected Entries" := SelectEntries;
        SAPSummary.Insert(true);
        SAPJournalEntries.Reset();
        SAPJournalEntries.SetRange("Entry No.", CreditEntryNo);
        if SAPJournalEntries.FindFirst() then begin
            SAPJournalEntries."Debit Entry No." := SAPSummary."Entry No.";
            SAPJournalEntries.Modify(true);
            DebitEntryNo := SAPSummary."Entry No.";
        end;
    end;


    procedure SetSelectedLOB(var LOBRecords: Record TTS_SAP temporary)
    begin
        LOBRecords.SetLoadFields(LOBRecords."Entry No.");
        if LOBRecords.FindSet() then
            repeat
                // SelectedLOB := LOBRecords;
                // SelectedLOB.Insert();
                LOBEntries.Append(Format(LOBRecords."Entry No.") + '|');
            until LOBRecords.Next() = 0;
    end;


    procedure SetSelectedCPMS(var CPMSRecords: Record TTS_ARAP temporary)
    begin
        CPMSRecords.SetLoadFields("Entry No.");
        if CPMSRecords.FindSet() then
            repeat
                // SelectedCPMS := CPMSRecords;
                // SelectedCPMS.Insert();
                CPMSEntries.Append(Format(CPMSRecords."Entry No.") + '|');
            until CPMSRecords.Next() = 0;
        //    Message(CPMSEntries.ToText());
    end;

    procedure SetSelectedSummary(var Summary: Record "SAP Journal" temporary)
    begin
        Summary.SetLoadFields("Entry No.");
        if Summary.FindSet() then
            repeat
                // SelectedSummary := Summary;
                // SelectedSummary.Insert();
                SummaryEntries.Append(Format(Summary."Entry No.") + '|');
            until Summary.Next() = 0;
    end;

    procedure ExportSummaryCSV(pType: Enum Type; pExportType: Enum "Summary Export Type";
                                          RegisterNo: Integer)
    var
        Instream: InStream;
        OutStream: OutStream;
        FileName: Text;
        TxtBuilder: TextBuilder;
        TempBlob: Codeunit "Temp Blob";
        ExportProgMsg: Label 'Export SAP Journal......#1######################\';
    begin
        Clear(Counter);
        Progress.Open(ExportProgMsg);
        if pType = pType::LOB then
            FileName := 'TTS_SAP_Journal_' + Format(Today) + Format(Time) + '.csv'
        else
            FileName := 'CPMS_SAP_Journal_' + Format(Today) + Format(Time) + '.csv';

        TxtBuilder.AppendLine('Column1' + ',' + 'Column2' + ',' + 'Column3' + ',' + 'Column4' + ',' + 'Column5' + ',' + 'Column6' + ',' + 'Column7' + ',' + 'Column8' + ',' + 'Column9' + ',' + 'Column10' + ',' +
        'Column11' + ',' + 'Column12' + ',' + 'Column13' + ',' + 'Column14' + ',' + 'Column15' + ',' + 'Column16' + ',' + 'Column17' + ',' + 'Column18' + ',' + 'Column19');

        SAPSummary.Reset();
        //  SAPSummary.SetRange(Exported, false);
        if pExportType = pExportType::Selected then
            SAPSummary.SetFilter("Entry No.", CopyStr(SummaryEntries.ToText(), 1, SummaryEntries.Length - 1));
        SAPSummary.SetRange(Type, pType);
        if RegisterNo <> 0 then
            SAPSummary.SetRange("SAP Register No.", RegisterNo);
        SAPSummary.SetRange(Reversed, false);
        if SAPSummary.FindSet() then
            repeat
                Counter += 1;
                Progress.Update(1, Counter);
                TxtBuilder.AppendLine(AddDoubleQuotes(SAPSummary."Column 1") + ',' + AddDoubleQuotes(SAPSummary."Column 2") + ',' + AddDoubleQuotes(SAPSummary."Column 3") + ',' + AddDoubleQuotes(SAPSummary."Column 4") + ',' + AddDoubleQuotes(SAPSummary."Column 5")
                 + ',' + AddDoubleQuotes(SAPSummary."Column 6") + ',' + AddDoubleQuotes(SAPSummary."Column 7") + ',' + AddDoubleQuotes(SAPSummary."Column 8") + ',' + AddDoubleQuotes(SAPSummary."Column 9") + ',' + AddDoubleQuotes(SAPSummary."Column 10")
                  + ',' + AddDoubleQuotes(SAPSummary."Column 11") + ',' + AddDoubleQuotes(SAPSummary."Column 12") + ',' + AddDoubleQuotes(SAPSummary."Column 13") + ',' + AddDoubleQuotes(SAPSummary."Column 14") + ',' + AddDoubleQuotes(SAPSummary."Column 15")
                  + ',' + AddDoubleQuotes(SAPSummary."Column 16") + ',' + AddDoubleQuotes(SAPSummary."Column 17") + ',' + AddDoubleQuotes(SAPSummary."Column 18") + ',' + AddDoubleQuotes(SAPSummary."Column 19"));
                SAPSummary.Exported := true;
                SAPSummary.Modify();
            until SAPSummary.Next() = 0
        else
            Error('Nothing to export!');

        TempBlob.CreateOutStream(OutStream);
        OutStream.WriteText(TxtBuilder.ToText());
        TempBlob.CreateInStream(Instream);
        Progress.Close();
        DownloadFromStream(Instream, '', '', '', FileName);

    end;

    local procedure AddDoubleQuotes(FieldValue: Text): Text
    begin
        exit('"' + FieldValue + '"');
    end;

    local procedure InsertSAPRegster(ptype: Enum Type)
    begin
        SAPRegister.Init();
        SAPRegister.Validate("Posting Date", today);
        SAPRegister.Validate("Type", ptype);
        SAPRegister.Insert(true);
    end;

    local procedure MarkTTSRecordsasPosted(var ExportType: Enum "Summary Export Type"; Productdec: text)
    var
        TTS: Record TTS_SAP;
        UpdateTTSStaging: Query UpdateTTSStaging;
    begin
        if ExportType = ExportType::Selected then
            UpdateTTSStaging.SetFilter(Entry_No_, CopyStr(LOBEntries.ToText(), 1, LOBEntries.Length - 1));
        UpdateTTSStaging.SetRange(Scheme, SAPIntegrationSetup.Scheme);
        UpdateTTSStaging.SetRange(country, SAPIntegrationSetup."Country Code");
        UpdateTTSStaging.SetRange(activity, SAPIntegrationSetup."Source Activity");
        UpdateTTSStaging.SetRange(salesperson, SalesPerson.Name);
        if Productdec <> '' then
            UpdateTTSStaging.SetRange(product, Productdec);
        if SAPIntegrationSetup.TestMatch then
            UpdateTTSStaging.SetRange(testmatch, 'TESTMATCH');
        if SAPIntegrationSetup.RefundOAB then
            UpdateTTSStaging.SetRange(REFUNDOAB, 'REFUNDOAB');
        if UpdateTTSStaging.Open() then
            while UpdateTTSStaging.Read() do begin
                TTS.Posted := TTS.Get(UpdateTTSStaging.Entry);
                TTS."SAP Register No." := SAPRegister."Entry No.";
                TTS.Modify(true);
            end;
    end;

    local procedure MarkCPMSRecordsasPosted(var ExportType: Enum "Summary Export Type"; Productdec: text)
    var
        CPMS: Record TTS_ARAP;
        UpdateCPMSStaging: Query UpdateCPMSStaging;
    begin
        if ExportType = ExportType::Selected then
            UpdateCPMSStaging.SetFilter(Entry_No_, CopyStr(CPMSEntries.ToText(), 1, CPMSEntries.Length - 1));
        UpdateCPMSStaging.SetRange(Scheme, SAPIntegrationSetup.Scheme);
        UpdateCPMSStaging.SetRange(country, SAPIntegrationSetup."Country Code");
        UpdateCPMSStaging.SetRange(activity, SAPIntegrationSetup."Source Activity");
        UpdateCPMSStaging.SetRange(salesperson, SalesPerson.Name);
        if Productdec <> '' then
            UpdateCPMSStaging.SetRange(product, Productdec);
        if SAPIntegrationSetup.TestMatch then
            UpdateCPMSStaging.SetRange(testmatch, 'TESTMATCH');
        if SAPIntegrationSetup.RefundOAB then
            UpdateCPMSStaging.SetRange(REFUNDOAB, 'REFUNDOAB');
        if UpdateCPMSStaging.Open() then
            while UpdateCPMSStaging.Read() do begin
                CPMS.Posted := CPMS.Get(UpdateCPMSStaging.Entry);
                CPMS."SAP Register No." := SAPRegister."Entry No.";
                CPMS.Modify(true);
            end;
    end;

    local procedure UpdateSAPRegisterNoInSAPJoural(RegisterNo: Integer)
    var
        SAPJournal: Record "SAP Journal";
        SAPRegister: Record SAP_Summary_Register;
        Confirmation: Label 'Journal lines have been created successfully. \ Do you want to open the SAP register?';
    begin
        SAPJournal.Reset();
        SAPJournal.SetRange("Entry No.", FromEntry, ToEntry);
        if SAPJournal.FindSet(true) then
            SAPJournal.ModifyAll("SAP Register No.", RegisterNo);

        SAPRegister.Reset();
        SAPRegister.SetRange("Entry No.", RegisterNo);
        if Confirm(Confirmation, true) then
            page.Run(0, SAPRegister);
    end;


    var
        SAPIntegrationSetup: Record "SAP Journal Rules";

        SalesPerson: Record "Salesperson/Purchaser";
        SAPSummary: Record "SAP Journal";
        //    SelectedLOB: Record TTS_SAP temporary;

        SelectedCPMS: record TTS_ARAP temporary;
        SAPRegister: Record SAP_Summary_Register;
        SelectedSummary: Record "SAP Journal" temporary;

        Item: Record Item;

        LOBEntries, CPMSEntries, SummaryEntries : TextBuilder;

        Progress: Dialog;
        Counter, CreditEntryNo, DebitEntryNo : Integer;
        ProgressMsg: Label 'Processing SAP Journal......#1######################\';
        ProgressCPMS: Label 'CPMS......#1######################\';

        FromEntry, ToEntry : Integer;
}
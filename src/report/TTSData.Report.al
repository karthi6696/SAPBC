report 85007 "TTS Data"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = MyExcelLayout;
    ExcelLayoutMultipleDataSheets = true;

    dataset
    {
        dataitem(TTS_Data; TTS_SAP)
        {
            RequestFilterFields = TESTMATCH, Activity;

            column(Activity_TTS_SAP; Activity)
            {
            }
            column(CLE_EntryNo_TTS_SAP; CLE_EntryNo)
            {
            }
            column(Country_TTS_SAP; Country)
            {
            }
            column(CustomerNumber_TTS_SAP; CustomerNumber)
            {
            }
            column(file_duplicate_TTS_SAP; file_duplicate)
            {
            }
            column(FileDate_TTS_SAP; FileDate)
            {
            }
            column(FinanceSapId_TTS_SAP; FinanceSapId)
            {
            }
            column(ImportedDateTime_TTS_SAP; SystemCreatedAt)
            {
            }
            column(InvAddressLine1_TTS_SAP; InvAddressLine1)
            {
            }
            column(InvAddressLine2_TTS_SAP; InvAddressLine2)
            {
            }
            column(InvAddressLine3_TTS_SAP; InvAddressLine3)
            {
            }
            column(InvAddressLine4_TTS_SAP; InvAddressLine4)
            {
            }
            column(InvCity_TTS_SAP; InvCity)
            {
            }
            column(InvCustomerName_TTS_SAP; InvCustomerName)
            {
            }
            column(INVOICE_TTS_SAP; INVOICE)
            {
            }
            column(InvoiceDate_TTS_SAP; InvoiceDate)
            {
            }
            column(InvoiceNumber_TTS_SAP; InvoiceNumber)
            {
            }
            column(InvoicePostingDate_TTS_SAP; InvoicePostingDate)
            {
            }
            column(InvPostalCode_TTS_SAP; InvPostalCode)
            {
            }
            column(LineAmountNet_TTS_SAP; "Line Amount Net")
            {
            }
            column(LineDescription_TTS_SAP; "Line Description")
            {
            }
            column(LineId_TTS_SAP; LineId)
            {
            }
            column(LongText_TTS_SAP; LongText)
            {
            }
            column(MatchDetails_TTS_SAP; "Match Details")
            {
            }
            column(MatchType_TTS_SAP; "Match Type")
            {
            }
            column(MatchedBy_TTS_SAP; "Matched By")
            {
            }
            column(MatchingID_TTS_SAP; "Matching ID")
            {
            }
            column(MatchingProcessedDateTime_TTS_SAP; "Matching Processed Date Time")
            {
            }
            column(MatchingStatus_TTS_SAP; "Matching Status")
            {
            }
            column(OabTransferValueGross_TTS_SAP; OabTransferValueGross)
            {
            }
            column(OrderReference_TTS_SAP; "Order Reference")
            {
            }
            column(PayinginBatchRef_TTS_SAP; "Paying in Batch Ref")
            {
            }
            column(PaymentReference_TTS_SAP; PaymentReference)
            {
            }
            column(Posted_TTS_SAP; Posted)
            {
            }
            column(ProcessedDateTime_TTS_SAP; "Processed Date")
            {
            }
            column(Product_TTS_SAP; Product)
            {
            }
            column(REFGOODS_TTS_SAP; REFGOODS)
            {
            }
            column(REFUNDOAB_TTS_SAP; REFUNDOAB)
            {
            }
            column(REVTESTM_TTS_SAP; REVTESTM)
            {
            }
            column(RuleNo_TTS_SAP; "Rule No.")
            {
            }
            column(SalesPerson_TTS_SAP; SalesPerson)
            {
            }
            column(SAPRegisterNo_TTS_SAP; "SAP Register No.")
            {
            }
            column(Scheme_TTS_SAP; Scheme)
            {
            }
            column(SynapseError_TTS_SAP; "Synapse Error")
            {
            }
            column(SynapseErrorDescription_TTS_SAP; "Synapse Error Description")
            {
            }
            column(TaxAmount_TTS_SAP; "Tax Amount")
            {
            }
            column(TaxCode_TTS_SAP; "Tax Code")
            {
            }
            column(TestLocation_TTS_SAP; "Test Location")
            {
            }
            column(test_duplicate_TTS_SAP; test_duplicate)
            {
            }
            column(TestCostWithoutVat_TTS_SAP; TestCostWithoutVat)
            {
            }
            column(TestDate_TTS_SAP; TestDate)
            {
            }
            column(TESTMATCH_TTS_SAP; TESTMATCH)
            {
            }
            column(TestReference_TTS_SAP; TestReference)
            {
            }
            trigger OnPreDataItem()
            var
                StartDateTime: DateTime;
                EndDateTime: DateTime;
            begin
                if not GuiAllowed then begin
                    StartDateTime := CreateDateTime(
                 CalcDate('<-CM>', WorkDate()),
                 000000T);

                    EndDateTime := CreateDateTime(
                        CalcDate('<CM>', WorkDate()),
                        235959T);

                    TTS_Data.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {

        }
        trigger OnOpenPage()
        var
            StartDateTime: DateTime;
            EndDateTime: DateTime;
        begin

            StartDateTime := CreateDateTime(
         CalcDate('<-CM>', WorkDate()),
         000000T);

            EndDateTime := CreateDateTime(
                CalcDate('<CM>', WorkDate()),
                235959T);

            TTS_Data.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
        end;
    }

    rendering
    {
        layout(MyExcelLayout)
        {
            type = Excel;
            LayoutFile = 'TTSData.xlsx';
        }
    }

}
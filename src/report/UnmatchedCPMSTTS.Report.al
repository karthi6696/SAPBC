report 85008 "Unmatched CPMS TTS"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = MyExcelLayout;
    ExcelLayoutMultipleDataSheets = true;

    dataset
    {
        dataitem(CPMSStaging; TTS_ARAP)
        {
            RequestFilterFields = "LOB Match Type";

            column(Activity_TTS_ARAP; Activity)
            {
            }
            column(CcReference_TTS_ARAP; CcReference)
            {
            }
            column(Country_TTS_ARAP; Country)
            {
            }
            column(EODMatchDetails_TTS_ARAP; "EOD Match Details")
            {
            }
            column(EODMatchType_TTS_ARAP; "EOD Match Type")
            {
            }
            column(EODMatchedBy_TTS_ARAP; "EOD Matched By")
            {
            }
            column(EODMatchingID_TTS_ARAP; "EOD Matching ID")
            {
            }
            column(EODMatchingStatus_TTS_ARAP; "EOD Matching Status")
            {
            }
            column(EODProcessedDateTime_TTS_ARAP; "EOD Processed Date Time")
            {
            }
            column(EODRuleNo_TTS_ARAP; "EOD Rule No.")
            {
            }
            column(FileDate_TTS_ARAP; FileDate)
            {
            }
            column(FinanceArapId_TTS_ARAP; FinanceArapId)
            {
            }
            column(ImportedDateTime_TTS_ARAP; SystemCreatedAt)
            {
            }
            column(InvAddressLine1_TTS_ARAP; InvAddressLine1)
            {
            }
            column(InvAddressLine2_TTS_ARAP; InvAddressLine2)
            {
            }
            column(InvAddressLine3_TTS_ARAP; InvAddressLine3)
            {
            }
            column(InvAddressLine4_TTS_ARAP; InvAddressLine4)
            {
            }
            column(InvCity_TTS_ARAP; InvCity)
            {
            }
            column(InvCustomerName_TTS_ARAP; InvCustomerName)
            {
            }
            column(InvCustomerNumber_TTS_ARAP; InvCustomerNumber)
            {
            }
            column(INVOICE_TTS_ARAP; INVOICE)
            {
            }
            column(InvoiceAmount_TTS_ARAP; InvoiceAmount)
            {
            }
            column(InvoiceDate_TTS_ARAP; InvoiceDate)
            {
            }
            column(InvoiceNumber_TTS_ARAP; InvoiceNumber)
            {
            }
            column(InvPostalCode_TTS_ARAP; InvPostalCode)
            {
            }
            column(InvReference_TTS_ARAP; InvReference)
            {
            }
            column(LineAmountNet_TTS_ARAP; LineAmountNet)
            {
            }
            column(LineDescription_TTS_ARAP; LineDescription)
            {
            }
            column(LineIdentifier_TTS_ARAP; LineIdentifier)
            {
            }
            column(LOBMatchDetails_TTS_ARAP; "LOB Match Details")
            {
            }
            column(LOBMatchType_TTS_ARAP; "LOB Match Type")
            {
            }
            column(LOBMatchedBy_TTS_ARAP; "LOB Matched By")
            {
            }
            column(LOBMatchingID_TTS_ARAP; "LOB Matching ID")
            {
            }
            column(LOBMatchingStatus_TTS_ARAP; "LOB Matching Status")
            {
            }
            column(LOBProcessedDateTime_TTS_ARAP; "LOB Processed Date Time")
            {
            }
            column(LOBRuleNo_TTS_ARAP; "LOB Rule No.")
            {
            }
            column(OrderReference_TTS_ARAP; OrderReference)
            {
            }
            column(ORIGIN_TTS_ARAP; ORIGIN)
            {
            }
            column(Payee_TTS_ARAP; Payee)
            {
            }
            column(PayingInBatchReference_TTS_ARAP; PayingInBatchReference)
            {
            }
            column(PaymentAuthcode_TTS_ARAP; "Payment Authcode")
            {
            }
            column(PaymentProvider_TTS_ARAP; "Payment Provider")
            {
            }
            column(PaymentResult_TTS_ARAP; "Payment Result")
            {
            }
            column(Posted_TTS_ARAP; Posted)
            {
            }
            column(ProcessedDateTime_TTS_ARAP; "Processed Date")
            {
            }
            column(RecAddressLine1_TTS_ARAP; RecAddressLine1)
            {
            }
            column(RecAddressLine2_TTS_ARAP; RecAddressLine2)
            {
            }
            column(RecAddressLine3_TTS_ARAP; RecAddressLine3)
            {
            }
            column(RecAddressLine4_TTS_ARAP; RecAddressLine4)
            {
            }
            column(RecCity_TTS_ARAP; RecCity)
            {
            }
            column(RecCustomerName_TTS_ARAP; RecCustomerName)
            {
            }
            column(RecCustomerNumber_TTS_ARAP; RecCustomerNumber)
            {
            }
            column(ReceiptAmount_TTS_ARAP; ReceiptAmount)
            {
            }
            column(ReceiptDate_TTS_ARAP; ReceiptDate)
            {
            }
            column(ReceiptGlDate_TTS_ARAP; ReceiptGlDate)
            {
            }
            column(ReceiptMatchAmount_TTS_ARAP; ReceiptMatchAmount)
            {
            }
            column(ReceiptMethod_TTS_ARAP; ReceiptMethod)
            {
            }
            column(ReceiptNumber_TTS_ARAP; ReceiptNumber)
            {
            }
            column(RecPostalCode_TTS_ARAP; RecPostalCode)
            {
            }
            column(RecReference_TTS_ARAP; RecReference)
            {
            }
            column(RefundAmount_TTS_ARAP; RefundAmount)
            {
            }
            column(RuleDuration_TTS_ARAP; RuleDuration)
            {
            }
            column(RuleStartDate_TTS_ARAP; RuleStartDate)
            {
            }
            column(SalesPerson_TTS_ARAP; SalesPerson)
            {
            }
            column(SAPRegisterNo_TTS_ARAP; "SAP Register No.")
            {
            }
            column(Scheme_TTS_ARAP; Scheme)
            {
            }
            column(SourceActivityOrigin_TTS_ARAP; "Source Activity-Origin")
            {
            }
            column(SynapseError_TTS_ARAP; "Synapse Error")
            {
            }
            column(SynapseErrorDescription_TTS_ARAP; "Synapse Error Description")
            {
            }
            column(TaxAmount_TTS_ARAP; TaxAmount)
            {
            }
            column(TaxCode_TTS_ARAP; TaxCode)
            {
            }
            column(TESTMATCH_TTS_ARAP; TESTMATCH)
            {
            }
            column(TestType_TTS_ARAP; TestType)
            {
            }
        }
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
                    TTS_Data.SetRange("Match Type", TTS_Data."Match Type"::None);

                    CPMSStaging.SetRange("LOB Match Type", CPMSStaging."LOB Match Type"::None);

                    StartDateTime := CreateDateTime(
        CalcDate('<-CM>', WorkDate()),
        000000T);

                    EndDateTime := CreateDateTime(
                        CalcDate('<CM>', WorkDate()),
                        235959T);

                    TTS_Data.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
                    CPMSStaging.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
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
            TTS_Data.SetRange("Match Type", TTS_Data."Match Type"::None);

            CPMSStaging.SetRange("LOB Match Type", CPMSStaging."LOB Match Type"::None);

            StartDateTime := CreateDateTime(
CalcDate('<-CM>', WorkDate()),
000000T);

            EndDateTime := CreateDateTime(
                CalcDate('<CM>', WorkDate()),
                235959T);

            TTS_Data.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
            CPMSStaging.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
        end;
    }

    rendering
    {
        layout(MyExcelLayout)
        {
            type = Excel;
            LayoutFile = 'UnmatchedCPMSTTS.xlsx';
        }
    }

}
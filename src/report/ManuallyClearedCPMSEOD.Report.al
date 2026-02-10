report 85005 "Manually Cleared CPMS EOD"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = MyExcelLayout;
    ExcelLayoutMultipleDataSheets = true;

    dataset
    {
        dataitem(CPMSStaging; TTS_ARAP)
        {
            RequestFilterFields = "EOD Match Type";

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
        dataitem("EOD Staging"; "EOD Staging")
        {
            RequestFilterFields = "Match Type";

            column(AlternateFundCode_EODStaging; "Alternate Fund Code")
            {
            }
            column(AlternatePayCode_EODStaging; "Alternate Pay Code")
            {
            }
            column(AuthCode_EODStaging; "Auth Code")
            {
            }
            column(CardLongNumber_EODStaging; "Card Long Number")
            {
            }
            column(CardTransactionType_EODStaging; "Card Transaction Type")
            {
            }
            column(FundCode_EODStaging; "Fund Code")
            {
            }
            column(ImportedDateTime_EODStaging; SystemCreatedAt)
            {
            }
            column(IssueNumber_EODStaging; "Issue Number")
            {
            }
            column(Last4CardDigits_EODStaging; "Last 4 Card Digits")
            {
            }
            column(MatchDetails_EODStaging; "Match Details")
            {
            }
            column(MatchedBy_EODStaging; "Matched By")
            {
            }
            column(MatchType_EODStaging; "Match Type")
            {
            }
            column(MatchingID_EODStaging; "Matching ID")
            {
            }
            column(MatchingProcessedDateTime_EODStaging; "Matching Processed Date Time")
            {
            }
            column(MatchingStatus_EODStaging; "Matching Status")
            {
            }
            column(Name_EODStaging; Name)
            {
            }
            column(Narrative_EODStaging; Narrative)
            {
            }
            column(PayAmount_EODStaging; "Pay Amount")
            {
            }
            column(PayCode_EODStaging; "Pay Code")
            {
            }
            column(PaymentReference_EODStaging; "Payment Reference")
            {
            }
            column(ProcessDate_EODStaging; "Process Date")
            {
            }
            column(ProcessTime_EODStaging; "Process Time")
            {
            }
            column(RecordAmount_EODStaging; "Record Amount")
            {
            }
            column(ReferenceNumber_EODStaging; "Reference Number")
            {
            }
            column(ReferenceNumber2_EODStaging; "Reference Number 2")
            {
            }
            column(Reversed_EODStaging; Reversed)
            {
            }
            column(RuleNo_EODStaging; "Rule No.")
            {
            }
            column(SecureTransactionId_EODStaging; "Secure Transaction Id")
            {
            }
            column(SiteID_EODStaging; "Site ID")
            {
            }
            column(Surname_EODStaging; Surname)
            {
            }
            column(SynapseError_EODStaging; "Synapse Error")
            {
            }
            column(SynapseErrorDescription_EODStaging; "Synapse Error Description")
            {
            }
            column(TransactionAmount_EODStaging; "Transaction Amount")
            {
            }
            column(TransactionDate_EODStaging; "Transaction Date")
            {
            }
            column(TransactionTime_EODStaging; "Transaction Time")
            {
            }
            column(TransactionType_EODStaging; "Transaction Type")
            {
            }
            column(UniqueTransId_EODStaging; "Unique Trans Id")
            {
            }
            column(UserCode_EODStaging; "User Code")
            {
            }
            trigger OnPreDataItem()
            var
                StartDateTime: DateTime;
                EndDateTime: DateTime;
            begin
                if not GuiAllowed then begin
                    "EOD Staging".SetRange("Match Type", "EOD Staging"."Match Type"::Manual);

                    CPMSStaging.SetRange("EOD Match Type", CPMSStaging."EOD Match Type"::Manual);

                    StartDateTime := CreateDateTime(
        CalcDate('<-CM>', WorkDate()),
        000000T);

                    EndDateTime := CreateDateTime(
                        CalcDate('<CM>', WorkDate()),
                        235959T);

                    "EOD Staging".SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
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
            "EOD Staging".SetRange("Match Type", "EOD Staging"."Match Type"::Manual);

            CPMSStaging.SetRange("EOD Match Type", CPMSStaging."EOD Match Type"::Manual);

            StartDateTime := CreateDateTime(
CalcDate('<-CM>', WorkDate()),
000000T);

            EndDateTime := CreateDateTime(
                CalcDate('<CM>', WorkDate()),
                235959T);

            "EOD Staging".SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
            CPMSStaging.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);

        end;
    }

    rendering
    {
        layout(MyExcelLayout)
        {
            type = Excel;
            LayoutFile = 'ManuallyClearedItemsCPMSEOD.xlsx';
        }
    }

}
report 85001 "Unprocessed CPMS Records"
{
    Caption = 'Unprocessed CPMS Records';
    ExcelLayout = './layouts/UnprocessedCPMSRecords.xlsx';
    DefaultLayout = Excel;

    dataset
    {
        dataitem(TTS_ARAP; TTS_ARAP)
        {
            DataItemTableView = where(Posted = filter(false));
            column(Activity; Activity)
            {
            }
            column(CcReference; CcReference)
            {
            }
            column(Country; Country)
            {
            }
            column(EODMatchDetails; "EOD Match Details")
            {
            }
            column(EODMatchType; "EOD Match Type")
            {
            }
            column(EODMatchedBy; "EOD Matched By")
            {
            }
            column(EODMatchingID; "EOD Matching ID")
            {
            }
            column(EODMatchingStatus; "EOD Matching Status")
            {
            }
            column(EODProcessedDateTime; "EOD Processed Date Time")
            {
            }
            column(EODRuleNo; "EOD Rule No.")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(ErrorExits; "Error Exists")
            {
            }
            column(FileDate; FileDate)
            {
            }
            column(FinanceArapId; FinanceArapId)
            {
            }
            column(INVOICE; INVOICE)
            {
            }
            column(ImportedDateTime; SystemCreatedAt)
            {
            }
            column(InvAddressLine1; InvAddressLine1)
            {
            }
            column(InvAddressLine2; InvAddressLine2)
            {
            }
            column(InvAddressLine3; InvAddressLine3)
            {
            }
            column(InvAddressLine4; InvAddressLine4)
            {
            }
            column(InvCity; InvCity)
            {
            }
            column(InvCustomerName; InvCustomerName)
            {
            }
            column(InvCustomerNumber; InvCustomerNumber)
            {
            }
            column(InvPostalCode; InvPostalCode)
            {
            }
            column(InvReference; InvReference)
            {
            }
            column(InvoiceAmount; InvoiceAmount)
            {
            }
            column(InvoiceDate; InvoiceDate)
            {
            }
            column(InvoiceNumber; InvoiceNumber)
            {
            }
            column(LOBMatchDetails; "LOB Match Details")
            {
            }
            column(LOBMatchType; "LOB Match Type")
            {
            }
            column(LOBMatchedBy; "LOB Matched By")
            {
            }
            column(LOBMatchingID; "LOB Matching ID")
            {
            }
            column(LOBMatchingStatus; "LOB Matching Status")
            {
            }
            column(LOBProcessedDateTime; "LOB Processed Date Time")
            {
            }
            column(LOBRuleNo; "LOB Rule No.")
            {
            }
            column(LineAmountNet; LineAmountNet)
            {
            }
            column(LineDescription; LineDescription)
            {
            }
            column(LineIdentifier; LineIdentifier)
            {
            }
            column(ORIGIN; ORIGIN)
            {
            }
            column(OrderReference; OrderReference)
            {
            }
            column(Payee; Payee)
            {
            }
            column(PayingInBatchReference; PayingInBatchReference)
            {
            }
            column(PaymentAuthcode; "Payment Authcode")
            {
            }
            column(PaymentProvider; "Payment Provider")
            {
            }
            column(PaymentResult; "Payment Result")
            {
            }
            column(Posted; Posted)
            {
            }
            column(ProcessedDateTime; "Processed Date")
            {
            }
            column(RecAddressLine1; RecAddressLine1)
            {
            }
            column(RecAddressLine2; RecAddressLine2)
            {
            }
            column(RecAddressLine3; RecAddressLine3)
            {
            }
            column(RecAddressLine4; RecAddressLine4)
            {
            }
            column(RecCity; RecCity)
            {
            }
            column(RecCustomerName; RecCustomerName)
            {
            }
            column(RecCustomerNumber; RecCustomerNumber)
            {
            }
            column(RecPostalCode; RecPostalCode)
            {
            }
            column(RecReference; RecReference)
            {
            }
            column(ReceiptAmount; ReceiptAmount)
            {
            }
            column(ReceiptDate; ReceiptDate)
            {
            }
            column(ReceiptGlDate; ReceiptGlDate)
            {
            }
            column(ReceiptMatchAmount; ReceiptMatchAmount)
            {
            }
            column(ReceiptMethod; ReceiptMethod)
            {
            }
            column(ReceiptNumber; ReceiptNumber)
            {
            }
            column(RefundAmount; RefundAmount)
            {
            }
            column(RuleDuration; RuleDuration)
            {
            }
            column(RuleStartDate; RuleStartDate)
            {
            }
            column(SAPRegisterNo; "SAP Register No.")
            {
            }
            column(SalesPerson; SalesPerson)
            {
            }
            column(Scheme; Scheme)
            {
            }
            column(SourceActivityOrigin; "Source Activity-Origin")
            {
            }
            column(SynapseError; "Synapse Error")
            {
            }
            column(SynapseErrorDescription; "Synapse Error Description")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TESTMATCH; TESTMATCH)
            {
            }
            column(TaxAmount; TaxAmount)
            {
            }
            column(TaxCode; TaxCode)
            {
            }
            column(TestType; TestType)
            {
            }
            trigger OnPreDataItem()
            var
                StartDateTime: DateTime;
                EndDateTime: DateTime;

            begin
                if not GuiAllowed then begin
                    TTS_ARAP.SetRange(Posted, false);

                    StartDateTime := CreateDateTime(
        CalcDate('<-CM>', WorkDate()),
        000000T);

                    EndDateTime := CreateDateTime(
                        CalcDate('<CM>', WorkDate()),
                        235959T);

                    TTS_ARAP.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        trigger OnOpenPage()
        var
            StartDateTime: DateTime;
            EndDateTime: DateTime;

        begin
            TTS_ARAP.SetRange(Posted, false);

            StartDateTime := CreateDateTime(
CalcDate('<-CM>', WorkDate()),
000000T);

            EndDateTime := CreateDateTime(
                CalcDate('<CM>', WorkDate()),
                235959T);

            TTS_ARAP.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);

        end;
    }
}

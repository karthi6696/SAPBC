report 85002 "Unprocessed TTS Records"
{
    Caption = 'Unprocessed TTS Records';
    ExcelLayout = './layouts/UnprocessedTTSRecords.xlsx';
    DefaultLayout = Excel;


    dataset
    {
        dataitem(TTS_SAP; TTS_SAP)
        {
            DataItemTableView = where(Posted = filter(false));
            column(Activity; Activity)
            {
            }
            column(CLE_EntryNo; CLE_EntryNo)
            {
            }
            column(Country; Country)
            {
            }
            column(CustomerNumber; CustomerNumber)
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
            column(FinanceSapId; FinanceSapId)
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
            column(InvPostalCode; InvPostalCode)
            {
            }
            column(InvoiceDate; InvoiceDate)
            {
            }
            column(InvoiceNumber; InvoiceNumber)
            {
            }
            column(InvoicePostingDate; InvoicePostingDate)
            {
            }
            column(LineAmountNet; "Line Amount Net")
            {
            }
            column(LineDescription; "Line Description")
            {
            }
            column(LineId; LineId)
            {
            }
            column(LongText; LongText)
            {
            }
            column(MatchDetails; "Match Details")
            {
            }
            column(MatchType; "Match Type")
            {
            }
            column(MatchedBy; "Matched By")
            {
            }
            column(MatchingID; "Matching ID")
            {
            }
            column(MatchingProcessedDateTime; "Matching Processed Date Time")
            {
            }
            column(MatchingStatus; "Matching Status")
            {
            }
            column(OabTransferValueGross; OabTransferValueGross)
            {
            }
            column(OrderReference; "Order Reference")
            {
            }
            column(PayinginBatchRef; "Paying in Batch Ref")
            {
            }
            column(PaymentReference; PaymentReference)
            {
            }
            column(Posted; Posted)
            {
            }
            column(ProcessedDateTime; "Processed Date")
            {
            }
            column(Product; Product)
            {
            }
            column(REFGOODS; REFGOODS)
            {
            }
            column(REFUNDOAB; REFUNDOAB)
            {
            }
            column(REVTESTM; REVTESTM)
            {
            }
            column(RuleNo; "Rule No.")
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
            column(TaxAmount; "Tax Amount")
            {
            }
            column(TaxCode; "Tax Code")
            {
            }
            column(TestLocation; "Test Location")
            {
            }
            column(TestCostWithoutVat; TestCostWithoutVat)
            {
            }
            column(TestDate; TestDate)
            {
            }
            column(TestReference; TestReference)
            {
            }
            column(file_duplicate; file_duplicate)
            {
            }
            column(test_duplicate; test_duplicate)
            {
            }

            trigger OnPreDataItem()
            var
                StartDateTime: DateTime;
                EndDateTime: DateTime;
            begin
                if not GuiAllowed then begin
                    TTS_SAP.SetRange(Posted, false);
                    StartDateTime := CreateDateTime(
                 CalcDate('<-CM>', WorkDate()),
                 000000T);

                    EndDateTime := CreateDateTime(
                        CalcDate('<CM>', WorkDate()),
                        235959T);

                    TTS_SAP.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
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
            TTS_SAP.SetRange(Posted, false);
            StartDateTime := CreateDateTime(
         CalcDate('<-CM>', WorkDate()),
         000000T);

            EndDateTime := CreateDateTime(
                CalcDate('<CM>', WorkDate()),
                235959T);

            TTS_SAP.SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
        end;
    }
}

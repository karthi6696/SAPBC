report 85004 "EOD Data"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = MyExcelLayout;
    ExcelLayoutMultipleDataSheets = true;

    dataset
    {
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
                    StartDateTime := CreateDateTime(
                 CalcDate('<-CM>', WorkDate()),
                 000000T);

                    EndDateTime := CreateDateTime(
                        CalcDate('<CM>', WorkDate()),
                        235959T);

                    "EOD Staging".SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
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

            "EOD Staging".SetRange(SystemCreatedAt, StartDateTime, EndDateTime);
        end;
    }

    rendering
    {
        layout(MyExcelLayout)
        {
            type = Excel;
            LayoutFile = 'EODData.xlsx';
        }
    }

}
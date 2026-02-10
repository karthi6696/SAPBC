page 85043 "Govpay EOD Data"
{
    APIGroup = 'bcsap';
    APIPublisher = 'dvsa';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'govpayData';
    DelayedInsert = true;
    EntityName = 'govpayData';
    EntitySetName = 'govpayData';
    PageType = API;
    SourceTable = "EOD Staging";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(uniqueTransId; Rec."Unique Trans Id")
                {
                    Caption = 'Unique Trans Id';
                }
                field(fundCode; Rec."Fund Code")
                {
                    Caption = 'Fund Code';
                }
                field(entryNo; Rec.Id)
                {
                    Caption = 'Entry No.';
                }
                field(siteID; Rec."Site ID")
                {
                    Caption = 'Site ID';
                }
                field("transactionType"; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type';
                }
                field(transactionDate; Rec."Transaction Date")
                {
                    Caption = 'Transaction Date';
                }
                field(transactionTime; Rec."Transaction Time")
                {
                    Caption = 'Transaction Time';
                }
                field(payCode; Rec."Pay Code")
                {
                    Caption = 'Pay Code';
                }
                field(transactionAmount; Rec."Transaction Amount")
                {
                    Caption = 'Transaction Amount';
                }
                field(secureTransactionId; Rec."Secure Transaction Id")
                {
                    Caption = 'Secure Transaction Id';
                }
                field(authCode; Rec."Auth Code")
                {
                    Caption = 'Auth Code';
                }
                field(recordAmount; Rec."Record Amount")
                {
                    Caption = 'Record Amount';
                }
                field(payAmount; Rec."Pay Amount")
                {
                    Caption = 'Pay Amount';
                }
                field(issueNumber; Rec."Issue Number")
                {
                    Caption = 'Issue Number';
                }
                field(last4CardDigits; Rec."Last 4 Card Digits")
                {
                    Caption = 'Last 4 Card Digits';
                }
                field(cardTransactionType; Rec."Card Transaction Type")
                {
                    Caption = 'Card Transaction Type';
                }
                field(cardLongNumber; Rec."Card Long Number")
                {
                    Caption = 'Card Long Number';
                }
                field(reversed; Rec.Reversed)
                {
                    Caption = 'Reversed';
                }
                field(referenceNumber; Rec."Reference Number")
                {
                    Caption = 'Reference Number';
                }
                field(referenceNumber2; Rec."Reference Number 2")
                {
                    Caption = 'Reference Number 2';
                }
                field(narrative; Rec.Narrative)
                {
                    Caption = 'Narrative';
                }
                field(paymentReference; Rec."Payment Reference")
                {
                    Caption = 'Payment Reference';
                }
                field(processDate; Rec."Process Date")
                {
                    Caption = 'Process Date';
                }
                field(processTime; Rec."Process Time")
                {
                    Caption = 'Process Time';
                }
                field(alternateFundCode; Rec."Alternate Fund Code")
                {
                    Caption = 'Alternate Fund Code';
                }
                field(alternatePayCode; Rec."Alternate Pay Code")
                {
                    Caption = 'Alternate Pay Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(synapseError; Rec."Synapse Error")
                {
                    Caption = 'Synapse Error';
                }
                field(synapseErrorDescription; Rec."Synapse Error Description")
                {
                    Caption = 'Synapse Error Description';
                }
                field(sourceIdentifier; Rec."Source Identifier")
                {
                    Caption = 'Source Identifier';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }

}
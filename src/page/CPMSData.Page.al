page 85012 "CPMS Data"
{
    APIGroup = 'bcsap';
    APIPublisher = 'dvsa';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'cpmsData';
    DelayedInsert = true;
    EntityName = 'cpmsData';
    EntitySetName = 'cpmsData';
    PageType = API;
    SourceTable = TTS_ARAP;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(activity; Rec.Activity)
                {
                    Caption = 'Activity';
                }
                field(ccReference; Rec.CcReference)
                {
                    Caption = 'CcReference';
                }
                field(country; Rec.Country)
                {
                    Caption = 'Country';
                }
                field(entryNo; Rec.Id)
                {
                    Caption = 'Entry No.';
                }
                field(fileDate; Rec.FileDate)
                {
                    Caption = 'FileDate';
                }
                field(sourceActivityOrigin; Rec."Source Activity-Origin")
                {
                    Caption = 'Source Activity (Origin)';
                }
                field(invoice; Rec.INVOICE)
                {
                    Caption = 'INVOICE';
                }
                field(invAddressLine1; Rec.InvAddressLine1)
                {
                    Caption = 'InvAddressLine1';
                }
                field(invAddressLine2; Rec.InvAddressLine2)
                {
                    Caption = 'InvAddressLine2';
                }
                field(invAddressLine3; Rec.InvAddressLine3)
                {
                    Caption = 'InvAddressLine3';
                }
                field(invAddressLine4; Rec.InvAddressLine4)
                {
                    Caption = 'InvAddressLine4';
                }
                field(invCity; Rec.InvCity)
                {
                    Caption = 'InvCity';
                }
                field(invCustomerName; Rec.InvCustomerName)
                {
                    Caption = 'InvCustomerName';
                }
                field(invCustomerNumber; Rec.InvCustomerNumber)
                {
                    Caption = 'InvCustomerNumber';
                }
                field(invPostalCode; Rec.InvPostalCode)
                {
                    Caption = 'InvPostalCode';
                }
                field(invReference; Rec.InvReference)
                {
                    Caption = 'InvReference';
                }
                field(invoiceAmount; Rec.InvoiceAmount)
                {
                    Caption = 'InvoiceAmount';
                }
                field(invoiceDate; Rec.InvoiceDate)
                {
                    Caption = 'InvoiceDate';
                }
                field(invoiceNumber; Rec.InvoiceNumber)
                {
                    Caption = 'InvoiceNumber';
                }
                field(lineAmountNet; Rec.LineAmountNet)
                {
                    Caption = 'LineAmountNet';
                }
                field(lineDescription; Rec.LineDescription)
                {
                    Caption = 'LineDescription';
                }
                field(lineIdentifier; Rec.LineIdentifier)
                {
                    Caption = 'LineIdentifier';
                }
                field(origin; Rec.ORIGIN)
                {
                    Caption = 'ORIGIN';
                }
                field(orderReference; Rec.OrderReference)
                {
                    Caption = 'OrderReference';
                }
                field(payingInBatchReference; Rec.PayingInBatchReference)
                {
                    Caption = 'PayingInBatchReference';
                }
                field(posted; Rec.Posted)
                {
                    Caption = 'Posted';
                }
                field(processedDate; Rec."Processed Date")
                {
                    Caption = 'Processed Date';
                }
                field(recAddressLine1; Rec.RecAddressLine1)
                {
                    Caption = 'RecAddressLine1';
                }
                field(recAddressLine2; Rec.RecAddressLine2)
                {
                    Caption = 'RecAddressLine2';
                }
                field(recAddressLine3; Rec.RecAddressLine3)
                {
                    Caption = 'RecAddressLine3';
                }
                field(recAddressLine4; Rec.RecAddressLine4)
                {
                    Caption = 'RecAddressLine4';
                }
                field(recCity; Rec.RecCity)
                {
                    Caption = 'RecCity';
                }
                field(recCustomerName; Rec.RecCustomerName)
                {
                    Caption = 'RecCustomerName';
                }
                field(recCustomerNumber; Rec.RecCustomerNumber)
                {
                    Caption = 'RecCustomerNumber';
                }
                field(recPostalCode; Rec.RecPostalCode)
                {
                    Caption = 'RecPostalCode';
                }
                field(recReference; Rec.RecReference)
                {
                    Caption = 'RecReference';
                }
                field(receiptAmount; Rec.ReceiptAmount)
                {
                    Caption = 'ReceiptAmount';
                }
                field(receiptDate; Rec.ReceiptDate)
                {
                    Caption = 'ReceiptDate';
                }
                field(receiptGlDate; Rec.ReceiptGlDate)
                {
                    Caption = 'ReceiptGlDate';
                }
                field(receiptMatchAmount; Rec.ReceiptMatchAmount)
                {
                    Caption = 'ReceiptMatchAmount';
                }
                field(receiptMethod; Rec.ReceiptMethod)
                {
                    Caption = 'ReceiptMethod';
                }
                field(receiptNumber; Rec.ReceiptNumber)
                {
                    Caption = 'ReceiptNumber';
                }
                field(refundAmount; Rec.RefundAmount)
                {
                    Caption = 'RefundAmount';
                }
                field(ruleDuration; Rec.RuleDuration)
                {
                    Caption = 'RuleDuration';
                }
                field(ruleStartDate; Rec.RuleStartDate)
                {
                    Caption = 'RuleStartDate';
                }
                field(sapRegisterNo; Rec."SAP Register No.")
                {
                    Caption = 'SAP Register No.';
                }
                field(salesPerson; Rec.SalesPerson)
                {
                    Caption = 'SalesPerson';
                }
                field(scheme; Rec.Scheme)
                {
                    Caption = 'Scheme';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(testmatch; Rec.TESTMATCH)
                {
                    Caption = 'TESTMATCH';
                }
                field(taxAmount; Rec.TaxAmount)
                {
                    Caption = 'TaxAmount';
                }
                field(taxCode; Rec.TaxCode)
                {
                    Caption = 'TaxCode';
                }
                field(testType; Rec.TestType)
                {
                    Caption = 'TestType';
                }
                field(financeArapId; Rec.FinanceArapId)
                {
                    Caption = 'FinanceArapID';
                }
                field(payee; Rec.Payee)
                {
                    Caption = 'Payee';
                }
                field(paymentAuthcode; Rec."Payment Authcode")
                {
                    Caption = 'Payment Authcode';
                }
                field(paymentProviderCode; Rec."Payment Provider")
                {
                    Caption = 'Payment Provider Code';
                }
                field(paymentResult; Rec."Payment Result")
                {
                    Caption = 'Payment Result';
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
                field(paymentDuplicate; Rec."Payment Duplicate")
                {
                    Caption = 'Payment Duplicate';
                }
            }
        }
    }

}

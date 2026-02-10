page 85005 "Processed CPMS Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CPMS Unsummarised Lines";
    Caption = 'Processed CPMS Entries';
    SourceTableView = where(Posted = filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(FinanceArapId; Rec.FinanceArapId)
                {
                    ApplicationArea = All;
                }
                field(Scheme; Rec.Scheme)
                {
                }
                field(Country; Rec.Country)
                {
                }
                field(Activity; Rec.Activity)
                {
                }
                field(InvoiceNumber; Rec.InvoiceNumber)
                {
                }
                field(InvoiceDate; Rec.InvoiceDate)
                {
                }
                field(RuleStartDate; Rec.RuleStartDate)
                {
                }
                field(RuleDuration; Rec.RuleDuration)
                {
                }
                field(TaxCode; Rec.TaxCode)
                {
                }
                field(TaxAmount; Rec.TaxAmount)
                {
                }
                field(InvoiceAmount; Rec.InvoiceAmount)
                {
                }
                field(LineIdentifier; Rec.LineIdentifier)
                {
                }
                field(LineDescription; Rec.LineDescription)
                {
                }
                field(LineAmountNet; Rec.LineAmountNet)
                {
                }
                field(ReceiptAmount; Rec.ReceiptAmount)
                {
                }
                field(ReceiptDate; Rec.ReceiptDate)
                {
                }
                field(ReceiptGlDate; Rec.ReceiptGlDate)
                {
                }
                field(ReceiptMethod; Rec.ReceiptMethod)
                {
                }
                field(ReceiptMatchAmount; Rec.ReceiptMatchAmount)
                {
                }
                field(CcReference; Rec.CcReference)
                {
                }
                field(RefundAmount; Rec.RefundAmount)
                {
                }
                field(InvCustomerNumber; Rec.InvCustomerNumber)
                {
                }
                field(InvCustomerName; Rec.InvCustomerName)
                {
                }
                field(InvAddressLine1; Rec.InvAddressLine1)
                {
                }
                field(InvAddressLine2; Rec.InvAddressLine2)
                {
                }
                field(InvAddressLine3; Rec.InvAddressLine3)
                {
                }
                field(InvAddressLine4; Rec.InvAddressLine4)
                {
                }
                field(InvCity; Rec.InvCity)
                {
                }
                field(InvPostalCode; Rec.InvPostalCode)
                {
                }
                field(InvReference; Rec.InvReference)
                {
                }
                field(RecCustomerNumber; Rec.RecCustomerNumber)
                {
                }
                field(RecCustomerName; Rec.RecCustomerName)
                {
                }
                field(RecAddressLine1; Rec.RecAddressLine1)
                {
                }
                field(RecAddressLine2; Rec.RecAddressLine2)
                {
                }
                field(RecAddressLine3; Rec.RecAddressLine3)
                {
                }
                field(RecAddressLine4; Rec.RecAddressLine4)
                {
                }
                field(RecCity; Rec.RecCity)
                {
                }
                field(RecPostalCode; Rec.RecPostalCode)
                {
                }
                field(SalesPerson; Rec.SalesPerson)
                {
                }
                field(OrderReference; Rec.OrderReference)
                {
                }
                field(PayingInBatchReference; Rec.PayingInBatchReference)
                {
                }
                field(FileDate; Rec.FileDate)
                {
                }
                field(TESTMATCH; Rec.TESTMATCH)
                {
                }
                field(INVOICE; Rec.INVOICE)
                {
                }
                field(ORIGIN; Rec.ORIGIN)
                {
                }
                field(TestType; Rec.TestType)
                {
                }
                field("Debit Acc No."; Rec."Debit Acc No.")
                {
                    ToolTip = 'Specifies the value of the Debit Acc No. field.', Comment = '%';
                }
                field("Credit Acc No."; Rec."Credit Acc No.")
                {
                    ToolTip = 'Specifies the value of the Credit Acc No. field.', Comment = '%';
                }
                // field("Journal Entry No."; Rec."Journal Entry No.")
                // {
                //     ToolTip = 'Specifies the value of the Journal Entry No. field.', Comment = '%';
                // }
                field("SAP Register No."; Rec."SAP Register No.")
                {
                    ToolTip = 'Specifies the value of the SAP Register No. field.', Comment = '%';
                }
                field("Processed Date"; Rec."Processed Date")
                {
                    ToolTip = 'Specifies the value of the Processed Date Time field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {
        }
    }

    actions
    {
    }
}
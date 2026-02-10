page 85004 "Processed TTS Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TTS Unsummarised Lines";
    Caption = 'Processed TTS Entries';
    SourceTableView = where(Posted = filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(FinanceSapId; Rec.FinanceSapId)
                {
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
                field(InvoicePostingDate; Rec.InvoicePostingDate)
                {
                }
                field(CustomerNumber; Rec.CustomerNumber)
                {
                }
                field(PaymentReference; Rec.PaymentReference)
                {
                }
                field(LineId; Rec.LineId)
                {
                }
                field(Product; Rec.Product)
                {
                }
                field(TestReference; Rec.TestReference)
                {
                }
                field(TestCostWithoutVat; Rec.TestCostWithoutVat)
                {
                }
                field(OabTransferValueGross; Rec.OabTransferValueGross)
                {
                }
                field(TestDate; Rec.TestDate)
                {
                }
                field(SalesPerson; Rec.SalesPerson)
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
                field(LongText; Rec.LongText)
                {
                }
                field(FileDate; Rec.FileDate)
                {
                }
                field(INVOICE; Rec.INVOICE)
                {
                }
                field(REFGOODS; Rec.REFGOODS)
                {
                }
                field(file_duplicate; Rec.file_duplicate)
                {
                }
                field(test_duplicate; Rec.test_duplicate)
                {
                }
                field(REFUNDOAB; Rec.REFUNDOAB)
                {
                }
                field(REVTESTM; Rec.REVTESTM)
                {
                }
                field(TESTMATCH; Rec.TESTMATCH)
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
                    ToolTip = 'Specifies the value of the Processed Date field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {
        }
    }

    // actions
    // {
    //     area(Navigation)
    //     {
    //         action(DeleteALL)
    //         {
    //             trigger OnAction()
    //             var
    //                 UNsi: Record "TTS Unsummarised Lines";
    //             begin
    //                 UNsi.DeleteAll(true);
    //             end;
    //         }
    //     }
    // }
}
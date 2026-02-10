page 85026 "LOB-CPMS Error Log"
{
    ApplicationArea = All;
    Caption = 'LOB-CPMS Error Log';
    PageType = List;
    SourceTable = TTS_SAP;
    SourceTableView = where("Matching Status" = filter(error));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = '';

                field(Activity; Rec.Activity)
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(CustomerNumber; Rec.CustomerNumber)
                {
                    ToolTip = 'Specifies the value of the CustomerNumber field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(FileDate; Rec.FileDate)
                {
                    ToolTip = 'Specifies the value of the FileDate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(FinanceSapId; Rec.FinanceSapId)
                {
                    ToolTip = 'Specifies the value of the FinanceSapId field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(INVOICE; Rec.INVOICE)
                {
                    ToolTip = 'Specifies the value of the INVOICE field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvAddressLine1; Rec.InvAddressLine1)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine1 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvAddressLine2; Rec.InvAddressLine2)
                {
                    ToolTip = 'Specifies the value of the InvAdddressLine2 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvAddressLine3; Rec.InvAddressLine3)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine3 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvAddressLine4; Rec.InvAddressLine4)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine4 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvCity; Rec.InvCity)
                {
                    ToolTip = 'Specifies the value of the InvCity field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvCustomerName; Rec.InvCustomerName)
                {
                    ToolTip = 'Specifies the value of the InvCustomerName field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvPostalCode; Rec.InvPostalCode)
                {
                    ToolTip = 'Specifies the value of the InvPostalCode field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvoiceDate; Rec.InvoiceDate)
                {
                    ToolTip = 'Specifies the value of the InvoiceDate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvoiceNumber; Rec.InvoiceNumber)
                {
                    ToolTip = 'Specifies the value of the INVOICE field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvoicePostingDate; Rec.InvoicePostingDate)
                {
                    ToolTip = 'Specifies the value of the InvoicePostingDate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Line Amount Net"; Rec."Line Amount Net")
                {
                    ToolTip = 'Specifies the value of the Line Amount Net field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Line Description"; Rec."Line Description")
                {
                    ToolTip = 'Specifies the value of the Line Description field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(LineId; Rec.LineId)
                {
                    ToolTip = 'Specifies the value of the LineId field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(LongText; Rec.LongText)
                {
                    ToolTip = 'Specifies the value of the LongText field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(OabTransferValueGross; Rec.OabTransferValueGross)
                {
                    ToolTip = 'Specifies the value of the OabTransferValueGross field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Order Reference"; Rec."Order Reference")
                {
                    ToolTip = 'Specifies the value of the Order Reference field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Paying in Batch Ref"; Rec."Paying in Batch Ref")
                {
                    ToolTip = 'Specifies the value of the Paying in Batch Ref field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(PaymentReference; Rec.PaymentReference)
                {
                    ToolTip = 'Specifies the value of the PaymentReference field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(Product; Rec.Product)
                {
                    ToolTip = 'Specifies the value of the Product field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(REFGOODS; Rec.REFGOODS)
                {
                    ToolTip = 'Specifies the value of the REFGOODS field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(REFUNDOAB; Rec.REFUNDOAB)
                {
                    ToolTip = 'Specifies the value of the REFUNDOAB field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(REVTESTM; Rec.REVTESTM)
                {
                    ToolTip = 'Specifies the value of the REVTESTM field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(SalesPerson; Rec.SalesPerson)
                {
                    ToolTip = 'Specifies the value of the SalesPerson field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(TESTMATCH; Rec.TESTMATCH)
                {
                    ToolTip = 'Specifies the value of the TESTMATCH field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Tax Amount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Tax Code"; Rec."Tax Code")
                {
                    ToolTip = 'Specifies the value of the Tax Code field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Test Location"; Rec."Test Location")
                {
                    ToolTip = 'Specifies the value of the Test Location field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(TestCostWithoutVat; Rec.TestCostWithoutVat)
                {
                    ToolTip = 'Specifies the value of the TestCostWithoutVat field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(TestDate; Rec.TestDate)
                {
                    ToolTip = 'Specifies the value of the TestDate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(TestReference; Rec.TestReference)
                {
                    ToolTip = 'Specifies the value of the TestReference field.', Comment = '%';
                    StyleExpr = StyleExp;
                }

                field(file_duplicate; Rec.file_duplicate)
                {
                    ToolTip = 'Specifies the value of the file_duplicate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(test_duplicate; Rec.test_duplicate)
                {
                    ToolTip = 'Specifies the value of the test_duplicate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching ID"; Rec."Matching ID")
                {
                    ToolTip = 'Specifies the value of the Matching ID field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching Status"; Rec."Matching Status")
                {
                    ToolTip = 'Specifies the value of the Matching Status field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Match Type"; Rec."Match Type")
                {
                    ToolTip = 'Specifies the value of the Match Type field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Match Details"; Rec."Match Details")
                {
                    ToolTip = 'Specifies the value of the Match Details field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matched By"; Rec."Matched By")
                {
                    ToolTip = 'Specifies the value of the Matched By field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
            }
            part(CPMS; "CPMS with LOB Matching")
            {
                Caption = 'CPMS';
                ApplicationArea = All;
                SubPageView = where("LOB Matching Status" = filter(Error));
                SubPageLink = "LOB Matching ID" = field("Matching ID");
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        Clear(StyleExp);
        case true of
            Rec."Matching Status" = Rec."Matching Status"::Matched:
                StyleExp := 'Favorable';
            Rec."Matching Status" = rec."Matching Status"::Error:
                StyleExp := 'UnFavorable';
        end;
    end;

    var
        StyleExp: text;
}

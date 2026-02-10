page 85032 "CPMS LOB Matching Lookup"
{
    ApplicationArea = All;
    Caption = 'CPMS Matching';
    PageType = List;
    SourceTable = TTS_ARAP;
    SourceTableView = sorting("LOB Matching Status", "LOB Processed Date Time") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = AllowEdit;
                field(Scheme; Rec.Scheme)
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(Activity; Rec.Activity)
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = '%';
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
                field(ReceiptNumber; Rec.ReceiptNumber)
                {
                    ToolTip = 'Specifies the value of the ReceiptNumber field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(ReceiptMethod; Rec.ReceiptMethod)
                {
                    ToolTip = 'Specifies the value of the ReceiptMethod field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(ReceiptDate; Rec.ReceiptDate)
                {
                    ToolTip = 'Specifies the value of the ReceiptDate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(ReceiptAmount; Rec.ReceiptAmount)
                {
                    ToolTip = 'Specifies the value of the ReceiptAmount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RefundAmount; Rec.RefundAmount)
                {
                    ToolTip = 'Specifies the value of the RefundAmount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching ID"; Rec."LOB Matching ID")
                {
                    ToolTip = 'Specifies the value of the Matching ID field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching Date Time"; Rec."LOB Processed Date Time")
                {
                    ToolTip = 'Specifies the value of the Matching Date Time field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching Status"; Rec."LOB Matching Status")
                {
                    ToolTip = 'Specifies the value of the Matching Status field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("LOB Match Details"; Rec."LOB Match Details")
                {
                    ToolTip = 'Specifies the value of the LOB Match Details field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("LOB Matched By"; Rec."LOB Matched By")
                {
                    ToolTip = 'Specifies the value of the LOB Matched By field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("LOB Match Type"; Rec."LOB Match Type")
                {
                    ToolTip = 'Specifies the value of the EOD Match Type field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(CcReference; Rec.CcReference)
                {
                    ToolTip = 'Specifies the value of the CcReference field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(TestType; Rec.TestType)
                {
                    ToolTip = 'Specifies the value of the TestType field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(TaxCode; Rec.TaxCode)
                {
                    ToolTip = 'Specifies the value of the TaxCode field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(TaxAmount; Rec.TaxAmount)
                {
                    ToolTip = 'Specifies the value of the TaxAmount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(TESTMATCH; Rec.TESTMATCH)
                {
                    ToolTip = 'Specifies the value of the TESTMATCH field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RuleStartDate; Rec.RuleStartDate)
                {
                    ToolTip = 'Specifies the value of the RuleStartDate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RuleDuration; Rec.RuleDuration)
                {
                    ToolTip = 'Specifies the value of the RuleDuration field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(ReceiptMatchAmount; Rec.ReceiptMatchAmount)
                {
                    ToolTip = 'Specifies the value of the ReceiptMatchAmount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(ReceiptGlDate; Rec.ReceiptGlDate)
                {
                    ToolTip = 'Specifies the value of the ReceiptGlDate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RecReference; Rec.RecReference)
                {
                    ToolTip = 'Specifies the value of the RecReference field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RecPostalCode; Rec.RecPostalCode)
                {
                    ToolTip = 'Specifies the value of the RecPostalCode field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RecCustomerNumber; Rec.RecCustomerNumber)
                {
                    ToolTip = 'Specifies the value of the RecCustomerNumber field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RecCustomerName; Rec.RecCustomerName)
                {
                    ToolTip = 'Specifies the value of the RecCustomerName field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RecCity; Rec.RecCity)
                {
                    ToolTip = 'Specifies the value of the RecCity field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RecAddressLine4; Rec.RecAddressLine4)
                {
                    ToolTip = 'Specifies the value of the RecAddressLine4 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RecAddressLine3; Rec.RecAddressLine3)
                {
                    ToolTip = 'Specifies the value of the RecAddressLine3 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RecAddressLine2; Rec.RecAddressLine2)
                {
                    ToolTip = 'Specifies the value of the RecAddressLine2 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(RecAddressLine1; Rec.RecAddressLine1)
                {
                    ToolTip = 'Specifies the value of the RecAddressLine1 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Payment Result"; Rec."Payment Result")
                {
                    ToolTip = 'Specifies the value of the Payment Result field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Payment Provider"; Rec."Payment Provider")
                {
                    ToolTip = 'Specifies the value of the Payment Provider field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Payment Authcode"; Rec."Payment Authcode")
                {
                    ToolTip = 'Specifies the value of the Payment Authcode field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(PayingInBatchReference; Rec.PayingInBatchReference)
                {
                    ToolTip = 'Specifies the value of the PayingInBatchReference field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(OrderReference; Rec.OrderReference)
                {
                    ToolTip = 'Specifies the value of the OrderReference field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(ORIGIN; Rec.ORIGIN)
                {
                    ToolTip = 'Specifies the value of the ORIGIN field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(LineIdentifier; Rec.LineIdentifier)
                {
                    ToolTip = 'Specifies the value of the LineIdentifier field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(LineDescription; Rec.LineDescription)
                {
                    ToolTip = 'Specifies the value of the LineDescription field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(LineAmountNet; Rec.LineAmountNet)
                {
                    ToolTip = 'Specifies the value of the LineAmountNet field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvoiceAmount; Rec.InvoiceAmount)
                {
                    ToolTip = 'Specifies the value of the InvoiceAmount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvReference; Rec.InvReference)
                {
                    ToolTip = 'Specifies the value of the InvReference field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvPostalCode; Rec.InvPostalCode)
                {
                    ToolTip = 'Specifies the value of the InvPostalCode field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvCustomerNumber; Rec.InvCustomerNumber)
                {
                    ToolTip = 'Specifies the value of the InvCustomerNumber field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvCustomerName; Rec.InvCustomerName)
                {
                    ToolTip = 'Specifies the value of the InvCustomerName field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvCity; Rec.InvCity)
                {
                    ToolTip = 'Specifies the value of the InvCity field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvAddressLine4; Rec.InvAddressLine4)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine4 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvAddressLine3; Rec.InvAddressLine3)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine3 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvAddressLine2; Rec.InvAddressLine2)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine2 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvAddressLine1; Rec.InvAddressLine1)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine1 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(INVOICE; Rec.INVOICE)
                {
                    ToolTip = 'Specifies the value of the INVOICE field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(FinanceArapId; Rec.FinanceArapId)
                {
                    ToolTip = 'Specifies the value of the FinanceArapID field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(FileDate; Rec.FileDate)
                {
                    ToolTip = 'Specifies the value of the FileDate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Linked LOB")
            {
                Image = Links;
                trigger OnAction()
                var
                    TTS: Record TTS_SAP;
                begin
                    if Rec."LOB Matching Status" IN [Rec."LOB Matching Status"::Matched, Rec."LOB Matching Status"::Error] then begin
                        TTS.Reset();
                        TTS.SetRange("Matching ID", Rec."LOB Matching ID");
                        TTS.SetRange("Matching Status", Rec."LOB Matching Status");
                        Page.RunModal(page::"LOB Matching", TTS);
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        IntegrationSetup: Record "Integration Setup";
    begin
        if UserSetup.Get(UserId) then
            AllowEdit := UserSetup."Integration Admin";

        ExcludeAct := CommonFunctions.ExcludeActivity(gscheme, Excludetype::"LOB-CPMS");
        if ExcludeAct <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetFilter(Activity, ExcludeAct);
            Rec.FilterGroup(0);
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if not AllowEdit then
            Error('You do have permission to insert the record.')
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if not AllowEdit then
            Error('You do not have the permission to delete the record.');
    end;

    trigger OnAfterGetRecord()
    begin
        Clear(StyleExp);
        case true of
            Rec."LOB Matching Status" = Rec."LOB Matching Status"::Matched:
                StyleExp := 'Favorable';
            Rec."LOB Matching Status" = rec."LOB Matching Status"::Error:
                StyleExp := 'UnFavorable';
        end;
    end;

    procedure ToggleLOBMatchedFilter(SetFilterOn: Boolean)
    begin
        if SetFilterOn then begin
            rec.SetRange("LOB Matching Status");
            Rec.SetRange("LOB Matching Status", Rec."LOB Matching Status"::Unmatched)
        end else
            Rec.SetRange("LOB Matching Status");
        CurrPage.Update();
    end;

    procedure ShowErroredRecord()
    begin
        rec.SetRange("LOB Matching Status");
        Rec.SetRange("LOB Matching Status", Rec."LOB Matching Status"::Error);
        CurrPage.Update();
    end;

    procedure ShowMatchedRecord()
    begin
        rec.SetRange("LOB Matching Status");
        Rec.SetRange("LOB Matching Status", Rec."LOB Matching Status"::Matched);
        CurrPage.Update();
    end;

    procedure GetSelectedRecords(var SelectedCPMSLOB: Record TTS_ARAP temporary)
    var
        CPMSLOB: Record TTS_ARAP;
    begin
        CurrPage.SetSelectionFilter(CPMSLOB);
        if CPMSLOB.FindSet() then
            repeat
                SelectedCPMSLOB := CPMSLOB;
                SelectedCPMSLOB.Insert();
            until CPMSLOB.Next() = 0;
    end;

    procedure SetSchemeFilter(Scheme: Code[20])
    begin
        gscheme := Scheme;
        Rec.FilterGroup(2);
        Rec.SetRange(Scheme, Scheme);
        Rec.FilterGroup(0);
        CurrPage.Update();
    end;




    var
        StyleExp: Text;
        Excludetype: Option LOB,"LOB-CPMS","CPMS-EOD";
        CommonFunctions: Codeunit "Common Functions";

        ExcludeAct, gscheme : Text;
        AllowEdit: Boolean;
}

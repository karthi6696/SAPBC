page 85001 "CPMS Staging"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = TTS_ARAP;
    Caption = 'CPMS Staging';
    SourceTableView = where(Posted = filter(false));
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Editable = AllowEdit;
                field(Select; Rec.Select)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Select field.', Comment = '%';
                }
                field(Scheme; Rec.Scheme)
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                    StyleExpr = StyleExp;
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field.';
                    StyleExpr = StyleExp;
                }
                field(Activity; Rec.Activity)//sc 2
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    StyleExpr = StyleExp;
                }
                field("Source Activity-Origin"; Rec."Source Activity-Origin")
                {
                    ToolTip = 'Specifies the value of the Source Activity (Origin) field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(InvoiceNumber; Rec.InvoiceNumber)
                {
                    ToolTip = 'Specifies the value of the InvoiceNumber field.';
                    StyleExpr = StyleExp;
                }
                field(InvoiceDate; Rec.InvoiceDate)
                {
                    ToolTip = 'Specifies the value of the InvoiceDate field.';
                    StyleExpr = StyleExp;
                }
                field(RuleStartDate; Rec.RuleStartDate)
                {
                    ToolTip = 'Specifies the value of the RuleStartDate field.';
                    StyleExpr = StyleExp;
                }
                field(RuleDuration; Rec.RuleDuration)
                {
                    ToolTip = 'Specifies the value of the RuleDuration field.';
                    StyleExpr = StyleExp;
                }
                field(TaxCode; Rec.TaxCode)
                {
                    ToolTip = 'Specifies the value of the TaxCode field.';
                    StyleExpr = StyleExp;
                }
                field(TaxAmount; Rec.TaxAmount)
                {
                    ToolTip = 'Specifies the value of the TaxAmount field.';
                    StyleExpr = StyleExp;
                }
                field(InvoiceAmount; Rec.InvoiceAmount)
                {
                    ToolTip = 'Specifies the value of the InvoiceAmount field.';
                    StyleExpr = StyleExp;
                }
                field(LineIdentifier; Rec.LineIdentifier)
                {
                    ToolTip = 'Specifies the value of the LineIdentifier field.';
                    StyleExpr = StyleExp;
                }
                field(LineDescription; Rec.LineDescription)
                {
                    ToolTip = 'Specifies the value of the LineDescription field.';
                    StyleExpr = StyleExp;
                }
                field(LineAmountNet; Rec.LineAmountNet)
                {
                    ToolTip = 'Specifies the value of the LineAmountNet field.';
                    StyleExpr = StyleExp;
                }
                field(ReceiptAmount; Rec.ReceiptAmount)
                {
                    ToolTip = 'Specifies the value of the ReceiptAmount field.';
                    StyleExpr = StyleExp;
                }
                field(ReceiptDate; Rec.ReceiptDate)
                {
                    ToolTip = 'Specifies the value of the ReceiptDate field.';
                    StyleExpr = StyleExp;
                }
                field(ReceiptGlDate; Rec.ReceiptGlDate)
                {
                    ToolTip = 'Specifies the value of the ReceiptGlDate field.';
                    StyleExpr = StyleExp;
                }
                field(ReceiptMethod; Rec.ReceiptMethod)
                {
                    ToolTip = 'Specifies the value of the ReceiptMethod field.';
                    StyleExpr = StyleExp;
                }
                field(ReceiptMatchAmount; Rec.ReceiptMatchAmount)
                {
                    ToolTip = 'Specifies the value of the ReceiptMatchAmount field.';
                    StyleExpr = StyleExp;
                }
                field(CcReference; Rec.CcReference)
                {
                    ToolTip = 'Specifies the value of the CcReference field.';
                    StyleExpr = StyleExp;
                }
                field(RefundAmount; Rec.RefundAmount)
                {
                    ToolTip = 'Specifies the value of the RefundAmount field.';
                    StyleExpr = StyleExp;
                }
                field(InvCustomerNumber; Rec.InvCustomerNumber)
                {
                    ToolTip = 'Specifies the value of the InvCustomerNumber field.';
                    StyleExpr = StyleExp;
                }
                field(InvCustomerName; Rec.InvCustomerName)
                {
                    ToolTip = 'Specifies the value of the InvCustomerName field.';
                    StyleExpr = StyleExp;
                }
                field(InvAddressLine1; Rec.InvAddressLine1)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine1 field.';
                    StyleExpr = StyleExp;
                }
                field(InvAddressLine2; Rec.InvAddressLine2)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine2 field.';
                    StyleExpr = StyleExp;
                }
                field(InvAddressLine3; Rec.InvAddressLine3)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine3 field.';
                    StyleExpr = StyleExp;
                }
                field(InvAddressLine4; Rec.InvAddressLine4)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine4 field.';
                    StyleExpr = StyleExp;
                }
                field(InvCity; Rec.InvCity)
                {
                    ToolTip = 'Specifies the value of the InvCity field.';
                    StyleExpr = StyleExp;
                }
                field(InvPostalCode; Rec.InvPostalCode)
                {
                    ToolTip = 'Specifies the value of the InvPostalCode field.';
                    StyleExpr = StyleExp;
                }
                field(InvReference; Rec.InvReference)
                {
                    ToolTip = 'Specifies the value of the InvReference field.';
                    StyleExpr = StyleExp;
                }
                field(RecCustomerNumber; Rec.RecCustomerNumber)
                {
                    ToolTip = 'Specifies the value of the RecCustomerNumber field.';
                    StyleExpr = StyleExp;
                }
                field(RecCustomerName; Rec.RecCustomerName)
                {
                    ToolTip = 'Specifies the value of the RecCustomerName field.';
                    StyleExpr = StyleExp;
                }
                field(RecAddressLine1; Rec.RecAddressLine1)
                {
                    ToolTip = 'Specifies the value of the RecAddressLine1 field.';
                    StyleExpr = StyleExp;
                }
                field(RecAddressLine2; Rec.RecAddressLine2)
                {
                    ToolTip = 'Specifies the value of the RecAddressLine2 field.';
                    StyleExpr = StyleExp;
                }
                field(RecAddressLine3; Rec.RecAddressLine3)
                {
                    ToolTip = 'Specifies the value of the RecAddressLine3 field.';
                }
                field(RecAddressLine4; Rec.RecAddressLine4)
                {
                    ToolTip = 'Specifies the value of the RecAddressLine4 field.';
                    StyleExpr = StyleExp;
                }
                field(RecCity; Rec.RecCity)
                {
                    ToolTip = 'Specifies the value of the RecCity field.';
                    StyleExpr = StyleExp;
                }
                field(RecPostalCode; Rec.RecPostalCode)
                {
                    ToolTip = 'Specifies the value of the RecPostalCode field.';
                    StyleExpr = StyleExp;
                }
                field(RecReference; Rec.RecReference)
                {
                    ToolTip = 'Specifies the value of the RecReference field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(ReceiptNumber; Rec.ReceiptNumber)
                {
                    ToolTip = 'Specifies the value of the ReceiptNumber field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(SalesPerson; Rec.SalesPerson)
                {
                    ToolTip = 'Specifies the value of the SalesPerson field.';
                    StyleExpr = StyleExp;
                }
                field(OrderReference; Rec.OrderReference)
                {
                    ToolTip = 'Specifies the value of the OrderReference field.';
                    StyleExpr = StyleExp;
                }
                field(PayingInBatchReference; Rec.PayingInBatchReference)
                {
                    ToolTip = 'Specifies the value of the PayingInBatchReference field.';
                    StyleExpr = StyleExp;
                }
                field(FileDate; Rec.FileDate)
                {
                    ToolTip = 'Specifies the value of the FileDate field.';
                    StyleExpr = StyleExp;
                }
                field(TESTMATCH; Rec.TESTMATCH)
                {
                    ToolTip = 'Specifies the value of the TESTMATCH field.';
                    StyleExpr = StyleExp;
                }
                field(INVOICE; Rec.INVOICE)
                {
                    ToolTip = 'Specifies the value of the INVOICE field.';
                    StyleExpr = StyleExp;
                }
                field(ORIGIN; Rec.ORIGIN)
                {
                    ToolTip = 'Specifies the value of the ORIGIN field.';
                    StyleExpr = StyleExp;
                }
                field(TestType; Rec.TestType)
                {
                    ToolTip = 'Specifies the value of the TestType field.';
                    StyleExpr = StyleExp;
                }
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Payment Duplicate"; Rec."Payment Duplicate")
                {
                    ToolTip = 'Specifies the value of the Payment Duplicate field.', Comment = '%';
                }
                field("Payment Authcode"; Rec."Payment Authcode")
                {
                    ToolTip = 'Specifies the value of the Payment Authcode field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Payment Provider"; Rec."Payment Provider")
                {
                    ToolTip = 'Specifies the value of the Payment Provider field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Payment Result"; Rec."Payment Result")
                {
                    ToolTip = 'Specifies the value of the Payment Result field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Imported Date Time"; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the Imported Date Time field.';
                    StyleExpr = StyleExp;
                    Caption = 'Imported At';

                }
                field("Synapse Error"; Rec."Synapse Error")
                {
                    ToolTip = 'Specifies the value of the Synapse Error field.', Comment = '%';
                }
                field("Synapse Error Description"; Rec."Synapse Error Description")
                {
                    ToolTip = 'Specifies the value of the Synapse Error Description field.', Comment = '%';
                }
                field("Source Identifier"; Rec."Source Identifier")
                {
                    ToolTip = 'Specifies the value of the Source Identifier field.', Comment = '%';
                }
                field("SAP Register No."; Rec."SAP Register No.")
                {
                    ToolTip = 'Specifies the value of the SAP Register No. field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {
            part(IntegrationErrors; "Integration_Errors")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Record Type" = filter(CPMS),
                              "Record Entry No." = field("Entry No.");
                Caption = 'Errors';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                Scope = Repeater;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';

                trigger OnAction()
                var
                    Navigate: Page "DVSA Navigate";
                    TableSource: Text;
                begin
                    TableSource := 'TTS SAP';
                    Navigate.SetDVSASource(TableSource, rec.ReceiptNumber);
                    Navigate.SetDoc(DT2Date(Rec.SystemCreatedAt), Rec.ReceiptNumber);
                    Navigate.Run();
                end;
            }
            action("CPMS Export")
            {
                Caption = 'CPMS Transaction Listing';
                Image = ExportElectronicDocument;
                ApplicationArea = All;
                ToolTip = 'Executes the CPMS Transaction Listing action.';
                Visible = true;

                trigger OnAction()
                var
                    CPMSStagingExport: codeunit "CPMS Staging Export";
                begin
                    CPMSStagingExport.CreateCPMSCSVFile();
                end;
            }
            Action("Export CPMS Data")
            {
                ApplicationArea = All;
                Image = ExportToExcel;
                RunObject = Report "CPMS Data";
            }
            action(Process_Record)
            {
                ApplicationArea = All;
                Caption = 'Process Filtered Records';
                Image = Process;
                ToolTip = 'Executes the Process Record action.';

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    NoPermission: Label 'You do not have permission to process TTS SAP records';
                    CommonFunctions: Codeunit "Common Functions";
                begin
                    if not UserSetup.get(UserId) then
                        Error(NoPermission);
                    if UserSetup."Integration Admin" = false then
                        Error(NoPermission);
                    CommonFunctions.ProcessCPMSFilteredRecords(Rec);
                end;
            }
            action(Process_All)
            {
                ApplicationArea = All;
                Caption = 'Process All';
                Visible = false;
                Image = Process;
                ToolTip = 'Executes the Process All action.';

                trigger OnAction()
                var
                    CPMSSAPSummary: Codeunit "Export SAP Summary";
                    UserSetup: Record "User Setup";
                    NoPermission: Label 'You do not have permission to process TTS SAP records';
                begin
                    if not UserSetup.get(UserId) then
                        Error(NoPermission);
                    if UserSetup."Integration Admin" = false then
                        Error(NoPermission);
                    if Confirm('Do you want to process all the records?') then begin
                        Clear(CPMSSAPSummary);
                        CPMSSAPSummary.CreateCPMSSummary(Enum::"Summary Export Type"::All, '');
                    end;
                end;
            }
            action("Validate Selected Records")
            {
                ApplicationArea = All;
                Caption = 'Validate Selected Records';
                Image = Process;
                ToolTip = 'Executes the Validate Records action.';
                trigger OnAction()
                var
                    CommonFunc: Codeunit "Common Functions";
                    CpmsRec: Record TTS_ARAP;
                    Progress: Dialog;
                    Counter: Integer;
                    ProgressMsg: Label 'Validating......#1######################\';
                begin
                    Clear(Counter);
                    Progress.Open(ProgressMsg);
                    CurrPage.SetSelectionFilter(CpmsRec);
                    if CpmsRec.FindSet(false) then
                        repeat
                            Counter += 1;
                            Progress.Update(1, Counter);// Update the field in the dialog.
                            CommonFunc.ErrorCheckRecord(CpmsRec);
                        until CpmsRec.Next() = 0;
                    Progress.Close();
                end;
            }
            action("Validate All Records")
            {
                ApplicationArea = All;
                Caption = 'Validate All';
                Image = Process;
                ToolTip = 'Executes the Validate Records action.';
                trigger OnAction()
                var
                    CommonFunc: Codeunit "Common Functions";
                    CpmsRec: Record TTS_ARAP;
                    Progress: Dialog;
                    Counter: Integer;
                    ProgressMsg: Label 'Validating......#1######################\';
                begin
                    Clear(Counter);
                    Progress.Open(ProgressMsg);
                    CpmsRec.CopyFilters(Rec);
                    CpmsRec.SetRange(Posted, false);
                    if CpmsRec.FindSet(false) then
                        repeat
                            Counter += 1;
                            Progress.Update(1, Counter);// Update the field in the dialog.
                            CommonFunc.ErrorCheckRecord(CpmsRec);
                        until CpmsRec.Next() = 0;
                    Progress.Close();
                end;
            }
            action(Undo)
            {
                ApplicationArea = All;
                Caption = 'Undo All Posted Records';
                Visible = false;
                Image = Process;
                ToolTip = 'Executes the Undo All Posted Records action.';
                trigger OnAction()
                var
                    CPMS: Record TTS_ARAP;
                    ParentMatchField: Text;
                begin
                    CPMS.SetRange(Posted, true);
                    if CPMS.FindSet(true) then begin
                        CPMS.ModifyAll("SAP Register No.", 0);
                        CPMS.ModifyAll("Credit Acc No.", '');
                        CPMS.ModifyAll("Debit Acc No.", '');
                        CPMS.ModifyAll(Posted, false);
                    end;
                end;
            }
        }
        area(Promoted)
        {
            group("SAP Journal")
            {
                actionref(Process_Record_Promoted; Process_Record)
                {

                }
                actionref(Process_All_Promoted; Process_All)
                {

                }
            }
        }
    }


    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then
            AllowEdit := UserSetup."Integration Admin";

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if not AllowEdit then
            Error('You do have permission to insert the record.');
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if not AllowEdit then
            Error('You do not have the permission to delete the record.');
    end;

    trigger OnAfterGetRecord()
    begin
        Clear(StyleExp);

        Rec.CalcFields("Error Exists");
        if Rec."Error Exists" then
            StyleExp := 'Unfavorable'
        else
            if (Rec."Payment Duplicate" = 'Pay Ref Dup') then
                StyleExp := 'Strongaccent';

    end;



    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // var
    //     TTS_ARAP: Record TTS_ARAP;
    // begin
    //     TTS_ARAP.Reset();
    //     if TTS_ARAP.FindLast() then
    //         Rec."Entry No." := TTS_ARAP."Entry No." + 1
    //     else
    //         Rec."Entry No." := 1;
    // end;

    var
        AllowEdit: Boolean;
        StyleExp: Text;


}
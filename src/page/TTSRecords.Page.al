page 85035 "TTS Records"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = TTS_SAP;

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
                field(Activity; Rec.Activity)
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
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
                field(InvoicePostingDate; Rec.InvoicePostingDate)
                {
                    ToolTip = 'Specifies the value of the InvoicePostingDate field.';
                    StyleExpr = StyleExp;
                }
                field(CustomerNumber; Rec.CustomerNumber)
                {
                    ToolTip = 'Specifies the value of the CustomerNumber field.';
                    StyleExpr = StyleExp;
                }
                field(PaymentReference; Rec.PaymentReference)
                {
                    ToolTip = 'Specifies the value of the PaymentReference field.';
                    StyleExpr = StyleExp;
                }
                field(LineId; Rec.LineId)
                {
                    ToolTip = 'Specifies the value of the LineId field.';
                    StyleExpr = StyleExp;
                }
                field(Product; Rec.Product)
                {
                    ToolTip = 'Specifies the value of the Product field.';
                    StyleExpr = StyleExp;
                }
                field(TestReference; Rec.TestReference)
                {
                    ToolTip = 'Specifies the value of the TestReference field.';
                    StyleExpr = StyleExp;
                }
                field(TestCostWithoutVat; Rec.TestCostWithoutVat)
                {
                    ToolTip = 'Specifies the value of the TestCostWithoutVat field.';
                    StyleExpr = StyleExp;
                }
                field(OabTransferValueGross; Rec.OabTransferValueGross)
                {
                    ToolTip = 'Specifies the value of the OabTransferValueGross field.';
                    StyleExpr = StyleExp;
                }
                field(TestDate; Rec.TestDate)
                {
                    ToolTip = 'Specifies the value of the TestDate field.';
                    StyleExpr = StyleExp;
                }
                field(SalesPerson; Rec.SalesPerson)
                {
                    ToolTip = 'Specifies the value of the SalesPerson field.';
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
                    ToolTip = 'Specifies the value of the InvAdddressLine2 field.';
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
                field(LongText; Rec.LongText)
                {
                    ToolTip = 'Specifies the value of the LongText field.';
                    StyleExpr = StyleExp;
                }
                field(FileDate; Rec.FileDate)
                {
                    ToolTip = 'Specifies the value of the FileDate field.';
                    StyleExpr = StyleExp;
                }
                field(INVOICE; Rec.INVOICE)
                {
                    ToolTip = 'Specifies the value of the INVOICE field.';
                    StyleExpr = StyleExp;
                }
                field(REFGOODS; Rec.REFGOODS)
                {
                    ToolTip = 'Specifies the value of the REFGOODS field.';
                    StyleExpr = StyleExp;
                }
                field(file_duplicate; Rec.file_duplicate)
                {
                    ToolTip = 'Specifies the value of the file_duplicate field.';
                    StyleExpr = StyleExp;

                }
                field(test_duplicate; Rec.test_duplicate)
                {
                    ToolTip = 'Specifies the value of the test_duplicate field.';
                    StyleExpr = StyleExp;

                }
                field(REFUNDOAB; Rec.REFUNDOAB)
                {
                    ToolTip = 'Specifies the value of the REFUNDOAB field.';
                    StyleExpr = StyleExp;

                }
                field(REVTESTM; Rec.REVTESTM)
                {
                    ToolTip = 'Specifies the value of the REVTESTM field.';
                    StyleExpr = StyleExp;

                }
                field(TESTMATCH; Rec.TESTMATCH)
                {
                    ToolTip = 'Specifies the value of the TESTMATCH field.';
                    StyleExpr = StyleExp;
                }
                field("Match Type"; Rec."Match Type")
                {
                    ToolTip = 'Specifies the value of the Match Type field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Matched By"; Rec."Matched By")
                {
                    ToolTip = 'Specifies the value of the Matched By field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Matching ID"; Rec."Matching ID")
                {
                    ToolTip = 'Specifies the value of the Matching ID field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Match Details"; Rec."Match Details")
                {
                    ToolTip = 'Specifies the value of the Match Details field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Matching Status"; Rec."Matching Status")
                {
                    ToolTip = 'Specifies the value of the Matching Status field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Matching Processed Date Time"; Rec."Matching Processed Date Time")
                {
                    ToolTip = 'Specifies the value of the Matching Processed Date Time field.', Comment = '%';
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
            }

        }
        area(Factboxes)
        {
            part(IntegrationErrors; "Integration_Errors")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Record Type" = filter(LOB),
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
                    Navigate.SetDVSASource(TableSource, rec.PaymentReference);
                    Navigate.SetDoc(DT2Date(Rec.SystemCreatedAt), Rec.PaymentReference);
                    Navigate.Run();
                end;
            }

            action("CPMS Export")
            {
                Caption = 'TTS Transaction Listing';
                Image = ExportElectronicDocument;
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Executes the TTS Transaction Listing action.';

                trigger OnAction()
                var
                    TTSStagingExport: codeunit "TTS Staging Export";
                begin
                    TTSStagingExport.CreateTTSCSVFile();
                end;
            }
            Action("Export TTS Data")
            {
                ApplicationArea = All;
                Image = ExportToExcel;
                RunObject = report "TTS Data";
                ToolTip = 'Executes the Export TTS Data action.';
            }
            Action("Booked Not Delivered")
            {
                ApplicationArea = All;
                Image = ExportToExcel;
                RunObject = report "Booked Not Delivered";
                ToolTip = 'Executes the Booked Not Delivered action.';
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

                    CommonFunctions.ProcessTTSFilteredRecords(Rec);
                end;
            }
            action(Process_All)
            {
                ApplicationArea = All;
                Caption = 'Process All';
                Image = Process;
                ToolTip = 'Executes the Process All action.';
                Visible = false;
                trigger OnAction()
                var
                    TTSSAPSummary: Codeunit "Export SAP Summary";
                    UserSetup: Record "User Setup";
                    NoPermission: Label 'You do not have permission to process TTS SAP records';
                begin
                    if not UserSetup.get(UserId) then
                        Error(NoPermission);
                    if UserSetup."Integration Admin" = false then
                        Error(NoPermission);
                    if Confirm('Do you want to process all the records?') then begin
                        Clear(TTSSAPSummary);
                        TTSSAPSummary.CreateTTSSummary(Enum::"Summary Export Type"::All, '');
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
                    TTSRec: Record TTS_SAP;
                    Progress: Dialog;
                    Counter: Integer;
                    ProgressMsg: Label 'Validating......#1######################\';
                begin
                    Clear(Counter);
                    Progress.Open(ProgressMsg);
                    CurrPage.SetSelectionFilter(TTSRec);
                    if TTSRec.FindSet(false) then
                        repeat
                            Counter += 1;
                            Progress.Update(1, Counter);// Update the field in the dialog.
                            CommonFunc.ErrorCheckRecord(TTSRec);
                        until TTSRec.Next() = 0;
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
                    TTSRec: Record TTS_SAP;
                    Progress: Dialog;
                    Counter: Integer;
                    ProgressMsg: Label 'Validating......#1######################\';
                begin
                    Clear(Counter);
                    Progress.Open(ProgressMsg);
                    TTSRec.CopyFilters(Rec);
                    TTSRec.SetRange(Posted, false);
                    if TTSRec.FindSet(false) then
                        repeat
                            Counter += 1;
                            Progress.Update(1, Counter);// Update the field in the dialog.
                            CommonFunc.ErrorCheckRecord(TTSRec);
                        until TTSRec.Next() = 0;
                    Progress.Close();
                end;
            }
            action(Undo)
            {
                ApplicationArea = All;
                Caption = 'Undo All Posted Records';
                Image = Process;
                ToolTip = 'Executes the Undo All Posted Records action.';
                Visible = false;
                trigger OnAction()
                var
                    TTS: Record TTS_SAP;
                begin
                    TTS.SetRange(posted, true);
                    if TTS.FindSet(true) then begin
                        tts.ModifyAll("SAP Register No.", 0);
                        tts.ModifyAll("Credit Acc No.", '');
                        tts.ModifyAll("Debit Acc No.", '');
                        TTS.ModifyAll(Posted, false);
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
            if (Rec.Activity = 'TESTMATCH') and (Rec.TESTMATCH = 'NO INVOICE') then
                StyleExp := 'Strongaccent';

    end;




    var
        AllowEdit: Boolean;
        StyleExp: Text;


}
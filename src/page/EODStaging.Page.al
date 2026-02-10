page 85014 "EOD Staging"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "EOD Staging";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Editable = AllowEdit;
                field("Unique Tran Id"; Rec."Unique Trans Id")
                {
                    ToolTip = 'Specifies the value of the Unique Trans Id field.';
                    StyleExpr = StyleExp;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Site ID"; Rec."Site ID")
                {
                    ToolTip = 'Specifies the value of the Site ID field.';
                    StyleExpr = StyleExp;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                    StyleExpr = StyleExp;
                }
                field("Reference Number"; Rec."Reference Number")
                {
                    ToolTip = 'Specifies the value of the Reference Number field.';
                    StyleExpr = StyleExp;
                }
                field("Reference Number 2"; Rec."Reference Number 2")
                {
                    ToolTip = 'Specifies the value of the Reference Number 2 field.';
                    StyleExpr = StyleExp;
                }
                field("Fund Code"; Rec."Fund Code")
                {
                    ToolTip = 'Specifies the value of the Fund Code field.';
                    StyleExpr = StyleExp;
                }
                field("Pay Code"; Rec."Pay Code")
                {
                    ToolTip = 'Specifies the value of the Pay Code field.';
                    StyleExpr = StyleExp;
                }
                field("Alternate Fund Code"; Rec."Alternate Fund Code")
                {
                    ToolTip = 'Specifies the value of the Alternate Fund Code field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Alternate Pay Code"; Rec."Alternate Pay Code")
                {
                    ToolTip = 'Specifies the value of the Alternate Pay Code field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Transacion Amount"; Rec."Transaction Amount")
                {
                    ToolTip = 'Specifies the value of the Transaction Amount field.';
                    StyleExpr = StyleExp;
                }
                field("Pay Amount"; Rec."Pay Amount")
                {
                    ToolTip = 'Specifies the value of the Pay Amount field.';
                    StyleExpr = StyleExp;
                }
                field("Issue Number"; Rec."Issue Number")
                {
                    ToolTip = 'Specifies the value of the Issue Number field.';
                    StyleExpr = StyleExp;
                }
                field("Last 4 Card Digits"; Rec."Last 4 Card Digits")
                {
                    ToolTip = 'Specifies the value of the Last 4 Card Digits field.';
                    StyleExpr = StyleExp;
                }
                field("Card Transaction Type"; Rec."Card Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Card Transaction Type field.';
                    StyleExpr = StyleExp;
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                    StyleExpr = StyleExp;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    StyleExpr = StyleExp;
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the Surname field.';
                    StyleExpr = StyleExp;
                }
                field("Card Long Number"; Rec."Card Long Number")
                {
                    ToolTip = 'Specifies the value of the Card Long Number field.';
                    StyleExpr = StyleExp;
                }
                field("Secure Transaction Id"; Rec."Secure Transaction Id")
                {
                    ToolTip = 'Specifies the value of the Secure Transaction Id field.';
                    StyleExpr = StyleExp;
                }
                field("Auth Code"; Rec."Auth Code")
                {
                    ToolTip = 'Specifies the value of the Auth Code field.';
                    StyleExpr = StyleExp;
                }
                field(Narrative; Rec.Narrative)
                {
                    ToolTip = 'Specifies the value of the Narrative field.';
                    StyleExpr = StyleExp;
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Payment Reference field.';
                }
                field(Processed; Rec.Processed)
                {
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Processed field.';
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
                field("Matching Date Time"; Rec."Matching Processed Date Time")
                {
                    ToolTip = 'Specifies the value of the Matching Date Time field.', Comment = '%';
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

            }
        }
        area(Factboxes)
        {
            part(IntegrationErrors; "Integration_Errors")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Record Type" = filter(EOD),
                              "Record Entry No." = field("Entry No.");
                Caption = 'Errors';
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(UnmatchRecords)
            {
                ApplicationArea = All;
                ToolTip = 'Executes the ActionName action.';
                Visible = false;
                trigger OnAction()
                var
                    EOD: Record "EOD Staging";
                    LOB: Record TTS_ARAP;
                    CPMS: Record TTS_SAP;
                begin
                    EOD.ModifyAll("Matching Status", EOD."Matching Status"::Unmatched);
                    EOD.ModifyAll("Matching ID", '');
                    LOB.ModifyAll("LOB Matching Status", LOB."LOB Matching Status"::Unmatched);
                    LOB.ModifyAll("LOB Matching ID", '');

                    LOB.ModifyAll("EOD Matching Status", LOB."EOD Matching Status"::Unmatched);
                    LOB.ModifyAll("EOD Matching ID", '');

                    CPMS.ModifyAll("Matching Status", EOD."Matching Status"::Unmatched);
                    CPMS.ModifyAll("Matching ID", '');


                end;
            }
            Action("Export EOD Data")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ExportToExcel;
                RunObject = report "EOD Data";
            }
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
                    Navigate.SetDVSASource(TableSource, rec."Reference Number");
                    Navigate.SetDoc(DT2Date(Rec.SystemCreatedAt), Rec."Reference Number");
                    Navigate.Run();
                end;
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

    end;

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // var
    //     EODStaging: Record "EOD Staging";
    // begin
    //     EODStaging.Reset();
    //     if EODStaging.FindLast() then
    //         Rec."Entry No." := EODStaging."Entry No." + 1
    //     else
    //         Rec."Entry No." := 1;
    // end;

    var
        AllowEdit: Boolean;
        StyleExp: Text;


}
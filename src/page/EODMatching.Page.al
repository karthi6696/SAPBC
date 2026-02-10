page 85020 "EOD Matching"
{
    ApplicationArea = All;
    Caption = 'EOD Matching';
    PageType = ListPart;
    SourceTable = "EOD Staging";
    SourceTableView = sorting("Matching Status", "Matching Processed Date Time") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = AllowEdit;
                field("Reference Number"; Rec."Reference Number")
                {
                    ToolTip = 'Specifies the value of the Reference Number field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Reference Number 2"; Rec."Reference Number 2")
                {
                    ToolTip = 'Specifies the value of the Reference Number 2 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Fund Code"; Rec."Fund Code")
                {
                    ToolTip = 'Specifies the value of the Fund Code field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Pay Code"; Rec."Pay Code")
                {
                    ToolTip = 'Specifies the value of the Pay Code field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Transacion Amount"; Rec."Transaction Amount")
                {
                    ToolTip = 'Specifies the value of the Transacion Amount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Pay Amount"; Rec."Pay Amount")
                {
                    ToolTip = 'Specifies the value of the Pay Amount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Last 4 Card Digits"; Rec."Last 4 Card Digits")
                {
                    ToolTip = 'Specifies the value of the Last 4 Card Digits field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Card Transaction Type"; Rec."Card Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Card Transaction Type field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(Processed; Rec.Processed)
                {
                    ToolTip = 'Specifies the value of the Processed field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching ID"; Rec."Matching ID")
                {
                    ToolTip = 'Specifies the value of the Matching ID field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching Date Time"; Rec."Matching Processed Date Time")
                {
                    ToolTip = 'Specifies the value of the Matching Date Time field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching Status"; Rec."Matching Status")
                {
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Matching Status field.', Comment = '%';
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
                field("Match Type"; Rec."Match Type")
                {
                    ToolTip = 'Specifies the value of the Match Type field.', Comment = '%';
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
                field("Auth Code"; Rec."Auth Code")
                {
                    ToolTip = 'Specifies the value of the Auth Code field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Card Long Number"; Rec."Card Long Number")
                {
                    ToolTip = 'Specifies the value of the Card Long Number field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Issue Number"; Rec."Issue Number")
                {
                    ToolTip = 'Specifies the value of the Issue Number field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(Narrative; Rec.Narrative)
                {
                    ToolTip = 'Specifies the value of the Narrative field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ToolTip = 'Specifies the value of the Payment Reference field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Record Amount"; Rec."Record Amount")
                {
                    ToolTip = 'Specifies the value of the Record Amount field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Secure Transaction Id"; Rec."Secure Transaction Id")
                {
                    ToolTip = 'Specifies the value of the Secure Transaction Id field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Site ID"; Rec."Site ID")
                {
                    ToolTip = 'Specifies the value of the Site ID field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the Surname field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("User Code"; Rec."User Code")
                {
                    ToolTip = 'Specifies the value of the User Code field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Unique Trans Id"; Rec."Unique Trans Id")
                {
                    ToolTip = 'Specifies the value of the Unique Trans Id field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ToolTip = 'Specifies the value of the Transaction Time field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Linked CPMS")
            {
                Image = Links;
                trigger OnAction()
                var
                    CPMS: Record TTS_ARAP;
                begin
                    if Rec."Matching Status" IN [Rec."Matching Status"::Matched, Rec."Matching Status"::Error] then begin
                        CPMS.Reset();
                        CPMS.SetRange("EOD Matching ID", Rec."Matching ID");
                        CPMS.SetRange("EOD Matching Status", Rec."Matching Status");
                        Page.RunModal(page::"CPMS with EOD Matching", CPMS);
                    end;
                end;
            }

            action("Force Match")
            {
                Image = LinkAccount;
                trigger OnAction()
                var
                    EODRecords: Record "EOD Staging";
                    MatchID: Code[20];
                    Noseries: Codeunit "No. Series";
                    GLSetup: Record "General Ledger Setup";
                    ForceMatchLbl: Label 'Matched Forcefully';
                begin
                    if not Confirm('Do you want to proceed with Force Matching?', true) then
                        exit;
                    CurrPage.SetSelectionFilter(EODRecords);
                    GLSetup.get();
                    MatchID := Noseries.GetNextNo(GLSetup."EOD-CPMS Matching No. Series");
                    if EODRecords.FindSet(true) then
                        repeat
                            EODRecords."Matching Status" := EODRecords."Matching Status"::Matched;
                            EODRecords."Matching ID" := MatchID;
                            EODRecords."Match Type" := EODRecords."Match Type"::Force;
                            EODRecords."Matching Processed Date Time" := CurrentDateTime;
                            EODRecords."Matched By" := UserId;
                            EODRecords."Match Details" := ForceMatchLbl;
                            EODRecords.Modify();
                        until EODRecords.Next(-1) = 0;
                end;
            }
            action("Remove Match")
            {
                Image = LinkAccount;
                trigger OnAction()
                var
                    EODRecords: Record "EOD Staging";
                begin
                    if not Confirm('Do you want to proceed with Remove Matching?', true) then
                        exit;
                    CurrPage.SetSelectionFilter(EODRecords);

                    EODRecords.SetRange("Match Type", EODRecords."Match Type"::Force);
                    if EODRecords.FindSet() then
                        repeat
                            EODRecords.Validate("Matching Status", EODRecords."Matching Status"::Unmatched);
                            EODRecords.Modify();
                        until EODRecords.Next(-1) = 0;
                end;
            }
            action("EOD Export")
            {
                Caption = 'Unmatched Items EOD';
                Image = ExportElectronicDocument;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EODExport: Codeunit "EOD Export";
                begin
                    EODExport.CreateEODCSVFile();
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

    var
        AllowEdit: Boolean;

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

    procedure ToggleMatchedFilter(SetFilterOn: Boolean)
    begin
        if SetFilterOn then begin
            rec.SetRange("Matching Status");
            Rec.SetRange("Matching Status", Rec."Matching Status"::Unmatched)
        end else
            Rec.Reset();
        CurrPage.Update();
    end;

    procedure ShowErroredRecord()
    begin
        rec.SetRange("Matching Status");
        Rec.SetRange("Matching Status", Rec."Matching Status"::Error);
        CurrPage.Update();
    end;

    procedure ShowMatchedRecord()
    begin
        rec.SetRange("Matching Status");
        Rec.SetRange("Matching Status", Rec."Matching Status"::Matched);
        CurrPage.Update();
    end;

    procedure ShowForceMatchedRecord()
    begin
        rec.SetRange("Matching Status");
        Rec.SetRange("Matching Status", Rec."Matching Status"::Matched);
        Rec.SetRange("Match Type", Rec."Match Type"::Force);
        CurrPage.Update();
    end;

    procedure RemoveEODMatching()
    var
        EODStaging, EODStaging1 : Record "EOD Staging";
        CPMSStaging: Record TTS_ARAP;
        MatchingID: Code[20];
    begin
        CurrPage.SetSelectionFilter(EODStaging);
        Clear(MatchingID);
        EODStaging.SetLoadFields("Matching ID", "Matching Status");
        EODStaging.SetRange("Matching Status", EODStaging."Matching Status"::Matched);
        EODStaging.SetFilter("Matching ID", '<>%1', '');
        if EODStaging.FindSet() then
            repeat
                if MatchingID <> EODStaging."Matching ID" then begin
                    CPMSStaging.Reset();
                    CPMSStaging.SetLoadFields("EOD Matching ID", "EOD Matching Status");
                    CPMSStaging.SetRange("EOD Matching ID", EODStaging."Matching ID");
                    CPMSStaging.SetRange("EOD Matching Status", CPMSStaging."EOD Matching Status"::Matched);
                    if CPMSStaging.FindSet(true) then
                        repeat
                            CPMSStaging.Validate("EOD Matching Status", CPMSStaging."EOD Matching Status"::Unmatched);
                            CPMSStaging.Modify(false);
                        until CPMSStaging.Next() = 0;

                    EODStaging1.Reset();
                    EODStaging1.SetLoadFields("Matching ID", "Matching Status");
                    EODStaging1.SetRange("Matching ID", EODStaging."Matching ID");
                    EODStaging1.SetRange("Matching Status", EODStaging1."Matching Status"::Matched);
                    if EODStaging1.FindSet(true) then
                        repeat
                            EODStaging1.Validate("Matching Status", EODStaging1."Matching Status"::Unmatched);
                            EODStaging1.Modify(false);
                        until EODStaging1.Next() = 0;
                end;
                MatchingID := EODStaging."Matching ID";
            until EODStaging.Next() = 0;
    end;

    procedure GetSelectedRecords(var SelectedEOD: Record "EOD Staging" temporary)
    var
        EOD: Record "EOD Staging";
    begin
        CurrPage.SetSelectionFilter(EOD);
        if EOD.FindSet() then
            repeat
                SelectedEOD := EOD;
                SelectedEOD.Insert();
            until EOD.Next() = 0;
    end;

    procedure SetSchemeFilter(Scheme: Code[20])
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Fund Code", Scheme + '*');
        Rec.FilterGroup(0);
        CurrPage.Update();
    end;

    var
        StyleExp: Text;

}

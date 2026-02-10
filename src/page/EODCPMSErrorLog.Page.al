page 85027 "EOD-CPMS Error Log"
{
    ApplicationArea = All;
    Caption = 'EOD-CPMS Error Log';
    PageType = List;
    SourceTable = "EOD Staging";
    UsageCategory = None;
    SourceTableView = where("Matching Status" = filter(error));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ToolTip = 'Specifies the value of the Payment Reference field.', Comment = '%';
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
                }
                field("Auth Code"; Rec."Auth Code")
                {
                    ToolTip = 'Specifies the value of the Auth Code field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Card Transaction Type"; Rec."Card Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Card Transaction Type field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Card Long Number"; Rec."Card Long Number")
                {
                    ToolTip = 'Specifies the value of the Card Long Number field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Fund Code"; Rec."Fund Code")
                {
                    ToolTip = 'Specifies the value of the Fund Code field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Issue Number"; Rec."Issue Number")
                {
                    ToolTip = 'Specifies the value of the Issue Number field.', Comment = '%';
                }
                field("Last 4 Card Digits"; Rec."Last 4 Card Digits")
                {
                    ToolTip = 'Specifies the value of the Last 4 Card Digits field.', Comment = '%';
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
                field("Pay Amount"; Rec."Pay Amount")
                {
                    ToolTip = 'Specifies the value of the Pay Amount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Pay Code"; Rec."Pay Code")
                {
                    ToolTip = 'Specifies the value of the Pay Code field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Process Date"; Rec."Process Date")
                {
                    ToolTip = 'Specifies the value of the Process Date field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Process Time"; Rec."Process Time")
                {
                    ToolTip = 'Specifies the value of the Process Time field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Record Amount"; Rec."Record Amount")
                {
                    ToolTip = 'Specifies the value of the Record Amount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.', Comment = '%';
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
                field("Transaction Amount"; Rec."Transaction Amount")
                {
                    ToolTip = 'Specifies the value of the Transacion Amount field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ToolTip = 'Specifies the value of the Transaction Time field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Unique Trans Id"; Rec."Unique Trans Id")
                {
                    ToolTip = 'Specifies the value of the Unique Trans Id field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("User Code"; Rec."User Code")
                {
                    ToolTip = 'Specifies the value of the User Code field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Rule No."; Rec."Rule No.")
                {
                    ToolTip = 'Specifies the value of the Rule No. field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Match Type"; Rec."Match Type")
                {
                    ToolTip = 'Specifies the value of the Match Type field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Matching Status"; Rec."Matching Status")
                {
                    ToolTip = 'Specifies the value of the Matching Status field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching ID"; Rec."Matching ID")
                {
                    ToolTip = 'Specifies the value of the Matching ID field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matched By"; Rec."Matched By")
                {
                    ToolTip = 'Specifies the value of the Matched By field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Match Details"; Rec."Match Details")
                {
                    ToolTip = 'Specifies the value of the Match Details field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Processed Date Time"; Rec."Matching Processed Date Time")
                {
                    ToolTip = 'Specifies the value of the Matching Date Time field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
            }
            part(CPMS; "CPMS with EOD Matching")
            {
                Caption = 'CPMS';
                ApplicationArea = All;
                SubPageView = where("EOD Matching Status" = filter(Error));
                SubPageLink = "EOD Matching ID" = field("Matching ID");
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

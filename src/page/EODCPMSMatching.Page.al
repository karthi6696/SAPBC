page 85019 "EOD-CPMS Matching"
{
    ApplicationArea = All;
    Caption = 'EOD-CPMS Matching';
    PageType = ListPlus;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;
                part(EOD; "EOD Matching")
                {
                    Caption = 'EOD';
                    ApplicationArea = All;
                }
                part(CPMS; "CPMS with EOD Matching")
                {
                    Caption = 'CPMS';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("M&atching")
            {
                Caption = 'M&atching';
                action(MatchAutomatically)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Automatically';
                    Image = MapAccounts;
                    ToolTip = 'Automatically search for and match lines.';

                    trigger OnAction()
                    var
                        MatchingProcess: Codeunit "Matching Process";
                    begin
                        if not Confirm('Do you want to proceed with Automatic Matching?', true) then
                            exit;
                        Clear(MatchingProcess);
                        MatchingProcess.SetMatchType(Enum::"Match Type"::Automatic);
                        MatchingProcess.MatchEODCPMSData();
                    end;
                }
                action(MatchManually)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Manually';
                    Image = CheckRulesSyntax;
                    ToolTip = 'Manually match selected lines in both panes to link each line.';

                    trigger OnAction()
                    var
                        TempEOD: Record "EOD Staging" temporary;
                        TempCPMS: Record TTS_ARAP temporary;
                        MatchingProcess: Codeunit "Matching Process";
                    begin
                        if not Confirm('Do you want to proceed with Manual Matching?', true) then
                            exit;
                        CurrPage.EOD.Page.GetSelectedRecords(TempEOD);
                        CurrPage.CPMS.Page.GetSelectedRecords(TempCPMS);
                        Clear(MatchingProcess);
                        MatchingProcess.SetMatchType(Enum::"Match Type"::Manual);
                        MatchingProcess.SetSelectedEOD(TempEOD);
                        MatchingProcess.SetSelectedCPMS(TempCPMS);
                        MatchingProcess.MatchEODCPMSData();
                    end;
                }
                action(ForceMatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Force Match';
                    Image = CheckRulesSyntax;
                    Visible = false;

                    trigger OnAction()
                    var
                        TempEOD: Record "EOD Staging" temporary;
                        TempCPMS: Record TTS_ARAP temporary;
                        MatchingProcess: Codeunit "Matching Process";
                    begin
                        if not Confirm('Do you want to proceed with Force Matching?', true) then
                            exit;
                        CurrPage.EOD.Page.GetSelectedRecords(TempEOD);
                        CurrPage.CPMS.Page.GetSelectedRecords(TempCPMS);
                        Clear(MatchingProcess);
                        MatchingProcess.ForceEODCPMSMatch(TempEOD, TempCPMS);
                    end;
                }
                action(RemoveMatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove Match';
                    Image = RemoveContacts;
                    ToolTip = 'Remove selection of matched lines.';


                    trigger OnAction()
                    begin
                        if Confirm('Do you want to remove the matching on the selected records?') then
                            CurrPage.EOD.Page.RemoveEODMatching();
                    end;
                }
                action(MatchDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Match Details';
                    Image = ViewDetails;
                    ToolTip = 'Show matching details about the selected line.';
                    Visible = false;
                    trigger OnAction()

                    begin
                    end;
                }
                action(All)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show All';
                    Image = AddWatch;
                    ToolTip = 'Show all lines.';

                    trigger OnAction()
                    begin
                        CurrPage.EOD.Page.ToggleMatchedFilter(false);
                        CurrPage.CPMS.Page.ToggleEODMatchedFilter(false);
                    end;
                }
                action(NotMatched)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Nonmatched';
                    Image = AddWatch;
                    ToolTip = 'Show all lines that have not yet been matched.';

                    trigger OnAction()
                    begin
                        CurrPage.EOD.Page.ToggleMatchedFilter(true);
                        CurrPage.CPMS.Page.ToggleEODMatchedFilter(true);
                    end;
                }
                action(Errored)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Errored';
                    Image = AddWatch;
                    ToolTip = 'Show all lines that have been errored.';

                    trigger OnAction()
                    begin
                        CurrPage.EOD.Page.ShowErroredRecord();
                        CurrPage.CPMS.Page.ShowErroredRecord();
                    end;
                }
                action(Matched)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Matched';
                    Image = AddWatch;
                    ToolTip = 'Show all lines that have been errored.';

                    trigger OnAction()
                    begin
                        CurrPage.EOD.Page.ShowMatchedRecord();
                        CurrPage.CPMS.Page.ShowMatchedRecord();
                    end;
                }
                action(ErrorLogs)
                {
                    Image = ErrorLog;
                    Caption = 'Error Logs';
                    RunObject = page "EOD-CPMS Error Log";
                }
            }
        }
        area(Promoted)
        {
            group(Category_Category5)
            {
                Caption = 'Filters', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(ShowPromoted; All)
                {

                }
                actionref(ShowUnMatchedPromoted; NotMatched)
                {

                }
                actionref(ShowMatched_Promoted; Matched)
                {

                }
                actionref(ShowErr_Promoted; Errored)
                {
                }
            }
            group(Matching)
            {
                actionref(MatchAutomatically_Promoted; MatchAutomatically)
                {
                }
                actionref(MatchManually_Promoted; MatchManually)
                {
                }
                actionref(ForceMatch_Promoted; ForceMatch)
                {

                }
                actionref(RemoveMatch_Promoted; RemoveMatch)
                {
                }
            }
            group(Navigate)
            {
                actionref(ErrorLogs_Promoted; ErrorLogs)
                {

                }
            }
        }
    }


    trigger OnOpenPage()
    var
        ChooseScheme: Page "Choose Scheme";
    begin
        if ChooseScheme.RunModal() = Action::OK then begin
            CurrPage.EOD.Page.SetSchemeFilter(ChooseScheme.GetScheme());
            CurrPage.CPMS.Page.SetSchemeFilter(ChooseScheme.GetScheme());
        end else
            Error('');

        case true of
            gMatchStatus = gMatchStatus::Unmatched:
                begin
                    CurrPage.EOD.Page.ToggleMatchedFilter(true);
                    CurrPage.CPMS.Page.ToggleEODMatchedFilter(true);
                end;
            gMatchStatus = gMatchStatus::Error:
                begin
                    CurrPage.EOD.Page.ShowErroredRecord();
                    CurrPage.CPMS.Page.ShowErroredRecord();
                end;
            gMatchStatus = gMatchStatus::Matched:
                begin
                    CurrPage.EOD.Page.ShowMatchedRecord();
                    CurrPage.CPMS.Page.ShowMatchedRecord();
                end;
            gMatchStatus = gMatchStatus::Force:
                begin
                    CurrPage.EOD.Page.ShowForceMatchedRecord();
                    CurrPage.CPMS.Page.ShowForceMatchedRecord();
                end;
        end;
    end;

    procedure SkipSchemeSelectionAndApplyMatchFilter(MatchStatus: Option Matched,Unmatched,Error,Force)
    begin
        gMatchStatus := MatchStatus;
    end;

    var
        SkipSelection: Boolean;
        gMatchStatus: Option Matched,Unmatched,Error,Force;
}
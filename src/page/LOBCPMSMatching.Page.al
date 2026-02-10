page 85022 "LOB-CPMS Matching"
{
    ApplicationArea = All;
    Caption = 'LOB-CPMS Matching';
    PageType = ListPlus;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;
                part(TTS; "LOB Matching")
                {
                    Caption = 'LOB';
                    ApplicationArea = All;
                }
                part(CPMS; "CPMS with LOB Matching")
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
                        MatchingProcess.MatchLOBCPMSData();
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
                        TempLOB: Record TTS_SAP temporary;
                        TempCPMS: Record TTS_ARAP temporary;
                        MatchingProcess: Codeunit "Matching Process";
                        LOBCount, CPMSCount: Integer;
                        ConfirmMsg: Label 'Manual Match Summary:\LOB Records Selected: %1\CPMS Records Selected: %2\\Do you want to proceed with manual matching?';
                    begin
                        // Selection Validation: Get selected records and validate
                        CurrPage.TTS.Page.GetSelectedRecords(TempLOB);
                        CurrPage.CPMS.Page.GetSelectedRecords(TempCPMS);
                        
                        LOBCount := TempLOB.Count();
                        CPMSCount := TempCPMS.Count();
                        
                        // Validation: Ensure both sides have selections
                        if LOBCount = 0 then
                            Error('Please select at least one LOB record before manual matching.');
                        if CPMSCount = 0 then
                            Error('Please select at least one CPMS record before manual matching.');
                        
                        // Enhanced confirmation with selection counts
                        if not Confirm(StrSubstNo(ConfirmMsg, LOBCount, CPMSCount), true) then
                            exit;

                        Clear(MatchingProcess);
                        MatchingProcess.SetMatchType(Enum::"Match Type"::Manual);
                        MatchingProcess.SetSelectedLOB(TempLOB);
                        MatchingProcess.SetSelectedCPMS(TempCPMS);
                        MatchingProcess.MatchLOBCPMSData();
                    end;
                }
                action(ForceMatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Force Match';
                    Image = CheckRulesSyntax;
                    ToolTip = 'Executes the Force Match action.';
                    Visible = false;
                    trigger OnAction()
                    var
                        TempLOB: Record TTS_SAP temporary;
                        TempCPMS: Record TTS_ARAP temporary;
                        MatchingProcess: Codeunit "Matching Process";
                        LOBCount, CPMSCount: Integer;
                    begin
                        // Selection Validation: Get selected records and validate
                        CurrPage.TTS.Page.GetSelectedRecords(TempLOB);
                        CurrPage.CPMS.Page.GetSelectedRecords(TempCPMS);
                        
                        LOBCount := TempLOB.Count();
                        CPMSCount := TempCPMS.Count();
                        
                        // Validation: Ensure both sides have selections
                        if LOBCount = 0 then
                            Error('Please select at least one LOB record before force matching.');
                        if CPMSCount = 0 then
                            Error('Please select at least one CPMS record before force matching.');
                        
                        // Force match will show its own detailed confirmation
                        Clear(MatchingProcess);
                        MatchingProcess.ForceLOBCPMSMatch(TempLOB, TempCPMS);
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
                            CurrPage.TTS.Page.RemoveLOBMatching();
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
                    var
                        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
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
                        CurrPage.TTS.Page.ToggleMatchedFilter(false);
                        CurrPage.CPMS.Page.ToggleLOBMatchedFilter(false);
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
                        CurrPage.TTS.Page.ToggleMatchedFilter(true);
                        CurrPage.CPMS.Page.ToggleLOBMatchedFilter(true);
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
                        CurrPage.TTS.Page.ShowErroredRecord();
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
                        CurrPage.TTS.Page.ShowMatchedRecord();
                        CurrPage.CPMS.Page.ShowMatchedRecord();
                    end;
                }
                action(ErrorLogs)
                {
                    Image = ErrorLog;
                    Caption = 'Error Logs';
                    RunObject = page "LOB-CPMS Error Log";
                    ToolTip = 'Executes the Error Logs action.';
                }
            }
        }
        area(Promoted)
        {
            group(Category_Category5)
            {
                Caption = 'Filters', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(ShowAllPromoted; All)
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
            CurrPage.TTS.Page.SetSchemeFilter(ChooseScheme.GetScheme());
            CurrPage.CPMS.Page.SetSchemeFilter(ChooseScheme.GetScheme());
        end else
            Error('');

        case true of
            gMatchStatus = gMatchStatus::Unmatched:
                begin
                    CurrPage.TTS.Page.ToggleMatchedFilter(true);
                    CurrPage.CPMS.Page.ToggleLOBMatchedFilter(true);
                end;
            gMatchStatus = gMatchStatus::Error:
                begin
                    CurrPage.TTS.Page.ShowErroredRecord();
                    CurrPage.CPMS.Page.ShowErroredRecord();
                end;
            gMatchStatus = gMatchStatus::Matched:
                begin
                    CurrPage.TTS.Page.ShowMatchedRecord();
                    CurrPage.CPMS.Page.ShowMatchedRecord();
                end;
            gMatchStatus = gMatchStatus::Force:
                begin
                    CurrPage.TTS.Page.ShowForceMatchedRecord();
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

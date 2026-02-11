page 85030 "TTS-ARAP Matching"
{
    ApplicationArea = All;
    Caption = 'TTS-ARAP Matching';
    PageType = ListPlus;
    UsageCategory = Tasks;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;
                part(TTSSAP; "TTS-ARAP TTS_SAP Matching")
                {
                    Caption = 'TTS (LOB)';
                    ApplicationArea = All;
                }
                part(TTSARAP; "TTS-ARAP TTS_ARAP Matching")
                {
                    Caption = 'ARAP (CPMS)';
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
                    ApplicationArea = All;
                    Caption = 'Match Automatically';
                    Image = MapAccounts;
                    ToolTip = 'Automatically search for and match lines based on PaymentReference/ReceiptNumber and matching amounts.';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    
                    trigger OnAction()
                    var
                        TTSARAPMatching: Codeunit "TTS-ARAP Matching";
                        ConfirmMsg: Label 'This will automatically match TTS_SAP records (Scheme=FTTS, Activity=INVOICE) with TTS_ARAP records (Scheme=FTTS, Activity=PAYMENT) based on PaymentReference/ReceiptNumber and matching amounts.\Do you want to proceed?';
                    begin
                        if not Confirm(ConfirmMsg, true) then
                            exit;
                        
                        Clear(TTSARAPMatching);
                        TTSARAPMatching.SetMatchType(Enum::"Match Type"::Automatic);
                        TTSARAPMatching.MatchTTSARAPData();
                        
                        CurrPage.TTSSAP.Page.Update(false);
                        CurrPage.TTSARAP.Page.Update(false);
                    end;
                }
                
                action(MatchManually)
                {
                    ApplicationArea = All;
                    Caption = 'Match Manually';
                    Image = CheckRulesSyntax;
                    ToolTip = 'Manually match selected lines in both panes based on the same criteria.';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    
                    trigger OnAction()
                    var
                        TempTTSSAP: Record TTS_SAP temporary;
                        TempTTSARAP: Record TTS_ARAP temporary;
                        TTSARAPMatching: Codeunit "TTS-ARAP Matching";
                        TTSSAPCount, TTSARAPCount: Integer;
                        ConfirmMsg: Label 'Manual Match Summary:\TTS Records Selected: %1\ARAP Records Selected: %2\\This will match within the selected records where PaymentReference equals ReceiptNumber and amounts match.\Do you want to proceed with manual matching?';
                    begin
                        // Get selected records and validate
                        CurrPage.TTSSAP.Page.GetSelectedRecords(TempTTSSAP);
                        CurrPage.TTSARAP.Page.GetSelectedRecords(TempTTSARAP);
                        
                        TTSSAPCount := TempTTSSAP.Count();
                        TTSARAPCount := TempTTSARAP.Count();
                        
                        // Validation: Ensure both sides have selections
                        if TTSSAPCount = 0 then
                            Error('Please select at least one TTS record before manual matching.');
                        if TTSARAPCount = 0 then
                            Error('Please select at least one ARAP record before manual matching.');
                        
                        // Enhanced confirmation with selection counts
                        if not Confirm(StrSubstNo(ConfirmMsg, TTSSAPCount, TTSARAPCount), true) then
                            exit;
                        
                        Clear(TTSARAPMatching);
                        TTSARAPMatching.SetMatchType(Enum::"Match Type"::Manual);
                        TTSARAPMatching.SetSelectedTTSSAP(TempTTSSAP);
                        TTSARAPMatching.SetSelectedTTSARAP(TempTTSARAP);
                        TTSARAPMatching.MatchTTSARAPData();
                        
                        CurrPage.TTSSAP.Page.Update(false);
                        CurrPage.TTSARAP.Page.Update(false);
                    end;
                }
                
                action(ShowAll)
                {
                    ApplicationArea = All;
                    Caption = 'Show All';
                    Image = AddWatch;
                    ToolTip = 'Show all lines.';
                    
                    trigger OnAction()
                    begin
                        CurrPage.TTSSAP.Page.ToggleMatchedFilter(false);
                        CurrPage.TTSARAP.Page.ToggleMatchedFilter(false);
                    end;
                }
                
                action(ShowUnmatched)
                {
                    ApplicationArea = All;
                    Caption = 'Show Unmatched';
                    Image = AddWatch;
                    ToolTip = 'Show all lines that have not yet been matched.';
                    
                    trigger OnAction()
                    begin
                        CurrPage.TTSSAP.Page.ToggleMatchedFilter(true);
                        CurrPage.TTSARAP.Page.ToggleMatchedFilter(true);
                    end;
                }
                
                action(ShowErrored)
                {
                    ApplicationArea = All;
                    Caption = 'Show Errored';
                    Image = AddWatch;
                    ToolTip = 'Show all lines that have been errored.';
                    
                    trigger OnAction()
                    begin
                        CurrPage.TTSSAP.Page.ShowErroredRecord();
                        CurrPage.TTSARAP.Page.ShowErroredRecord();
                    end;
                }
                
                action(ShowMatched)
                {
                    ApplicationArea = All;
                    Caption = 'Show Matched';
                    Image = AddWatch;
                    ToolTip = 'Show all lines that have been matched.';
                    
                    trigger OnAction()
                    begin
                        CurrPage.TTSSAP.Page.ShowMatchedRecord();
                        CurrPage.TTSARAP.Page.ShowMatchedRecord();
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Matching';
                
                actionref(MatchAutomatically_Promoted; MatchAutomatically)
                {
                }
                actionref(MatchManually_Promoted; MatchManually)
                {
                }
            }
            group(Category_Filters)
            {
                Caption = 'Filters';
                
                actionref(ShowAll_Promoted; ShowAll)
                {
                }
                actionref(ShowUnmatched_Promoted; ShowUnmatched)
                {
                }
                actionref(ShowMatched_Promoted; ShowMatched)
                {
                }
                actionref(ShowErrored_Promoted; ShowErrored)
                {
                }
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        // Set default filter to FTTS scheme
        CurrPage.TTSSAP.Page.SetSchemeFilter('FTTS');
        CurrPage.TTSARAP.Page.SetSchemeFilter('FTTS');
        
        // Default to showing unmatched records
        CurrPage.TTSSAP.Page.ToggleMatchedFilter(true);
        CurrPage.TTSARAP.Page.ToggleMatchedFilter(true);
    end;
}

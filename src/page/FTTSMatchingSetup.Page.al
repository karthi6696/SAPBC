page 85050 "FTTS Matching Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'FTTS Matching Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'FTTS Matching Configuration';
                
                field(Description1; DescriptionText1)
                {
                    Caption = 'Description';
                    Editable = false;
                    MultiLine = true;
                    ShowCaption = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                
                group(Criteria)
                {
                    Caption = 'Matching Criteria';
                    
                    field(Info1; 'TTS_SAP (LOB) Filters:')
                    {
                        ShowCaption = false;
                        Editable = false;
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field(Info2; '  • Scheme = FTTS')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(Info3; '  • Matching Status = Unmatched or Error')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(Info4; '  • Activity = INVOICE')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(Info5; '  • Matching Field: PaymentReference')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(Info6; '  • Sum Field: TestCostWithoutVat')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    
                    field(Spacer1; '')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    
                    field(Info7; 'TTS_ARAP (CPMS) Filters:')
                    {
                        ShowCaption = false;
                        Editable = false;
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field(Info8; '  • Scheme = FTTS')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(Info9; '  • LOB Matching Status = Unmatched or Error')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(Info10; '  • Activity = PAYMENT')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(Info11; '  • Matching Field: ReceiptNumber')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(Info12; '  • Sum Field: ReceiptAmount')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    
                    field(Spacer2; '')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    
                    field(Info13; 'Matching Logic:')
                    {
                        ShowCaption = false;
                        Editable = false;
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field(Info14; '  • Groups by PaymentReference/ReceiptNumber')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(Info15; '  • Compares sum of TestCostWithoutVat vs ReceiptAmount')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(Info16; '  • Marks as matched when amounts are equal')
                    {
                        ShowCaption = false;
                        Editable = false;
                    }
                }
            }
            
            group(RulesStatus)
            {
                Caption = 'Current Status';
                
                field(RulesExist; RulesExistText)
                {
                    Caption = 'Matching Rules Status';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = not RulesExist;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SetupRules)
            {
                Caption = 'Setup/Update Matching Rules';
                ToolTip = 'Creates or updates the FTTS matching rules in the system';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    FTTSMatchingSetup: Codeunit "FTTS Matching Setup";
                begin
                    FTTSMatchingSetup.SetupFTTSMatchingRules();
                    CheckRulesExist();
                end;
            }

            action(DeleteRules)
            {
                Caption = 'Delete Matching Rules';
                ToolTip = 'Deletes all FTTS matching rules from the system';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    FTTSMatchingSetup: Codeunit "FTTS Matching Setup";
                begin
                    FTTSMatchingSetup.DeleteFTTSMatchingRules();
                    CheckRulesExist();
                end;
            }

            action(ViewRules)
            {
                Caption = 'View Matching Rules';
                ToolTip = 'Opens the Matching Rules page filtered to FTTS rules';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    MatchingRules: Record "Matching Rules";
                begin
                    MatchingRules.Reset();
                    MatchingRules.SetRange(Scheme, 'FTTS');
                    MatchingRules.SetRange("Matching Type", MatchingRules."Matching Type"::"CPMS-LOB");
                    Page.Run(Page::"Matching Rules", MatchingRules);
                end;
            }

            action(RunMatching)
            {
                Caption = 'Run FTTS Matching Process';
                ToolTip = 'Runs the matching process for all FTTS rules';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MatchingProcess: Codeunit "Matching Process";
                    JobQueueEntry: Record "Job Queue Entry";
                begin
                    if not RulesExist then
                        Error('Please setup matching rules first before running the matching process.');

                    // Initialize a temporary Job Queue Entry for the matching process
                    JobQueueEntry.Init();
                    JobQueueEntry."Parameter String" := 'CPMS-LOB';

                    // Run the matching process
                    MatchingProcess.Run(JobQueueEntry);
                    Message('FTTS matching process completed successfully.');
                end;
            }
        }
    }

    var
        DescriptionText1: Label 'This page allows you to setup and manage matching rules for FTTS scheme between TTS_SAP and TTS_ARAP tables. The matching process is designed to handle large datasets efficiently (12k+ records daily).';
        RulesExist: Boolean;
        RulesExistText: Text;

    trigger OnOpenPage()
    begin
        CheckRulesExist();
    end;

    local procedure CheckRulesExist()
    var
        MatchingRules: Record "Matching Rules";
    begin
        MatchingRules.Reset();
        MatchingRules.SetRange(Scheme, 'FTTS');
        MatchingRules.SetRange("Matching Type", MatchingRules."Matching Type"::"CPMS-LOB");
        RulesExist := not MatchingRules.IsEmpty();
        
        if RulesExist then
            RulesExistText := StrSubstNo('✓ Rules configured (%1 rule(s) found)', MatchingRules.Count())
        else
            RulesExistText := '✗ No rules configured - Please click "Setup/Update Matching Rules"';
    end;
}

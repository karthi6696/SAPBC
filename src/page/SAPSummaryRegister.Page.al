page 85009 "SAP_Summary_Register"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SAP_Summary_Register;
    Caption = 'SAP Journal Register';
    //Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'Register No.';
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field(Scheme; Rec.Scheme)
                {
                    ToolTip = 'Specifies the value of the Scheme field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ToolTip = 'Specifies the value of the From Entry No. field.';
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                    ToolTip = 'Specifies the value of the To Entry No. field.';
                }
                field("Created At"; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field("Exported By"; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                    Visible = false;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Processed Records")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                Image = Process;

                trigger OnAction()
                var
                    CPMS: Record "CPMS Unsummarised Lines";
                    TTS: Record "TTS Unsummarised Lines";
                begin
                    if Rec.Type = Rec.Type::LOB then begin
                        TTS.Reset();
                        TTS.SetRange("SAP Register No.", Rec."Entry No.");
                        Page.Run(Page::"Processed TTS Entries", tts);
                    end else
                        if Rec.Type = Rec.Type::CPMS then begin
                            CPMS.Reset();
                            CPMS.SetRange("SAP Register No.", Rec."Entry No.");
                            Page.Run(Page::"Processed CPMS Entries", CPMS);
                        end;
                end;
            }
            action(View_Summary_Records)
            {
                ApplicationArea = All;
                Caption = 'View Journal Lines';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SuggestReminderLines;
                ToolTip = 'Executes the View Summary Records action.';

                trigger OnAction();
                var
                    SAPSummary: Record "SAP Journal";
                    TTSSummary: Page "TTS SAP Journal";
                    CPMSSummary: Page "CPMS SAP Journal";
                begin
                    SAPSummary.SetRange("Entry No.", rec."From Entry No.", Rec."To Entry No.");
                    if Rec.Type = Rec.Type::LOB then begin
                        Clear(TTSSummary);
                        TTSSummary.SetTableView(SAPSummary);
                        TTSSummary.Editable(false);
                        TTSSummary.Run();
                    end else
                        if Rec.Type = Rec.Type::CPMS then begin
                            Clear(CPMSSummary);
                            CPMSSummary.SetTableView(SAPSummary);
                            CPMSSummary.Editable(false);
                            CPMSSummary.Run();
                        end;
                end;
            }
            action("Export Register")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SuggestReminderLines;

                trigger OnAction()
                var
                    SAPSummaryExport: Codeunit "Export SAP Summary";
                begin
                    if Confirm('Do you want to export the selected register?') then begin
                        Clear(SAPSummaryExport);
                        SAPSummaryExport.ExportSummaryCSV(Rec.Type, Enum::"Summary Export Type"::All, Rec."Entry No.");
                    end;
                end;
            }
        }
    }
}
page 85008 "TTS SAP Journal"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SAP Journal";
    Caption = 'TTS SAP Journal';
    SourceTableView = where(Type = filter(Type::LOB));
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Column 1"; Rec."Column 1")
                {
                    ToolTip = 'Specifies the value of the Column 1 field.';
                }
                field("Column 2"; Rec."Column 2")
                {
                    ToolTip = 'Specifies the value of the Column 2 field.';
                }
                field("Column 3"; Rec."Column 3")
                {
                    ToolTip = 'Specifies the value of the Column 3 field.';
                }
                field("Column 4"; Rec."Column 4")
                {
                    ToolTip = 'Specifies the value of the Column 4 field.';
                }
                field("Column 5"; Rec."Column 5")
                {
                    ToolTip = 'Specifies the value of the Column 5 field.';
                }
                field("Column 6"; Rec."Column 6")
                {
                    ToolTip = 'Specifies the value of the Column 6 field.';
                }
                field("Column 7"; Rec."Column 7")
                {
                    ToolTip = 'Specifies the value of the Column 7 field.';
                }
                field("Column 8"; Rec."Column 8")
                {
                    ToolTip = 'Specifies the value of the Column 8 field.';
                }
                field("Column 9"; Rec."Column 9")
                {
                    ToolTip = 'Specifies the value of the Column 9 field.';
                }
                field("Column 10"; Rec."Column 10")
                {
                    ToolTip = 'Specifies the value of the Column 10 field.';
                }
                field("Column 11"; Rec."Column 11")
                {
                    ToolTip = 'Specifies the value of the Column 11 field.';
                }
                field("Column 12"; Rec."Column 12")
                {
                    ToolTip = 'Specifies the value of the Column 12 field.';
                }
                field("Column 13"; Rec."Column 13")
                {
                    ToolTip = 'Specifies the value of the Column 13 field.';
                }
                field("Column 14"; Rec."Column 14")
                {
                    ToolTip = 'Specifies the value of the Column 14 field.';
                }
                field("Column 15"; Rec."Column 15")
                {
                    ToolTip = 'Specifies the value of the Column 15 field.';
                }
                field("Column 16"; Rec."Column 16")
                {
                    ToolTip = 'Specifies the value of the Column 16 field.';
                }
                field("Column 17"; Rec."Column 17")
                {
                    ToolTip = 'Specifies the value of the Column 17 field.';
                }
                field("Column 18"; Rec."Column 18")
                {
                    ToolTip = 'Specifies the value of the Column 18 field.';
                }
                field("Column 19"; Rec."Column 19")
                {
                    ToolTip = 'Specifies the value of the Column 19 field.';
                }
                field(Exported; Rec.Exported)
                {
                    ToolTip = 'Specifies the value of the Exported field.', Comment = '%';
                }
                field("SAP Register No."; Rec."SAP Register No.")
                {
                    ToolTip = 'Specifies the value of the SAP Register No. field.', Comment = '%';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.', Comment = '%';
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
            action("View Lines")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = AllLines;
                trigger OnAction()
                var
                    TTSStaging: Record "TTS Unsummarised Lines";
                begin
                    if Rec."Credit Entry No." <> 0 then
                        TTSStaging.SetRange("Credit Entry No.", Rec."Credit Entry No.");
                    if Rec."Debit Entry No." <> 0 then
                        TTSStaging.SetRange("Debit Entry No.", Rec."Debit Entry No.");
                    Page.Run(page::"Processed TTS Entries", TTSStaging);
                end;
            }
            action("View All Lines")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = AllLines;
                trigger OnAction()
                var
                    TTSStaging: Record "TTS Unsummarised Lines";
                begin
                    TTSStaging.SetRange("SAP Register No.", Rec."SAP Register No.");
                    Page.Run(page::"Processed TTS Entries", TTSStaging);

                end;
            }
            action(ExportSelectedSAPSummary)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ExportFile;
                Caption = 'Export Selected Journal';
                ToolTip = 'Executes the Export TTS SAP Summary action.';

                trigger OnAction()
                var
                    SAPSummaryExport: Codeunit "Export SAP Summary";
                    SelectedSummary: Record "SAP Journal";
                begin
                    if Confirm('Do you want to export the selected records?') then begin
                        Clear(SAPSummaryExport);
                        CurrPage.SetSelectionFilter(SelectedSummary);
                        SAPSummaryExport.SetSelectedSummary(SelectedSummary);
                        SAPSummaryExport.ExportSummaryCSV(Enum::Type::LOB, Enum::"Summary Export Type"::Selected, 0);
                    end;
                end;
            }
            action(ExportALLSAPSummary)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ExportFile;
                Caption = 'Export All Journal';
                ToolTip = 'Executes the Export TTS SAP Summary action.';

                trigger OnAction()
                var
                    SAPSummaryExport: Codeunit "Export SAP Summary";
                begin
                    if Confirm('Do you want to export all the records?') then begin
                        Clear(SAPSummaryExport);
                        SAPSummaryExport.ExportSummaryCSV(Enum::Type::LOB, Enum::"Summary Export Type"::All, 0);
                    end;
                end;
            }
            action(Undo)
            {
                Caption = 'Undo Entries';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Undo;
                trigger OnAction()
                var
                    SAPJournal: Record "SAP Journal";
                begin
                    if not Confirm('Do you want to proceed with reversing this journal entry?') then
                        exit;

                    //Reverse Credit Entry from Debit     
                    if Rec."Credit Entry No." <> 0 then
                        ReverseCreditEntryFromDebitLine();

                    //Reverse Credit Entry from credit
                    if rec."Debit Entry No." <> 0 then
                        ReverseDebitEntryFromCreditLine();

                end;
            }
        }
    }

    local procedure ReverseCreditEntryFromDebitLine()
    var
        TTStaging: Record "TTS Unsummarised Lines";
        TTS: Record TTS_SAP;
        SAPJournal: Record "SAP Journal";
    begin
        TTStaging.Reset();
        TTStaging.SetRange("Credit Entry No.", Rec."Credit Entry No.");
        TTStaging.SetLoadFields("Staging Entry No.");
        if TTStaging.FindSet(false) then begin
            repeat
                tts.Reset();
                tts.SetRange("Entry No.", TTStaging."Staging Entry No.");
                if TTS.FindFirst() then begin
                    TTS."SAP Register No." := 0;
                    TTS."Credit Acc No." := '';
                    TTS."Debit Acc No." := '';
                    TTS.Posted := false;
                    TTS.Modify(false);
                end;
            until TTStaging.Next() = 0;

            SAPJournal.Reset();
            SAPJournal.SetRange("Entry No.", Rec."Credit Entry No.");
            if SAPJournal.FindFirst() then begin
                SAPJournal.Reversed := true;
                SAPJournal.Modify(false);
            end;

            TTStaging.Reset();
            TTStaging.SetRange("Debit Entry No.", Rec."Entry No.");
            TTStaging.SetLoadFields("Staging Entry No.");
            if TTStaging.FindSet(false) then
                repeat
                    tts.Reset();
                    tts.SetRange("Entry No.", TTStaging."Staging Entry No.");
                    if TTS.FindFirst() then begin
                        TTS."SAP Register No." := 0;
                        TTS."Credit Acc No." := '';
                        TTS."Debit Acc No." := '';
                        TTS.Posted := false;
                        TTS.Modify(false);
                    end;
                until TTStaging.Next() = 0;
            rec.Reversed := true;
            rec.Modify();
        end;
    end;

    local procedure ReverseDebitEntryFromCreditLine()
    var
        TTStaging: Record "TTS Unsummarised Lines";
        TTS: Record TTS_SAP;
        SAPJournal: Record "SAP Journal";
    begin
        TTStaging.Reset();
        TTStaging.SetRange("Debit Entry No.", Rec."Debit Entry No.");
        TTStaging.SetLoadFields("Staging Entry No.");
        if TTStaging.FindSet(false) then begin
            repeat
                tts.Reset();
                tts.SetRange("Entry No.", TTStaging."Staging Entry No.");
                if TTS.FindFirst() then begin
                    TTS."SAP Register No." := 0;
                    TTS."Credit Acc No." := '';
                    TTS."Debit Acc No." := '';
                    TTS.Posted := false;
                    TTS.Modify(false);
                end;
            until TTStaging.Next() = 0;

            SAPJournal.Reset();
            SAPJournal.SetRange("Entry No.", Rec."Debit Entry No.");
            if SAPJournal.FindFirst() then begin
                SAPJournal.Reversed := true;
                SAPJournal.Modify(false);
            end;

            TTStaging.Reset();
            TTStaging.SetRange("Credit Entry No.", Rec."Entry No.");
            TTStaging.SetLoadFields("Staging Entry No.");
            if TTStaging.FindSet(false) then
                repeat
                    tts.Reset();
                    tts.SetRange("Entry No.", TTStaging."Staging Entry No.");
                    if TTS.FindFirst() then begin
                        TTS."SAP Register No." := 0;
                        TTS."Credit Acc No." := '';
                        TTS."Debit Acc No." := '';
                        TTS.Posted := false;
                        TTS.Modify(false);
                    end;
                until TTStaging.Next() = 0;
            rec.Reversed := true;
            rec.Modify(false);
        end;
    end;
}
page 85032 "TTS-ARAP TTS_ARAP Matching"
{
    PageType = ListPart;
    SourceTable = TTS_ARAP;
    Caption = 'ARAP (CPMS)';
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(Scheme; Rec.Scheme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scheme field.';
                }
                field(Activity; Rec.Activity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity field.';
                }
                field(ReceiptNumber; Rec.ReceiptNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Number field.';
                }
                field(ReceiptAmount; Rec.ReceiptAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                }
                field(InvoiceNumber; Rec.InvoiceNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Number field.';
                }
                field("LOB Matching Status"; Rec."LOB Matching Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LOB Matching Status field.';
                }
                field("LOB Matching ID"; Rec."LOB Matching ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LOB Matching ID field.';
                }
                field("LOB Match Type"; Rec."LOB Match Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LOB Match Type field.';
                }
                field("LOB Matched By"; Rec."LOB Matched By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LOB Matched By field.';
                }
            }
        }
    }
    
    procedure GetSelectedRecords(var SelectedTTSARAP: Record TTS_ARAP temporary)
    var
        TTSARAP: Record TTS_ARAP;
    begin
        CurrPage.SetSelectionFilter(TTSARAP);
        if TTSARAP.FindSet() then
            repeat
                SelectedTTSARAP := TTSARAP;
                SelectedTTSARAP.Insert();
            until TTSARAP.Next() = 0;
    end;
    
    procedure ToggleMatchedFilter(ShowUnmatched: Boolean)
    begin
        Rec.SetRange("LOB Matching Status");
        if ShowUnmatched then
            Rec.SetRange("LOB Matching Status", Rec."LOB Matching Status"::Unmatched);
        CurrPage.Update();
    end;
    
    procedure ShowErroredRecord()
    begin
        Rec.SetRange("LOB Matching Status");
        Rec.SetRange("LOB Matching Status", Rec."LOB Matching Status"::Error);
        CurrPage.Update();
    end;
    
    procedure ShowMatchedRecord()
    begin
        Rec.SetRange("LOB Matching Status");
        Rec.SetRange("LOB Matching Status", Rec."LOB Matching Status"::Matched);
        CurrPage.Update();
    end;
    
    procedure SetSchemeFilter(Scheme: Code[20])
    begin
        Rec.FilterGroup(2);
        Rec.SetRange(Scheme, Scheme);
        Rec.SetRange(Activity, 'PAYMENT');
        Rec.FilterGroup(0);
        CurrPage.Update();
    end;
}

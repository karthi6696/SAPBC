page 85031 "TTS-ARAP TTS_SAP Matching"
{
    PageType = ListPart;
    SourceTable = TTS_SAP;
    Caption = 'TTS (LOB)';
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
                field(PaymentReference; Rec.PaymentReference)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Reference field.';
                }
                field(TestCostWithoutVat; Rec.TestCostWithoutVat)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Cost Without VAT field.';
                }
                field(InvoiceNumber; Rec.InvoiceNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Number field.';
                }
                field("Matching Status"; Rec."Matching Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Matching Status field.';
                }
                field("Matching ID"; Rec."Matching ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Matching ID field.';
                }
                field("Match Type"; Rec."Match Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Match Type field.';
                }
                field("Matched By"; Rec."Matched By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Matched By field.';
                }
            }
        }
    }
    
    procedure GetSelectedRecords(var SelectedTTSSAP: Record TTS_SAP temporary)
    var
        TTSSAP: Record TTS_SAP;
    begin
        CurrPage.SetSelectionFilter(TTSSAP);
        if TTSSAP.FindSet() then
            repeat
                SelectedTTSSAP := TTSSAP;
                SelectedTTSSAP.Insert();
            until TTSSAP.Next() = 0;
    end;
    
    procedure ToggleMatchedFilter(ShowUnmatched: Boolean)
    begin
        Rec.SetRange("Matching Status");
        if ShowUnmatched then
            Rec.SetRange("Matching Status", Rec."Matching Status"::Unmatched)
        else
            Rec.SetRange("Matching Status");
        CurrPage.Update();
    end;
    
    procedure ShowErroredRecord()
    begin
        Rec.SetRange("Matching Status");
        Rec.SetRange("Matching Status", Rec."Matching Status"::Error);
        CurrPage.Update();
    end;
    
    procedure ShowMatchedRecord()
    begin
        Rec.SetRange("Matching Status");
        Rec.SetRange("Matching Status", Rec."Matching Status"::Matched);
        CurrPage.Update();
    end;
    
    procedure SetSchemeFilter(Scheme: Code[20])
    begin
        Rec.FilterGroup(2);
        Rec.SetRange(Scheme, Scheme);
        Rec.SetRange(Activity, 'INVOICE');
        Rec.FilterGroup(0);
        CurrPage.Update();
    end;
}

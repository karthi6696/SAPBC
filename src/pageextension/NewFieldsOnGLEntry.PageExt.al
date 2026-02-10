pageextension 85001 NewFieldsOnGLEntry extends "General Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(processing)
        {
            action(View_Integration)
            {
                ApplicationArea = All;
                Image = InteractionLog;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'View Integration Record';
                Visible = false;
                trigger OnAction()
                var
                    TTS_SAP: record TTS_SAP;
                    TTS_ARAP: record TTS_ARAP;
                begin
                    // TTS SAP
                    if Rec."Integration Type" = Rec."Integration Type"::"TTS SAP" then begin
                        TTS_SAP.Reset();
                        TTS_SAP.SetRange(FinanceSapId, Rec."Integration Id");
                        if TTS_SAP.FindFirst() then
                            Page.Run(Page::"Processed TTS Entries", TTS_SAP);
                    end;
                    // TTS ARAP
                    if Rec."Integration Type" = Rec."Integration Type"::"TTS ARAP" then begin
                        TTS_ARAP.Reset();
                        TTS_ARAP.SetRange(FinanceArapID, Rec."Integration Id");
                        if TTS_ARAP.FindFirst() then
                            Page.Run(Page::"Processed CPMS Entries", TTS_ARAP);
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}
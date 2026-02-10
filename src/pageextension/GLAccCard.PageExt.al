pageextension 85010 GLAccCard extends "G/L Account Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Hide DVSA_9999"; Rec."Hide DVSA_9999")
            {
                ApplicationArea = All;
                Caption = 'Hide DVSA_9999';
                ToolTip = 'Specifies the value of the Hide DVSA_9999 field.';
            }
        }
    }
}

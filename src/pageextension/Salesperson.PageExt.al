pageextension 85009 Salesperson extends "Salesperson/Purchaser Card"
{
    layout
    {
        addafter(Blocked)
        {

            field("Ignore Payment Ref"; Rec."Ignore Payment Ref")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ignore Payment Ref in TTS field.', Comment = '%';
            }
        }
    }
}

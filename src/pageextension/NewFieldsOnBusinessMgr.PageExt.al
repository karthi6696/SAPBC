pageextension 85002 NewFieldsOnBusinessMgr extends "Business Manager Role Center"
{
    layout
    {
        addafter(Control16)
        {
            part("DVSA_Integration_Activities"; "DVSA_Integration_Activities")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
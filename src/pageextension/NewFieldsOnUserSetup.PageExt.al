pageextension 85003 NewFieldsOnUserSetup extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {

            field("Integration Admin"; Rec."Integration Admin")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Integration Admin field.', Comment = '%';
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
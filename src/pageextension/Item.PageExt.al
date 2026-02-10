pageextension 85004 Item extends "Item Card"
{
    layout
    {
        addafter(Description)
        {

            field("SAP Chart of Account"; Rec."SAP Chart of Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SAP Chart of Account field.', Comment = '%';
            }
        }
    }
}

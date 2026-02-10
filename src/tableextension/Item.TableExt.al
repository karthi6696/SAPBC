tableextension 85004 Item extends Item
{
    fields
    {
        field(85000; "SAP Chart of Account"; Code[20])
        {
            Caption = 'SAP Chart of Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No.";
        }
    }
}

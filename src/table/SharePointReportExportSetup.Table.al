table 85019 "SharePoint Report Export Setup"
{
    Caption = 'SharePoint Report Export Setup';

    fields
    {
        field(1; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = filter(Report));
        }
        field(2; "Report Name"; Text[250])
        {
            Caption = 'Report Name';
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object ID" = field("Report ID"), "Object Type" = filter(Report)));
            Editable = false;
        }
        field(3; "SharePoint Export"; Boolean)
        {
            Caption = 'SharePoint Export';
        }
        field(4; "Email Notification"; Boolean)
        {
            Caption = 'Email Notification';
        }
    }
    keys
    {
        key(PK; "Report ID")
        {
            Clustered = true;
        }
    }
}

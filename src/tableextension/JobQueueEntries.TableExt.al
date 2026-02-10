tableextension 85006 "Job Queue Entries" extends "Job Queue Entry"
{
    fields
    {
        field(85000; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = filter(Report), "Object ID" = filter(> 50000));
            BlankZero = true;
            trigger OnValidate()
            begin
                Rec.SharePoint := true;
                Rec.Validate("Object Type to Run", Rec."Object Type to Run"::Codeunit);
                Rec.Validate("Object ID to Run", 85011);
            end;
        }
        field(85001; "Report Name"; Text[250])
        {
            Caption = 'Report Name';
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = filter(Report),
                                                                           "Object ID" = field("Report ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85002; "SharePoint"; Boolean)
        {

        }
    }
}

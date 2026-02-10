table 85007 "SAP_Summary_Register"
{
    DrillDownPageId = SAP_Summary_Register;
    LookupPageId = SAP_Summary_Register;
    Caption = 'SAP Summary Register';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Date';
        }
        field(3; Scheme; Text[100])
        {
            Caption = 'Scheme';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("SAP Journal"."Column 1" where("Entry No." = field("From Entry No.")));
        }
        field(4; "From Entry No."; Integer)
        {
            Caption = 'From Entry No.';
        }
        field(5; "To Entry No."; Integer)
        {
            Caption = 'To Entry No.';
        }
        field(6; "Type"; Enum Type)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        SAPSummaryReg: Record SAP_Summary_Register;
    begin
        SAPSummaryReg.Reset();
        if SAPSummaryReg.FindLast() then
            "Entry No." := SAPSummaryReg."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
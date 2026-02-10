table 85003 "Integration_Errors"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Record Type"; Enum Type)
        {
            DataClassification = ToBeClassified;
            Caption = 'Record Type';
        }
        field(2; "Record Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Record Entry No.';
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
        }
        field(4; "Error Message"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Error Message';
        }
    }

    keys
    {
        key(Key1; "Record Type", "Record Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        IntegrationErrors: Record Integration_Errors;
    begin

        IntegrationErrors.reset();
        IntegrationErrors.setrange("Record Type", rec."Record Type");
        IntegrationErrors.setrange("Record Entry No.", Rec."Record Entry No.");
        If IntegrationErrors.FindLast() then
            "Line No." := IntegrationErrors."Line No." + 1000
        else
            "Line No." := 1000;
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
tableextension 85000 NewFieldsOnGenJnlLine extends "Gen. Journal Line"
{
    fields
    {
        field(85000; "Integration Id"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(85001; "Integration Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "TTS SAP","TTS ARAP";
            Caption = 'Integration Type';
            trigger OnValidate()
            begin

            end;
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

}
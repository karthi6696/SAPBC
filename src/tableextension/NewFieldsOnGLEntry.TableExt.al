tableextension 85002 NewFieldsOnGLEntry extends "G/L Entry"
{
    fields
    {
        field(85000; "Integration Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(85001; "Integration Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "TTS SAP","TTS ARAP";
            Caption = 'Integration Type';
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
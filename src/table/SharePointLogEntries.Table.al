table 85018 "SharePoint Log Entries"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Schedule ID"; Guid)
        {

        }
        field(3; Direction; Option)
        {
            OptionMembers = ,Import,Export;
            Caption = 'Direction';
        }
        field(4; "File Name"; Text[2048])
        {
            Caption = 'File Name';
        }
        field(5; "Message"; Text[2048])
        {
            Caption = 'Message';
        }
        field(6; Status; Enum "ABS Status")
        {
            Caption = 'Status';
        }
        field(7; Report; blob)
        {

        }
        field(8; "Exported to SP"; Boolean)
        {
        }
        field(9; "SharePoint Link"; Text[2000])
        {
            ExtendedDatatype = URL;
        }
        field(10; "Odata ID"; Text[250])
        {
            Caption = 'Odata ID';
        }
        field(11; "Report Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    // trigger OnInsert()
    // begin
    //     Rec."Entry No." := GetLastEntryNo() + 1;
    // end;

    // procedure GetLastEntryNo(): Integer;
    // var
    //     FindRecordManagement: Codeunit "Find Record Management";
    // begin
    //     exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    // end;

}

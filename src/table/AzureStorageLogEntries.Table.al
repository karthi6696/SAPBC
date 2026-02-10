table 85014 "Azure Storage Log Entries"
{
    Caption = 'Azure Storage Log Entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "File"; Media)
        {
            Caption = 'File';
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
        field(8; "Parent Folder"; Text[2000])
        {
        }
        field(9; "Sub Folder"; Text[2000])
        {
        }
        field(10; "File Address"; Text[2000])
        {

        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Rec."Entry No." := GetLastEntryNo() + 1;
    end;

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;

}

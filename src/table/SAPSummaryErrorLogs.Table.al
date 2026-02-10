table 85012 "SAP Summary Error Logs"
{
    Caption = 'SAP Summary Error Logs';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Type"; Enum "Type")
        {
            Caption = 'Type';
        }
        field(3; Message; Text[1000])
        {
            Caption = 'Message';
        }
        field(4; "Summary Entry No."; Blob)
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
}

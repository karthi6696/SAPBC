table 85006 "SAP Journal"
{
    Caption = 'SAP Journal';

    fields
    {
        field(1; "Entry No."; Integer)
        {

        }
        field(2; "Column 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Column 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Column 3"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Column 4"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Column 5"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Column 6"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Column 7"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Column 8"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Column 9"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Column 10"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Column 11"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Column 12"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Column 13"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Column 14"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Column 15"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Column 16"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Column 17"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Column 18"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Column 19"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(85000; Scheme; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(85001; Country; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(85002; Activity; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(85003; Product; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(85004; Salesperson; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(85005; Debit; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85006; "Line Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85007; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(85008; "Record Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(85009; Exported; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85010; "Type"; Enum Type)
        {

        }
        field(85011; "SAP Register No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'SAP Register No.';
        }
        field(85012; "Credit Entry No."; Integer)
        {
        }
        field(85013; "SAP Mapping ID"; Guid)
        {
        }
        field(85014; "Selected Entries"; Text[1024])
        {

        }
        field(85015; "Reversed"; Boolean)
        {
        }
        field(85016; "Debit Entry No."; Integer)
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



    trigger OnInsert()
    var
        SAPSummary: Record "SAP Journal";
    begin
        SAPSummary.Reset();
        if SAPSummary.FindLast() then
            "Entry No." := SAPSummary."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        TTSUnSummarisedLines: Record "TTS Unsummarised Lines";
        CPMSUnSummarisedLines: Record "CPMS Unsummarised Lines";
    begin
        case true of
            rec.type = rec.type::LOB:
                begin
                    TTSUnSummarisedLines.Reset();
                    TTSUnSummarisedLines.FilterGroup(-1);
                    TTSUnSummarisedLines.SetRange("Credit Entry No.", Rec."Entry No.");
                    TTSUnSummarisedLines.SetRange("Debit Entry No.", Rec."Entry No.");
                    TTSUnSummarisedLines.DeleteAll();
                end;
            Rec.Type = rec.Type::CPMS:
                begin
                    CPMSUnSummarisedLines.Reset();
                    CPMSUnSummarisedLines.FilterGroup(-1);
                    CPMSUnSummarisedLines.SetRange("Credit Entry No.", Rec."Entry No.");
                    CPMSUnSummarisedLines.SetRange("Debit Entry No.", Rec."Entry No.");
                    CPMSUnSummarisedLines.DeleteAll();
                end;
        end;
    end;

    trigger OnRename()
    begin

    end;

}
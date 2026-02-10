table 85009 "EOD Staging"
{
    LookupPageId = "EOD Staging";
    DrillDownPageId = "EOD Staging";
    Caption = 'EOD';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Unique Trans Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Transaction Type"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Reference Number"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Reference Number 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Fund Code"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Pay Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Transaction Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Pay Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Issue Number"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Last 4 Card Digits"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Card Transaction Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Surname"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Card Long Number"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Secure Transaction Id"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Auth Code"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Narrative"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Payment Reference"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Site ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Alternate Fund Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Alternate Pay Code"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Transaction Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Record Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Process Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Process Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "User Code"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Matching Status"; Option)
        {
            OptionMembers = Matched,Unmatched,Error,;
            OptionCaption = 'Matched,Unmatched,Error';
            InitValue = Unmatched;
            trigger OnValidate()
            begin
                if Rec."Matching Status" = Rec."Matching Status"::Unmatched then begin
                    Clear("Matching ID");
                    Clear("Matching Processed Date Time");
                    Clear("Match Details");
                    Clear("Match Type");
                    Clear("Matched By");
                    Modify();
                end;
            end;
        }
        field(32; "Matching ID"; code[20])
        {

        }
        field(33; "Matching Processed Date Time"; DateTime)
        {

        }
        field(34; "Rule No."; Integer)
        {

        }
        field(35; "Match Details"; Text[1000])
        {

        }
        field(36; "Matched By"; Text[100])
        {
        }
        field(37; "Match Type"; Enum "Match Type")
        {

        }
        // field(39; "Errored"; Boolean)
        // {
        // }
        field(40; "Error Exists"; Boolean)
        {
            Fieldclass = flowfield;
            calcformula = exist(Integration_Errors where("Record Type" = filter(EOD), "Record Entry No." = field("Entry No.")));
        }
        field(41; "Synapse Error"; Boolean)
        {
        }
        field(42; "Synapse Error Description"; Text[250])
        {
        }
        field(43; "Source Identifier"; text[100])
        {
        }
        field(44; "Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Matching Status", "Matching Processed Date Time")
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;


    trigger OnInsert()
    begin

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
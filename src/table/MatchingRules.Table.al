table 85010 "Matching Rules"
{
    Caption = 'Matching Rules';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Scheme; Code[20])
        {
            Caption = 'Scheme';
        }
        field(2; "Matching Type"; Option)
        {
            Caption = 'Matching Type';
            OptionMembers = "CPMS-LOB","CPMS-EOD";
            OptionCaption = 'CPMS-LOB,CPMS-EOD';
            trigger OnValidate()
            begin
                case true of
                    Rec."Matching Type" = Rec."Matching Type"::"CPMS-LOB":
                        if (Rec."EOD Condition" <> '') or (Rec."EOD Field No." <> 0) or (Rec."EOD Filter" <> '') then
                            Error('Please clear the values from the following fields: %1 and %2', Rec.FieldCaption("EOD Condition"), Rec.FieldCaption("EOD Field Name"));
                    Rec."Matching Type" = Rec."Matching Type"::"CPMS-EOD":
                        if (Rec."LOB Condition" <> '') or (Rec."LOB Field No." <> 0) or (Rec."LOB Filter" <> '') then
                            Error('Please clear the values from the following fields: %1 and %2', Rec.FieldCaption("LOB Condition"), Rec.FieldCaption("LOB Field Name"));
                end;

            end;
        }
        field(3; "LOB Field Name"; Text[100])
        {
            Caption = 'Matching LOB Field';
            trigger OnLookup()
            var
                FieldLookup: Record Field;
                ParentMatchingRule: Record "Matching Rules";
            begin
                if Rec."Matching Type" = Rec."Matching Type"::"CPMS-EOD" then
                    Error('');

                FieldLookup.SetRange(TableNo, Database::TTS_SAP);
                if Page.RunModal(Page::"Fields Lookup", FieldLookup) = Action::LookupOK then begin
                    "LOB Field No." := FieldLookup."No.";
                    "LOB Field Name" := FieldLookup.FieldName;
                    if Rec."Parent Condition No." = 0 then
                        Rec."LOB Condition" := Rec."LOB Condition".Replace('Entry No.', Rec."LOB Field Name")
                    else begin
                        ParentMatchingRule.SetRange("Matching Rule No.", Rec."Parent Condition No.");
                        ParentMatchingRule.FindFirst();
                        Rec."LOB Condition" := Rec."LOB Condition".Replace('Entry No.', ParentMatchingRule."LOB Field Name")
                    end;
                end;
            end;

            // trigger OnValidate()
            // begin
            //     if (Rec."LOB Condition" <> '') and (Rec."LOB Condition".Contains('Entry No.')) then
            //         Rec."LOB Condition" := Rec."LOB Condition".Replace('Entry No.', Rec."LOB Field Name")
            // end;
        }
        field(4; "LOB Field No."; Integer)
        {
            Caption = 'LOB Field No.';
        }
        field(5; "CPMS Field Name"; Text[100])
        {
            Caption = 'Matching CPMS Field';
            trigger OnLookup()
            var
                FieldLookup: Record Field;
                ParentMatchingRule: Record "Matching Rules";
            begin
                FieldLookup.SetRange(TableNo, Database::TTS_ARAP);
                if Page.RunModal(Page::"Fields Lookup", FieldLookup) = Action::LookupOK then begin
                    "CPMS Field No." := FieldLookup."No.";
                    "CPMS Field Name" := FieldLookup.FieldName;
                    if Rec."Parent Condition No." = 0 then
                        Rec."CPMS Condition" := Rec."CPMS Condition".Replace('Entry No.', Rec."CPMS Field Name")
                    else begin
                        ParentMatchingRule.SetRange("Matching Rule No.", Rec."Parent Condition No.");
                        ParentMatchingRule.FindFirst();
                        Rec."CPMS Condition" := Rec."CPMS Condition".Replace('Entry No.', ParentMatchingRule."CPMS Field Name")
                    end;
                end;
            end;

            // trigger OnValidate()
            // begin
            //     if (Rec."CPMS Condition" <> '') and (Rec."CPMS Condition".Contains('Entry No.')) then
            //         Rec."CPMS Condition" := Rec."CPMS Condition".Replace('Entry No.', Rec."CPMS Field Name")
            // end;
        }
        field(6; "CPMS Field No."; Integer)
        {
            Caption = 'CPMS Field No.';
        }
        field(7; "LOB Filter"; Text[200])
        {
            Caption = 'LOB Filter';
        }
        field(8; "CPMS Filter"; Text[200])
        {
            Caption = 'CPMS Filter';
        }
        field(9; "EOD Field Name"; Text[100])
        {
            Caption = 'Matching EOD Field';
            trigger OnLookup()
            var
                FieldLookup: Record Field;
                ParentMatchingRule: Record "Matching Rules";

            begin
                if Rec."Matching Type" = Rec."Matching Type"::"CPMS-LOB" then
                    Error('');
                FieldLookup.SetRange(TableNo, Database::"EOD Staging");
                if Page.RunModal(Page::"Fields Lookup", FieldLookup) = Action::LookupOK then begin
                    "EOD Field No." := FieldLookup."No.";
                    "EOD Field Name" := FieldLookup.FieldName;
                    if Rec."Parent Condition No." = 0 then
                        Rec."EOD Condition" := Rec."EOD Condition".Replace('Entry No.', Rec."EOD Field Name")
                    else begin
                        ParentMatchingRule.SetRange("Matching Rule No.", Rec."Parent Condition No.");
                        ParentMatchingRule.FindFirst();
                        Rec."EOD Condition" := Rec."EOD Condition".Replace('Entry No.', ParentMatchingRule."EOD Field Name")
                    end;
                end;
            end;

            // trigger OnValidate()
            // begin
            //     if (Rec."EOD Condition" <> '') and (Rec."EOD Condition".Contains('Entry No.')) then
            //         Rec."EOD Condition" := Rec."EOD Condition".Replace('Entry No.', Rec."EOD Field Name")
            // end;
        }
        field(10; "EOD Field No."; Integer)
        {
            Caption = 'EOD Field No.';
        }
        field(11; "EOD Filter"; Text[200])
        {
            Caption = 'EOD Filter';
        }
        field(12; "LOB Condition"; Text[1000])
        {
            DataClassification = CustomerContent;
        }
        field(13; "CPMS Condition"; Text[1000])
        {
            DataClassification = CustomerContent;
        }
        field(14; "EOD Condition"; Text[1000])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Matching Rule No."; Integer)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(16; "Parent Condition No."; Integer)
        {
            BlankZero = true;
        }
    }
    keys
    {
        key(PK; "Matching Rule No.", "Matching Type", Scheme, "LOB Field No.", "CPMS Field No.", "EOD Field No.")
        {
            Clustered = true;
        }
        key(Rule; "Matching Rule No.")
        {

        }
    }
}

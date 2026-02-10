table 85008 "DVSA_Activities"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "TTS SAP"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(TTS_SAP);
            Caption = 'LOB';
        }
        field(3; "TTS ARAP"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(TTS_ARAP);
            Caption = 'CPMS';
        }
        field(4; "EOD"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("EOD Staging");
        }
        field(5; "SAP Registers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(SAP_Summary_Register);
            Caption = 'SAP Registers';
        }
        field(6; "SAP Registers TTS"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(SAP_Summary_Register where("Type" = filter(LOB)));
            Caption = 'SAP LOB Registers';
        }
        field(7; "SAP Registers CPMS"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(SAP_Summary_Register where("Type" = filter(CPMS)));
            Caption = 'SAP CPMS Registers';
        }
        field(8; "Error EOD"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("EOD Staging" where("Matching Status" = filter(Error)));
            Caption = 'EOD';
        }
        field(9; "Force EOD"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("EOD Staging" where("Match Type" = filter(Force)));
            Caption = 'EOD';
        }
        field(10; "Matched EOD"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("EOD Staging" where("Matching Status" = filter(Matched)));
        }
        field(11; "Unmatched EOD"; Integer)
        {
            Caption = 'EOD';
            FieldClass = FlowField;
            CalcFormula = count("EOD Staging" where("Matching Status" = filter(UnMatched)));
        }
        field(12; "Synapse TTS Error"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(TTS_SAP where("Synapse Error" = filter(true)));
        }
        field(13; "Synapse CPMS Error"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(TTS_ARAP where("Synapse Error" = filter(true)));
        }
        field(14; "Synapse EOD Error"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("EOD Staging" where("Synapse Error" = filter(true)));
        }
        field(15; "Validation TTS Error"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(TTS_SAP where("Error Exists" = filter(true)));
        }
        field(16; "Validation CPMS Error"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(TTS_ARAP where("Error Exists" = filter(true)));
        }
        field(17; "Validation EOD Error"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("EOD Staging" where("Error Exists" = filter(true)));
        }
        field(18; "Processed TTS Journal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(TTS_SAP where(Posted = filter(true)));
        }
        field(19; "Unprocessed TTS Journal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(TTS_SAP where(Posted = filter(false)));
        }
        field(20; "Processed CPMS Journal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(TTS_ARAP where(Posted = filter(true)));
        }
        field(21; "Unprocessed CPMS Journal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(TTS_ARAP where(Posted = filter(false)));
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
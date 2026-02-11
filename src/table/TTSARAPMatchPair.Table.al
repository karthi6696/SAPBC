table 85020 "TTS-ARAP Match Pair"
{
    TableType = Temporary;
    
    fields
    {
        field(1; "Reference Key"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Source Type"; Option)
        {
            OptionMembers = TTS_SAP,TTS_ARAP;
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(Key1; "Reference Key")
        {
            Clustered = true;
        }
    }
}

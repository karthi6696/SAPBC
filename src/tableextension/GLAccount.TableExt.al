tableextension 85008 GLAccount extends "G/L Account"
{
    fields
    {
        field(85000; "Hide DVSA_9999"; Boolean)
        {
            Caption = 'Hide DVSA_9999';
            DataClassification = ToBeClassified;
        }
    }
}

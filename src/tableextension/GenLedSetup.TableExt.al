tableextension 85005 GenLedSetup extends "General Ledger Setup"
{
    fields
    {
        field(85000; "LOB-CPMS Matching No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(85001; "LOB-CPMS Error No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(85002; "EOD-CPMS Matching No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(85003; "EOD-CPMS Error No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
    }
}

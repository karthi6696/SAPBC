pageextension 85006 GenLedSetup extends "General Ledger Setup"
{
    layout
    {
        addafter("App. Dimension Posting")
        {

            field("LOB-CPMS Matching No. Series"; Rec."LOB-CPMS Matching No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LOB-CPMS Matching No. Series field.', Comment = '%';
            }
            field("LOB-CPMS Error No. Series"; Rec."LOB-CPMS Error No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LOB-CPMS Error No. Series field.', Comment = '%';
            }
            field("EOD-CPMS Matching No. Series"; Rec."EOD-CPMS Matching No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the EOD-CPMS Matching No. Series field.', Comment = '%';
            }
            field("EOD-CPMS Error No. Series"; Rec."EOD-CPMS Error No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the EOD-CPMS Error No. Series field.', Comment = '%';
            }
        }
    }
}

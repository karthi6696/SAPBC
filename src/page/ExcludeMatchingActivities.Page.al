page 85036 "Exclude Matching Activities"
{
    ApplicationArea = All;
    Caption = 'Exclude Matching Activities';
    PageType = List;
    SourceTable = "Exclude Matching Activities";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Scheme Code"; Rec."Scheme Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = '%';
                }
                field("LOB Activity"; Rec."LOB Activity")
                {
                    ToolTip = 'Specifies the value of the LOB Activity field.', Comment = '%';
                }
                field("LOB-CPMS Activity"; Rec."LOB-CPMS Activity")
                {
                    ToolTip = 'Specifies the value of the LOB-CPMS Activity field.', Comment = '%';
                }
                field("CPMS-EOD Activity"; Rec."CPMS-EOD Activity")
                {
                    ToolTip = 'Specifies the value of the CPMS-EOD Activity field.', Comment = '%';
                }
            }
        }
    }
}

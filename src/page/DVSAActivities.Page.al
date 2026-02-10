page 85011 "DVSA_Activities"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DVSA_Activities;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("TTS SAP"; Rec."TTS SAP")
                {
                }
                field("TTS ARAP"; Rec."TTS ARAP")
                {
                }
                field("SAP Registers"; Rec."SAP Registers")
                {
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}
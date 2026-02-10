page 85003 "Integration_Errors"
{
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = Integration_Errors;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Error Message"; rec."Error Message")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}
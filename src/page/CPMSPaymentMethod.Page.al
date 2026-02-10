page 85015 "CPMS_Payment_Method"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CPMS_Payment_Method;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; Rec.Name) { }
                field(Description; Rec.Description) { }
            }
        }

    }
}
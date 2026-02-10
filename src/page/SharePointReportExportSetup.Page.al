page 85039 "SharePoint Report Export Setup"
{
    ApplicationArea = All;
    Caption = 'SharePoint Export Report Selection';
    PageType = List;
    SourceTable = "SharePoint Report Export Setup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Report ID"; Rec."Report ID")
                {
                    ToolTip = 'Specifies the value of the Report ID field.', Comment = '%';
                }
                field("Report Name"; Rec."Report Name")
                {
                    ToolTip = 'Specifies the value of the Report Name field.', Comment = '%';
                }
                field("SharePoint Export"; Rec."SharePoint Export")
                {
                    ToolTip = 'Specifies the value of the SharePoint Export field.', Comment = '%';
                }
                field("Email Notification"; Rec."Email Notification")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Email Notification field.', Comment = '%';
                }
            }
        }
    }
}

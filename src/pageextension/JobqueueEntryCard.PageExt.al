pageextension 85008 "Job queue Entry Card" extends "Job Queue Entry Card"
{
    layout
    {
        modify("Report Parameters")
        {
            Visible = HideFields;
        }
        modify("Object ID to Run")
        {
            Visible = HideFields;
        }
        modify("Object Type to Run")
        {
            Visible = HideFields;
        }
        modify("Object Caption to Run")
        {
            Visible = HideFields;
        }
        modify(Description)
        {
            Visible = HideFields;
        }
        modify("Parameter String")
        {
            Visible = HideFields;
        }
        modify("Priority Within Category")
        {
            Visible = HideFields;
        }
        addafter("Parameter String")
        {
            field("Report ID"; Rec."Report ID")
            {
                ApplicationArea = all;
                Visible = not HideFields;
                ToolTip = 'Specifies the value of the Report ID field.', Comment = '%';
            }
            field("Report Name"; Rec."Report Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Report Name field.', Comment = '%';
                Visible = not HideFields;
            }
        }

    }

    actions
    {
        addafter(LogEntries)
        {
            action(SPLogEntries)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Log Entries';
                Image = Log;
                RunObject = Page "SharePoint Log Entries";
                RunPageLink = "Schedule ID" = field(ID);
                ToolTip = 'View the SharePoint log entries.';
                Visible = not HideFields;
            }
        }
        modify(LogEntries)
        {
            Visible = HideFields;
        }
    }

    trigger OnOpenPage()
    begin
        HideFields := not Rec.SharePoint;
    end;

    var
        HideFields: Boolean;
}

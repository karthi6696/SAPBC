page 85038 SharePointFiles
{
    APIGroup = 'bcsap';
    APIPublisher = 'dvsa';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    DelayedInsert = true;
    EntityName = 'sharepointfile';
    EntitySetName = 'sharepointfiles';
    PageType = API;
    SourceTable = "SharePoint Log Entries";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(fileName; Rec."File Name")
                {
                    Caption = 'File Name';
                }
                field(direction; Rec.Direction)
                {
                    Caption = 'Direction';
                }
                field("report"; Rec."Report")
                {
                    Caption = 'Report';
                }
                field(message; Rec.Message)
                {
                    Caption = 'Message';
                }
                field(exportedToSP; Rec."Exported to SP")
                {
                    Caption = 'Exported to SP';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(sharePointLink; Rec."SharePoint Link")
                {
                    Caption = 'SharePoint Link';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }


}



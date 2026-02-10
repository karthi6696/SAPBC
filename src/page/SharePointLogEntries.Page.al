page 85040 "SharePoint Log Entries"
{
    ApplicationArea = All;
    Caption = 'SharePoint Log Entries';
    PageType = List;
    SourceTable = "SharePoint Log Entries";
    SourceTableView = sorting("Entry No.") order(descending);
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.', Comment = '%';
                }
                field(Message; Rec.Message)
                {
                    ToolTip = 'Specifies the value of the Message field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Exported At"; Rec.SystemModifiedAt)
                {
                    Caption = 'Exported At';
                }
                field("SharePoint Link"; Rec."SharePoint Link")
                {
                    ToolTip = 'Specifies the value of the SharePoint Link field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Download)
            {
                ApplicationArea = All;
                Caption = 'Download File';
                Image = Download;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Tempblob: Codeunit "Temp Blob";
                    IStream: InStream;
                    FileName: Text;
                begin
                    Rec.CalcFields(Report);
                    if Rec.Report.HasValue then begin
                        Rec.Report.CreateInStream(IStream);
                        DownloadFromStream(IStream, '', '', '', Rec."File Name");
                    end;
                end;
            }
        }
    }
}

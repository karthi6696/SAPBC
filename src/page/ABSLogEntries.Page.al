page 85031 "ABS Log Entries"
{
    ApplicationArea = All;
    Caption = 'ABS Log Entries';
    PageType = List;
    SourceTable = "Azure Storage Log Entries";
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
                }
                field(Direction; Rec.Direction)
                {
                }
                field("File Name"; Rec."File Name")
                {
                }
                field(Message; Rec.Message)
                {
                    ToolTip = 'Specifies the value of the Message field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'Imported Date Time';
                }
                field("File"; Rec."File")
                {
                    ToolTip = 'Specifies the value of the File field.', Comment = '%';
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
                    TenantMedia: Record "Tenant Media";
                    IStream: InStream;
                    FileName: Text;
                begin
                    if TenantMedia.Get(Rec.File.MediaId) then begin
                        TenantMedia.CalcFields(Content);
                        if TenantMedia.Content.HasValue then begin
                            TenantMedia.Content.CreateInStream(IStream);
                            case true of
                                Rec."File Name".Contains('.xml') or Rec."File Name".Contains('.csv'):
                                    DownloadFromStream(IStream, '', '', '', Rec."File Name")
                                else begin
                                    FileName := Rec."File Name" + '.xml';
                                    DownloadFromStream(IStream, '', '', '', FileName)
                                end;
                            end;
                        end;
                    end;
                end;
            }
            action(UploadFile)
            {
                Visible = false;
                trigger OnAction()
                var
                    Path: Text;
                    OStream: OutStream;
                    InStr: InStream;
                begin
                    file.UploadIntoStream('', '', '', Path, InStr);
                    rec.Init();
                    Rec.Report.CreateOutStream(OStream);
                    CopyStream(OStream, InStr);
                    Rec.Insert(true);
                end;
            }
        }
    }

}

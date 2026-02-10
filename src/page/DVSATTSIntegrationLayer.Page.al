page 85025 "DVSA TTS Integration Layer"
{
    PageType = RoleCenter;
    Caption = 'DVSA TTS Integration Layer';

    layout
    {
        area(RoleCenter)
        {
            part(dvsa_Activities; DVSA_Integration_Cues)
            {
                ApplicationArea = All;
            }
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                AccessByPermission = TableData "Power BI Context Settings" = I;
                ApplicationArea = all;
            }
            part(Control96; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        area(Sections)
        {
            group("Line of Business")
            {
                action("TTS Staging")
                {
                    RunObject = Page "TTS Staging";
                    ApplicationArea = Basic, Suite;
                    Caption = 'TTS Staging';
                    Image = Journal;
                }
            }
            group("CPMS")
            {
                action("CPMS Staging")
                {
                    RunObject = Page "CPMS Staging";
                    ApplicationArea = Basic, Suite;
                    Caption = 'CPMS Staging';
                    Image = Journal;
                }
            }
            group("EOD")
            {
                action("EOD Staging")
                {
                    RunObject = Page "EOD Staging";
                    ApplicationArea = Basic, Suite;
                    Caption = 'EOD Staging';
                    Image = Journal;
                }
            }
            group("Matching")
            {
                action("EOD CPMS Matching")
                {
                    RunObject = Page "EOD-CPMS Matching";
                    ApplicationArea = Basic, Suite;
                    Caption = 'EOD CPMS Matching';
                    Image = Journal;
                }
                action("LOB CPMS Matching")
                {
                    RunObject = Page "LOB-CPMS Matching";
                    ApplicationArea = Basic, Suite;
                    Caption = 'LOB CPMS Matching';
                    Image = Journal;
                }
            }
            group(Reports)
            {
                action("Unmatched CPMS EOD")
                {
                    RunObject = report "Unmatched CPMS EOD";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unmatched CPMS EOD';
                    Image = ExportToExcel;
                }
                action("Matched EOD Excel Export")
                {
                    RunObject = Report "Matched CPMS TTS";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Matched CPMS TTS';
                    Image = ExportToExcel;
                }
                action("Unmatched EOD Excel Export")
                {
                    RunObject = Report "Unmatched CPMS TTS";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unmatched CPMS TTS';
                    Image = ExportToExcel;
                }
                action("Matched CPMS EOD by Month")
                {
                    RunObject = report "Matched CPMS EOD";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Matched CPMS EOD';
                    Image = ExportToExcel;
                }
                action("Manually Cleared Items CPMS EOD")
                {
                    RunObject = report "Manually Cleared CPMS EOD";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Manually Cleared Items CPMS EOD';
                    Image = ExportToExcel;
                }
                action(TTSBookedExcelExport)
                {
                    RunObject = report "Booked Not Delivered";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Booked Not Delivered';
                    Image = ExportToExcel;
                }
                action(TTSExport)
                {
                    RunObject = report "TTS Data";
                    ApplicationArea = Basic, Suite;
                    Caption = 'TTS Export';
                    Image = ExportToExcel;
                }
                action(CPMSExport)
                {
                    RunObject = report "CPMS Data";
                    ApplicationArea = Basic, Suite;
                    Caption = 'CPMS Export';
                    Image = ExportToExcel;
                }
                action(EODxport)
                {
                    RunObject = report "EOD Data";
                    ApplicationArea = Basic, Suite;
                    Caption = 'EOD Export';
                    Image = ExportToExcel;
                }
                action("CPMS Export")
                {
                    Caption = 'Bank Clearing CPMS';
                    Image = ExportElectronicDocument;
                    ApplicationArea = All;
                    ToolTip = 'Executes the CPMS Transaction Listing action.';
                    Visible = true;
                    RunObject = codeunit "CPMS Staging Export";
                }
                action("TTS Export")
                {
                    Caption = 'Bank Clearing TTS';
                    Image = ExportElectronicDocument;
                    ApplicationArea = All;
                    ToolTip = 'Executes the TTS Transaction Listing action.';
                    Visible = true;
                    RunObject = codeunit "TTS Staging Export";
                }
                action("Cheque Refunds")
                {
                    Caption = 'Cheque Refunds';
                    Image = ReverseLines;
                    ApplicationArea = all;
                    RunObject = report "Cheque Refunds";
                }
                action("SharePoint Report Scheduler")
                {
                    Image = Share;
                    ApplicationArea = all;
                    RunObject = page "SharePoint Report Scheduler";
                }
                action("SharePoint Log Entries")
                {
                    Image = Log;
                    ApplicationArea = all;
                    RunObject = page "SharePoint Log Entries";
                }
            }
            group(Setup)
            {
                action("Matching Rules")
                {
                    RunObject = Page "Matching Rules";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Matching Rules';
                    Image = Journal;
                }
                action("Integration Setup")
                {
                    RunObject = Page "Integration Setup";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Integration Setup';
                    Image = Journal;
                }
            }
        }
    }
}
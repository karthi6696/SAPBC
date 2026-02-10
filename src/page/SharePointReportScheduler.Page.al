page 85041 "SharePoint Report Scheduler"
{
    ApplicationArea = all;
    CardPageID = "Job Queue Entry Card";
    PageType = List;
    SourceTable = "Job Queue Entry";
    SourceTableView = sorting("Entry No.") where(SharePoint = filter(true));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the status of the job queue entry. When you create a job queue entry, its status is set to On Hold. You can set the status to Ready and back to On Hold. Otherwise, status information in this field is updated automatically.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Unfavorable;
                    StyleExpr = UserDoesNotExist;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field("Report ID"; Rec."Report ID")
                {
                    ToolTip = 'Specifies the value of the Report ID field.', Comment = '%';
                }
                field("Report Name"; Rec."Report Name")
                {
                    ToolTip = 'Specifies the value of the Report Name field.', Comment = '%';
                }
                field("Job Queue Category Code"; Rec."Job Queue Category Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code of the job queue category to which the job queue entry belongs. Choose the field to select a code from the list.';
                }
                field("User Session Started"; Rec."User Session Started")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date and time that a user session started.';
                }
                field("Parameter String"; Rec."Parameter String")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a text string that is used as a parameter by the job queue when it is run.';
                    Visible = false;
                }
                field("Earliest Start Date/Time"; Rec."Earliest Start Date/Time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the earliest date and time when the job queue entry should be run.';
                }
                field(Scheduled; Rec.Scheduled)
                {
                    ApplicationArea = Basic, Suite;
                    Style = Unfavorable;
                    StyleExpr = not Rec.Scheduled;
                    ToolTip = 'Specifies if the job queue entry has been scheduled to run automatically, which happens when an entry changes status to Ready. If the field is cleared, the job queue entry is not scheduled to run.';
                }
                field("Recurring Job"; Rec."Recurring Job")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the job queue entry is recurring. If the Recurring Job check box is selected, then the job queue entry is recurring. If the check box is cleared, the job queue entry is not recurring. After you specify that a job queue entry is a recurring one, you must specify on which days of the week the job queue entry is to run. Optionally, you can also specify a time of day for the job to run and how many minutes should elapse between runs.';
                }
                field("No. of Minutes between Runs"; Rec."No. of Minutes between Runs")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the minimum number of minutes that are to elapse between runs of a job queue entry. This field only has meaning if the job queue entry is set to be a recurring job.';
                }
                field("Run on Mondays"; Rec."Run on Mondays")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the job queue entry runs on Mondays.';
                    Visible = false;
                }
                field("Run on Tuesdays"; Rec."Run on Tuesdays")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the job queue entry runs on Tuesdays.';
                    Visible = false;
                }
                field("Run on Wednesdays"; Rec."Run on Wednesdays")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the job queue entry runs on Wednesdays.';
                    Visible = false;
                }
                field("Run on Thursdays"; Rec."Run on Thursdays")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the job queue entry runs on Thursdays.';
                    Visible = false;
                }
                field("Run on Fridays"; Rec."Run on Fridays")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the job queue entry runs on Fridays.';
                    Visible = false;
                }
                field("Run on Saturdays"; Rec."Run on Saturdays")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the job queue entry runs on Saturdays.';
                    Visible = false;
                }
                field("Run on Sundays"; Rec."Run on Sundays")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the job queue entry runs on Sundays.';
                    Visible = false;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the earliest time of the day that the recurring job queue entry is to be run.';
                    Visible = false;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the latest time of the day that the recurring job queue entry is to be run.';
                    Visible = false;
                }
                field(Timeout; Rec."Job Timeout")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the maximum time that the job queue entry is allowed to run.';
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Job &Queue")
            {
                Caption = 'Job &Queue';
                Image = CheckList;
                action(ResetStatus)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Set Status to Ready';
                    Image = ResetStatus;
                    ToolTip = 'Change the status of the selected entry.';

                    trigger OnAction()
                    begin
                        Rec.SetStatus(Rec.Status::Ready);
                    end;
                }
                action(Suspend)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Set On Hold';
                    Image = Pause;
                    ToolTip = 'Change the status of the selected entry.';

                    trigger OnAction()
                    begin
                        Rec.SetStatus(Rec.Status::"On Hold");
                    end;
                }
                action(ShowError)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Error';
                    Image = Error;
                    ToolTip = 'Show the error message that has stopped the entry.';

                    trigger OnAction()
                    begin
                        Rec.ShowErrorMessage();
                    end;
                }
                action(Restart)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Restart';
                    Image = Start;
                    ToolTip = 'Stop and start the selected entry.';

                    trigger OnAction()
                    begin
                        Rec.Restart();
                    end;
                }
                action(RunInForeground)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Run once (foreground)';
                    Image = DebugNext;
                    ToolTip = 'Run a copy of this job once in foreground.';

                    trigger OnAction()
                    var
                        JobQueueManagement: Codeunit "Job Queue Management";
                    begin
                        JobQueueManagement.RunJobQueueEntryOnce(Rec);
                    end;
                }
            }
        }
        area(navigation)
        {
            group(Action15)
            {
                Caption = 'Job &Queue';
                Image = CheckList;
                action(LogEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Log Entries';
                    Image = Log;
                    RunObject = Page "Job Queue Log Entries";
                    RunPageLink = ID = field(ID);
                    ToolTip = 'View the job queue log entries.';
                }
                action(SPLogEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SP Log Entries';
                    Image = Log;
                    RunObject = Page "SharePoint Log Entries";
                    RunPageLink = "Schedule ID" = field(ID);
                    ToolTip = 'View SharePoint log entries.';
                }
                action(ShowRecord)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Record';
                    Image = ViewDetails;
                    ToolTip = 'Show the record for the selected entry.';

                    trigger OnAction()
                    begin
                        Rec.LookupRecordToProcess();
                    end;
                }
                action(RunNow)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Run the current Job Queue Entry now';
                    Image = DebugNext;
                    ToolTip = 'Schedules the current Job Queue Entry for immediate execution.';

                    trigger OnAction()
                    var
                        JobQueueDispatcher: Codeunit "Job Queue Dispatcher";
                        IsHandled: Boolean;
                    begin
                        IsHandled := false;
                        OnBeforeOnActionRunNow(Rec, IsHandled);
                        if IsHandled then
                            exit;

                        Rec.Status := Rec.Status::Ready;
                        Rec.Modify(false);
                        Commit(); // Commit() is needed because the dispatcher calls SelectLatestVersion;
                        JobQueueDispatcher.Run(Rec);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(ResetStatus_Promoted; ResetStatus)
                {
                }
                actionref(Restart_Promoted; Restart)
                {
                }
                actionref(RunInForeground_Promoted; RunInForeground)
                {
                }
                actionref(Suspend_Promoted; Suspend)
                {
                }
                actionref(ShowError_Promoted; ShowError)
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        User: Record User;
    begin
        UserDoesNotExist := false;
        if Rec."User ID" = UserId then
            exit;
        if User.IsEmpty() then
            exit;
        User.SetRange("User Name", Rec."User ID");
        UserDoesNotExist := User.IsEmpty();
    end;

    var
        UserDoesNotExist: Boolean;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnActionRunNow(JobQueueEntry: Record "Job Queue Entry"; var IsHandled: Boolean)
    begin
    end;
}


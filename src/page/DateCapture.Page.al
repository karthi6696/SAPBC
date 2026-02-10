page 85024 "Date Capture"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("Date Capture")
            {
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;

    procedure ReturnDates(var ReturnStartDate: Date; var ReturnEndDate: Date)
    begin
        ReturnStartDate := StartDate;
        ReturnEndDate := EndDate;
    end;


}
pageextension 85007 "Job Queue Entry" extends "Job Queue Entries"
{
    trigger OnOpenPage()
    begin
        Rec.SetRange(SharePoint, false);
    end;
}

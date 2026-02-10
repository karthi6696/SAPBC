codeunit 85002 "Send Err Log Email"
{
    trigger OnRun()
    begin
        SendEmail();
    end;

    procedure SendEmail()
    var
        IntegrationSetup: Record "Integration Setup";
        AttachmentStream: InStream;
        OStream: OutStream;
        Tempblob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        UnprocessedTTSRep: Report "Unprocessed TTS Records";
        UnprocessedCPMSRep: Report "Unprocessed CPMS Records";
        TTSStaging: Record TTS_SAP;
        CPMSStaging: Record TTS_ARAP;

    begin
        IntegrationSetup.Get();
        IntegrationSetup.TestField("To Email");
        IntegrationSetup.TestField("Email Subject");

        CPMSStaging.Reset();
        CPMSStaging.SetRange(Posted, false);
        if not CPMSStaging.IsEmpty then begin
            EmailMessage.Create(IntegrationSetup."To Email", IntegrationSetup."Email Subject", IntegrationSetup.GetSAPJournalNBText());
            Tempblob.CreateOutStream(OStream);
            if UnprocessedCPMSRep.SaveAs('', ReportFormat::Excel, OStream) then begin
                Tempblob.CreateInStream(AttachmentStream);
                EmailMessage.AddAttachment('Unprocessed CPMS.xlsx', 'xlsx', AttachmentStream);
            end;
        end;

        TTSStaging.Reset();
        TTSStaging.SetRange(Posted, false);
        if not TTSStaging.IsEmpty then begin
            Clear(Tempblob);
            Tempblob.CreateOutStream(OStream);
            if UnprocessedTTSRep.SaveAs('', ReportFormat::Excel, OStream) then begin
                Tempblob.CreateInStream(AttachmentStream);
                EmailMessage.AddAttachment('Unprocessed TTS.xlsx', 'xlsx', AttachmentStream);
            end;
        end;

        if (not TTSStaging.IsEmpty) or (not CPMSStaging.IsEmpty) then begin
            EmailMessage.SetBodyHTMLFormatted(true);
            Email.Send(EmailMessage, Enum::"Email Scenario"::Notification);
        end;
    end;
}
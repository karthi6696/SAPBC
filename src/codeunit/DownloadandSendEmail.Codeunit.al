codeunit 85017 "Download and Send Email"
{
    trigger OnRun()
    var
        i: Integer;
    begin
        i := 0;
        repeat
            InitializeAzureBlobStorage(Enum::Type.FromInteger(i), 'quarantine');
            //InitializeAzureBlobStorage(Enum::Type.FromInteger(1), 'quarantine');
            if ABSContainerContent.FindSet() then
                repeat
                    case true of
                        ABSContainerContent.Level = 1:
                            begin

                                ParentFolder := ABSContainerContent.Name;
                                ParentFolderFullname := ABSContainerContent."Full Name";
                            end;
                        ABSContainerContent.Level = 2:
                            begin
                                SubFolder := ABSContainerContent.Name;
                                SubFolderFullname := ABSContainerContent."Full Name";
                            end;
                        ABSContainerContent.Level = 3:
                            if ABSContainerContent."Full Name".Contains('SUCCESS') then
                                BlobClient.DeleteBlob(ABSContainerContent."Full Name")
                            else begin
                                InitLogEntry();
                                DownloadFileFromAzureBlob();
                                if SendEmail() then
                                    ArchiveFileInABS('quarantine\' + ParentFolder + '\' + SubFolder)
                                else
                                    AzurelogEntries.Delete(true);
                            end;
                    end;
                until ABSContainerContent.Next() = 0;


            InitializeAzureBlobStorage(Enum::Type.FromInteger(i), 'reject');
            //InitializeAzureBlobStorage(Enum::Type.FromInteger(1), 'reject');
            if ABSContainerContent.FindSet() then
                repeat
                    case true of
                        ABSContainerContent.Level = 1:
                            begin
                                ParentFolder := ABSContainerContent.Name;
                                ParentFolderFullname := ABSContainerContent."Full Name";
                            end;
                        ABSContainerContent.Level = 2:
                            begin
                                SubFolder := ABSContainerContent.Name;
                                SubFolderFullname := ABSContainerContent."Full Name";
                            end;
                        ABSContainerContent.Level = 3:
                            if ABSContainerContent."Full Name".Contains('SUCCESS') then
                                BlobClient.DeleteBlob(ABSContainerContent."Full Name")
                            else begin
                                InitLogEntry();
                                DownloadFileFromAzureBlob();
                                if SendEmail() then
                                    ArchiveFileInABS('reject\' + ParentFolder + '\' + SubFolder)
                                else
                                    AzurelogEntries.Delete(true);
                            end;
                    end;
                until ABSContainerContent.Next() = 0;

            i += 1;
        until i = 3;
    end;

    var
        ParentFolder, SubFolder, ParentFolderFullname, SubFolderFullname, SuccessFile, SuccessFilefullnam : text;
        ABSContainerContent: Record "ABS Container Content" temporary;
        AzureStorageSetup: Record "AzureStorageSetup";
        ArchiveBlobClient, BlobClient : Codeunit "ABS Blob Client";
        ContainerClient: Codeunit "ABS Container Client";
        Auth: Interface "Storage Service Authorization";

        Response: Codeunit "ABS Operation Response";
        StorageServiceAuth: Codeunit "Storage Service Authorization";
        Tempblob: Codeunit "Temp Blob";
        AzurelogEntries: Record "Azure Storage Log Entries";
        IStream: InStream;

        ABSOptionalParameters: Codeunit "ABS Optional Parameters";


    local procedure InitializeAzureBlobStorage(Type: Enum Type;
FolderName: text)
    begin
        AzureStorageSetup.Get();
        Auth := StorageServiceAuth.CreateSharedKey(AzureStorageSetup.GetSharedAccessKey());
        ContainerClient.Initialize(AzureStorageSetup.AccountName, Auth);
        case true of
            Type = type::LOB:
                BlobClient.Initialize(AzureStorageSetup.AccountName, AzureStorageSetup."Synapse TTS File Container", Auth);
            Type = type::CPMS:
                BlobClient.Initialize(AzureStorageSetup.AccountName, AzureStorageSetup."Synapse CPMS File Container", Auth);
            Type = type::EOD:
                BlobClient.Initialize(AzureStorageSetup.AccountName, AzureStorageSetup."Synapse EOD File Container", Auth);
        end;
        ABSOptionalParameters.Prefix(FolderName);
        Response := BlobClient.ListBlobs(ABSContainerContent, ABSOptionalParameters);
        if not Response.IsSuccessful() then
            Error(Response.GetError());

    end;

    local procedure InitLogEntry()
    begin
        Clear(AzurelogEntries);
        AzurelogEntries.Init();
        AzurelogEntries.Direction := AzurelogEntries.Direction::Import;
        AzurelogEntries.Insert(true);
    end;

    local procedure DownloadFileFromAzureBlob()
    begin
        Tempblob.CreateInStream(IStream);
        AzurelogEntries."File Name" := ABSContainerContent.Name;
        Clear(Response);
        Response := BlobClient.GetBlobAsStream(ABSContainerContent."Full Name", IStream, ABSOptionalParameters);
        if IStream.Length = 0 then
            exit;
        if not Response.IsSuccessful() then begin
            AzurelogEntries.Status := AzurelogEntries.Status::Failed;
            AzurelogEntries.Message := AzurelogEntries.Message + Response.GetError();
        end else begin
            AzurelogEntries.Status := AzurelogEntries.Status::Success;
            AzurelogEntries.Message := 'File Imported Successfully.';
            AzurelogEntries.File.ImportStream(IStream, AzurelogEntries."File Name");
            AzurelogEntries."File Address" := ABSContainerContent."Full Name";
            AzurelogEntries."Sub Folder" := SubFolderFullname;
            AzurelogEntries."Parent Folder" := ParentFolderFullname;
            AzurelogEntries.Modify(true)
        end;
    end;

    procedure SendEmail(): Boolean
    var
        IntegrationSetup: Record "Integration Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        if IStream.Length = 0 then
            exit;
        IntegrationSetup.Get();
        IntegrationSetup.TestField("Syn. Err. Email Subject");
        IntegrationSetup.TestField("Syn. Err. File To Email");
        EmailMessage.Create(IntegrationSetup."Syn. Err. File To Email", IntegrationSetup."Syn. Err. Email Subject", IntegrationSetup.GetSynErrNBText());
        EmailMessage.AddAttachment(AzurelogEntries."File Name", 'xlsx', IStream);
        EmailMessage.SetBodyHTMLFormatted(true);
        exit(Email.Send(EmailMessage, Enum::"Email Scenario"::Notification));
    end;

    procedure ArchiveFileInABS(Folder: Text)
    var
        lTempblob: Codeunit "Temp Blob";
        FileStream: InStream;
        OStream: OutStream;
    begin
        lTempblob.CreateOutStream(OStream);
        AzurelogEntries.File.ExportStream(OStream);
        lTempblob.CreateInStream(FileStream);
        Clear(Response);
        Response := BlobClient.PutBlobBlockBlobStream('archive\' + Folder + '\' + ABSContainerContent.Name, FileStream);
        if Response.IsSuccessful() then begin
            BlobClient.DeleteBlob(ABSContainerContent."Full Name");
            BlobClient.DeleteBlob(SubFolderFullname);
            BlobClient.DeleteBlob(ParentFolderFullname);
        end;
    end;
}
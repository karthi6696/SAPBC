codeunit 85003 "Sharepoint Connection"
{
    [TryFunction]
    procedure InitializeConnection()
    var
        Sharepointlist: Record "SharePoint List" temporary;
        Secrettext: SecretText;
    begin
        if Connected then
            exit;

        CheckMandatoryFields();

        Secrettext := SharepointConnectionSetup.GetSecret();
        Authorization := SharepointAuth.CreateAuthorizationCode(SharepointConnectionSetup."Tenant ID", SharepointConnectionSetup."Client ID", Secrettext, '00000003-0000-0ff1-ce00-000000000000/.default');

        SharepointClient.Initialize(SharepointConnectionSetup."Sharepoint Site URL", Authorization);
        SharepointClient.GetLists(Sharepointlist);

        Diagnostics := SharepointClient.GetDiagnostics();
        if Diagnostics.IsSuccessStatusCode() then
            Connected := true
        else
            Error(Diagnostics.GetResponseReasonPhrase())
    end;


    procedure UploadFile(var SharepointFileLinks: Record "SharePoint Log Entries"; var Filestream: InStream; FileName: Text): Boolean
    var
        FolderName: Text;
        SharepointFile: Record "SharePoint File" temporary;
        Sharepointfolder: Record "SharePoint Folder" temporary;
        DialogUpload: Dialog;
        FileExistsLabel: Label 'File already exists in the SharePoint!';
        UploadingLabel: Label 'Uploading %1 into SharePoint...';
    begin
        DialogUpload.Open(StrSubstNo(UploadingLabel, FileName));

        if SharepointClient.GetSubFoldersByServerRelativeUrl(SharepointConnectionSetup."Sharepoint Directory", Sharepointfolder) then begin
            Sharepointfolder.SetFilter(Name, 'Reports');
            if Sharepointfolder.IsEmpty then
                SharepointClient.CreateFolder(SharepointConnectionSetup."Sharepoint Directory" + 'Reports', Sharepointfolder);
        end else
            SharepointClient.CreateFolder(SharepointConnectionSetup."Sharepoint Directory" + 'Reports', Sharepointfolder);

        if SharepointClient.GetSubFoldersByServerRelativeUrl(SharepointConnectionSetup."Sharepoint Directory" + 'Reports' + '/' + SharepointFileLinks."Report Name", Sharepointfolder) then begin
            Sharepointfolder.SetFilter(Name, SharepointFileLinks."Report Name");
            if Sharepointfolder.IsEmpty then
                SharepointClient.CreateFolder(SharepointConnectionSetup."Sharepoint Directory" + 'Reports' + '/' + SharepointFileLinks."Report Name", Sharepointfolder);
        end else
            SharepointClient.CreateFolder(SharepointConnectionSetup."Sharepoint Directory" + 'Reports' + '/' + SharepointFileLinks."Report Name", Sharepointfolder);

        FolderName := Text.ConvertStr(Format(Today), '/', '-');
        if SharepointClient.GetSubFoldersByServerRelativeUrl(SharepointConnectionSetup."Sharepoint Directory" + 'Reports' + '/' + SharepointFileLinks."Report Name" + '/' + FolderName, Sharepointfolder) then begin
            Sharepointfolder.SetFilter(Name, FolderName);
            if Sharepointfolder.IsEmpty then
                SharepointClient.CreateFolder(SharepointConnectionSetup."Sharepoint Directory" + 'Reports' + '/' + SharepointFileLinks."Report Name" + '/' + FolderName, Sharepointfolder);
        end else
            SharepointClient.CreateFolder(SharepointConnectionSetup."Sharepoint Directory" + 'Reports' + '/' + SharepointFileLinks."Report Name" + '/' + FolderName, Sharepointfolder);

        if Filestream.Length = 0 then
            exit;
        if SharepointClient.AddFileToFolder(SharepointConnectionSetup."Sharepoint Directory" + 'Reports' + '/' + SharepointFileLinks."Report Name" + '/' + FolderName, FileName, Filestream, SharepointFile) then begin
            SharepointFileLinks."Sharepoint Link" := '';
            SharepointFileLinks."Odata ID" := SharepointFile.OdataId;
            //GetSharepointLink(SharepointFileLinks);
            SharepointFileLinks.Modify(true);
        end;

        DialogUpload.Close();
        Diagnostics := SharepointClient.GetDiagnostics();
        if not Diagnostics.IsSuccessStatusCode() then
            Error(Diagnostics.GetResponseReasonPhrase());

        exit(true);
    end;

    procedure DownloadFile(var SharepointFileLinks: Record "SharePoint Log Entries")
    var
        FileNotFoundLabel: Label 'File not found in SharePoint.';
        DownloadStream: InStream;
    begin
        InitializeConnection();
        if SharepointClient.DownloadFileContent(SharepointFileLinks."Odata ID", DownloadStream) then
            DownloadFromStream(DownloadStream, '', '', '', SharepointFileLinks."File Name")
        else
            Error(FileNotFoundLabel);
    end;

    procedure DeleteFile(var SharepointFileLinks: Record "SharePoint Log Entries")
    var
        DeleteLabel: Label 'The file you are attempting to access may either be in use/locked or has been removed from SharePoint. Are you sure you want to proceed with deleting the file from this location?';
        FolderName: Text;
    begin
        InitializeConnection();
        if SharepointClient.DeleteFileByServerRelativeUrl(SharepointConnectionSetup."Sharepoint Directory" + 'Reports' + '/' + SharepointFileLinks."File Name") then
            SharepointFileLinks.Delete()
        else
            if Confirm(DeleteLabel, true) then
                SharepointFileLinks.Delete();
    end;

    procedure GetSharepointLink(var SharepointFileLinks: Record "SharePoint Log Entries")
    var
        FolderName: Text;
        SharepointFile: Record "SharePoint File" temporary;
        JsonResponse: JsonObject;
        JsonArrayInfo: JsonArray;
        SiteURL: Label 'https://graph.microsoft.com/v1.0/sites/';
        DriveURL: Label 'https://graph.microsoft.com/v1.0/sites/%1/drives/';
        ItemURL: Label 'https://graph.microsoft.com/v1.0/sites/%1/drives/%2/%3/';
        SiteID, DriveID : Text;
        DirectoryFolderName: List of [Text];
        Rootfolder, FileID, FileLink : Text;
    begin
        AccessToken := GetAccessToken();
        JsonResponse := GetSharepointResult(SiteURL);
        JsonArrayInfo := GetJsonToken(JsonResponse, 'value').AsArray();
        SiteID := ParseSiteID(JsonArrayInfo);

        JsonResponse := GetSharepointResult(StrSubstNo(DriveURL, SiteID));
        JsonArrayInfo := GetJsonToken(JsonResponse, 'value').AsArray();
        DriveID := ParseDriveID(JsonArrayInfo);

        DirectoryFolderName := SharepointConnectionSetup."Sharepoint Directory".Split('/');
        DirectoryFolderName.Get(DirectoryFolderName.Count - 1, Rootfolder);

        FolderName := 'Reports' + '/' + SharepointFileLinks."Report Name" + '/' + Text.ConvertStr(Format(Today), '/', '-');
        Rootfolder := 'root:/' + Rootfolder + '/' + FolderName + '/' + SharepointFileLinks."File Name";

        JsonResponse := GetSharepointResult(StrSubstNo(ItemURL, SiteID, DriveID, Rootfolder));
        FileID := GetJsonToken(JsonResponse, 'id').AsValue().AsText();
        SharepointFileLinks."Sharepoint Link" := Getlink(StrSubstNo(ItemURL, SiteID, DriveID, StrSubstNo('items/%1/', FileID)));

        //SharepointFileLinks."Sharepoint Link" := Createlink(StrSubstNo(ItemURL, SiteID, DriveID, StrSubstNo('items/%1/createLink', FileID)));
    end;

    procedure Getlink(ResourceURL: Text): Text
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JsonResponse, JsonLinkobj : JsonObject;
        JsonContent: Text;
        BearerLbl: Label 'Bearer %1';
        Httpconent: HttpContent;
    begin
        Client.Clear();
        Client.DefaultRequestHeaders.Add('Authorization', SecretStrSubstNo(BearerLbl, AccessToken));
        Client.DefaultRequestHeaders().Add('Accept', 'application/json');
        if Client.Get(ResourceURL, ResponseMessage) then
            if ResponseMessage.HttpStatusCode() IN [200, 201] then begin
                ResponseMessage.Content.ReadAs(JsonContent);
                JsonResponse.ReadFrom(JsonContent);
                //JsonLinkobj := GetJsonToken(JsonResponse, 'link').AsObject();
                exit(GetJsonToken(JsonResponse, 'webUrl').AsValue().AsText());
            end else
                if (ResponseMessage.Content.ReadAs(JsonContent)) then
                    Error(JsonContent);
    end;

    procedure Createlink(ResourceURL: Text): Text
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JsonResponse, JsonLinkobj : JsonObject;
        JsonContent: Text;
        BearerLbl: Label 'Bearer %1';
        Httpconent: HttpContent;
    begin
        Client.Clear();
        Client.DefaultRequestHeaders.Add('Authorization', SecretStrSubstNo(BearerLbl, AccessToken));
        Client.DefaultRequestHeaders().Add('Accept', 'application/json');
        if Client.Post(ResourceURL, Httpconent, ResponseMessage) then
            if ResponseMessage.HttpStatusCode() IN [200, 201] then begin
                ResponseMessage.Content.ReadAs(JsonContent);
                JsonResponse.ReadFrom(JsonContent);
                JsonLinkobj := GetJsonToken(JsonResponse, 'link').AsObject();
                exit(GetJsonToken(JsonLinkobj, 'webUrl').AsValue().AsText());
            end else
                Error(ResponseMessage.ReasonPhrase);
    end;

    procedure GetSharepointResult(ResourceURL: Text): JsonObject
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JsonResponse: JsonObject;
        JsonContent: Text;
        BearerLbl: Label 'Bearer %1';
    begin
        Client.Clear();
        Client.DefaultRequestHeaders.Add('Authorization', SecretStrSubstNo(BearerLbl, AccessToken));
        Client.DefaultRequestHeaders().Add('Accept', 'application/json');
        if Client.Get(ResourceURL, ResponseMessage) then
            if ResponseMessage.HttpStatusCode() = 200 then begin
                ResponseMessage.Content.ReadAs(JsonContent);
                JsonResponse.ReadFrom(JsonContent);
                exit(JsonResponse)
            end else
                if (ResponseMessage.Content.ReadAs(JsonContent)) then
                    Error(JsonContent);

    end;

    procedure ParseSiteID(JsonArray: JsonArray): Text
    var
        I: Integer;
        JsonToken: JsonToken;
        Jsonobject: JsonObject;
        weburl, siteid : JsonToken;
    begin
        for i := 0 to JsonArray.Count - 1 do begin
            JsonArray.Get(i, JsonToken);
            Jsonobject := JsonToken.AsObject();
            weburl := GetJsonToken(Jsonobject, 'webUrl');
            if (weburl.AsValue().AsText() + '/' = SharepointConnectionSetup."Sharepoint Site URL") then begin
                siteid := GetJsonToken(Jsonobject, 'id');
                exit(siteid.AsValue().AsText());
            end;
        end;
    end;

    procedure ParseDriveID(JsonArray: JsonArray): Text
    var
        I: Integer;
        JsonToken: JsonToken;
        Jsonobject: JsonObject;
        drivename, driveid : JsonToken;
    begin
        for i := 0 to JsonArray.Count - 1 do begin
            JsonArray.Get(i, JsonToken);
            Jsonobject := JsonToken.AsObject();
            drivename := GetJsonToken(Jsonobject, 'name');
            if (drivename.AsValue().AsText() = 'Documents') then begin
                driveid := GetJsonToken(Jsonobject, 'id');
                exit(driveid.AsValue().AsText());
            end;
        end;
    end;

    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: Text) JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(TokenKey, JsonToken) then
            Error('Cannot find the token with the key %1', JsonToken);
    end;

    procedure GetAccessToken(): SecretText
    var
        TokerErr: Label 'Unable to retrieve the Access Token';
        OAuth2: Codeunit OAuth2;
        ResourceUrlTxt: Label 'https://graph.microsoft.com', Locked = true;
        AuthUrl: Label 'https://login.microsoftonline.com/%1/oauth2/v2.0/authorize';
        RedirectURL: Label 'https://businesscentral.dynamics.com/OAuthLanding.htm';
        lSecretText: SecretText;
        Scopes: List of [Text];
        lAccessToken: SecretText;
    begin
        SharepointConnectionSetup.Get();
        lSecretText := SharepointConnectionSetup.GetSecret();
        Scopes.Add('https://graph.microsoft.com/.default');
        if not OAuth2.AcquireTokenWithClientCredentials(SharepointConnectionSetup."Client ID", lSecretText, StrSubstNo(AuthUrl, SharepointConnectionSetup."Tenant ID"), RedirectURL, Scopes, lAccessToken) then
            Error(TokerErr);

        exit(lAccessToken);
    end;


    local procedure CheckMandatoryFields()
    begin
        SharepointConnectionSetup.Get();
        SharepointConnectionSetup.TestField("Client ID");
        SharepointConnectionSetup.TestField("Tenant ID");
        SharepointConnectionSetup.TestField("Sharepoint Base URL");
        SharepointConnectionSetup.TestField("Sharepoint Site URL");
        SharepointConnectionSetup.TestField("Sharepoint Directory");
    end;

    var
        SharepointAuth: Codeunit "SharePoint Auth.";
        Authorization: Interface "SharePoint Authorization";
        SharepointClient: Codeunit "SharePoint Client";
        SharepointConnectionSetup: Record "Sharepoint Connection Setup";
        Diagnostics: Interface "HTTP Diagnostics";
        Connected: Boolean;
        AccessToken: SecretText;
}
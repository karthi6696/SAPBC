page 85042 "SharePoint Connection Setup"
{
    ApplicationArea = All;
    Caption = 'SharePoint Connection Setup';
    PageType = Card;
    SourceTable = "Sharepoint Connection Setup";
    UsageCategory = Administration;
    // DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Client ID"; Rec."Client ID")
                {
                    ToolTip = 'Specifies the value of the Client ID field.', Comment = '%';
                }
                field("Client Secret"; ClientSecretValue)
                {
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the Client Secret field.', Comment = '%';
                    trigger OnValidate()
                    begin
                        if (ClientSecretValue <> '') and (not EncryptionEnabled()) then
                            if Confirm(EncryptionIsNotActivatedQst) then
                                Page.RunModal(Page::"Data Encryption Management");
                        Rec.SetSecret(ClientSecretValue);
                    end;
                }
                field("Tenant ID"; Rec."Tenant ID")
                {
                    ToolTip = 'Specifies the value of the Tenant ID field.';

                }
                field("Sharepoint Base URL"; Rec."Sharepoint Base URL")
                {
                    ToolTip = 'Specifies the value of the Sharepoint Base URL field.', Comment = '%';
                }
                field("Sharepoint Site URL"; Rec."Sharepoint Site URL")
                {
                    ToolTip = 'Specifies the value of the Sharepoint Site URL field.', Comment = '%';
                }

                field("Sharepoint Directory"; Rec."Sharepoint Directory")
                {
                    ToolTip = 'Specifies the value of the Sharepoint Directory field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TestConnection)
            {
                ApplicationArea = All;
                Image = ValidateEmailLoggingSetup;
                Caption = 'Test Connection';
                trigger OnAction()
                var
                    SharepointConnection: Codeunit "Sharepoint Connection";
                    ConnectionSuccessMsg: Label 'The connection test was successful. The settings are valid.';
                begin
                    if SharepointConnection.InitializeConnection() then
                        Message(ConnectionSuccessMsg)
                    else
                        Message(GetLastErrorText());
                end;
            }
            action(OpenSharePointDocLib)
            {
                ApplicationArea = All;
                Image = Web;
                Caption = 'SharePoint Site';
                trigger OnAction()
                var
                    SharepointConnection: Codeunit "Sharepoint Connection";
                    ConnectionSuccessMsg: Label 'The connection test was successful. The settings are valid.';
                begin
                    if SharepointConnection.InitializeConnection() then
                        Hyperlink(Rec."SharePoint Site URL")
                    else
                        Message(GetLastErrorText());
                end;
            }
        }
    }

    var
        ClientSecretValue: Text;
        EncryptionIsNotActivatedQst: Label 'Data encryption is currently not enabled. We recommend that you encrypt data. \Do you want to open the Data Encryption Management window?';

    trigger OnAfterGetRecord()
    begin
        if Rec.HasSecret() then
            ClientSecretValue := '*';
    end;

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

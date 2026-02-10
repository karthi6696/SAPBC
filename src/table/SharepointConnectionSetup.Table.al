table 85020 "Sharepoint Connection Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';

        }
        field(2; "Client ID"; Text[250])
        {
            Caption = 'Client ID';
        }
        field(3; "Client Secret"; Text[250]) //Not used- handled with Isolated Storage
        {
            Caption = 'Client Secret';
        }
        field(4; "Tenant ID"; Text[250])
        {
            Caption = 'Tenant ID';

        }
        field(5; "SharePoint Site URL"; Text[250])
        {
            Caption = 'SharePoint Site URL';
            trigger OnValidate()
            begin
                if Rec."SharePoint Site URL" <> '' then
                    if not Rec."SharePoint Site URL".EndsWith('/') then
                        Rec."SharePoint Site URL" := Rec."SharePoint Site URL" + '/';
            end;
        }
        field(6; "SharePoint Directory"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'SharePoint Directory';
            trigger OnValidate()
            begin
                if Rec."SharePoint Directory" <> '' then begin
                    if not Rec."SharePoint Directory".StartsWith('/') then
                        Rec."SharePoint Directory" := '/' + Rec."SharePoint Directory";
                    if not Rec."SharePoint Directory".EndsWith('/') then
                        Rec."SharePoint Directory" := Rec."SharePoint Directory" + '/';
                end;
            end;
        }
        field(7; KeyStorageId; Guid)
        {
            Caption = 'KeyStorageId';
        }
        field(8; "SharePoint Base URL"; Text[250])
        {
            Caption = 'SharePoint Base URL';
            trigger OnValidate()
            begin
                if Rec."SharePoint Base URL" <> '' then
                    if not Rec."SharePoint Base URL".EndsWith('/') then
                        Rec."SharePoint Base URL" := Rec."SharePoint Base URL" + '/';
            end;

        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    [NonDebuggable]
    procedure SetSecret(clientsecret: Text)
    begin
        if IsNullGuid(KeyStorageId) then
            KeyStorageId := CreateGuid();

        if not EncryptionEnabled() then
            IsolatedStorage.Set(KeyStorageId, clientsecret, DataScope::Module)
        else
            IsolatedStorage.SetEncrypted(KeyStorageId, clientsecret, DataScope::Module);
    end;

    //[NonDebuggable]
    procedure GetSecret(): SecretText
    var
        Value: SecretText;
    begin
        if not IsNullGuid(KeyStorageId) then
            IsolatedStorage.Get(KeyStorageId, DataScope::Module, Value);
        exit(Value);
    end;

    //[NonDebuggable]
    procedure HasSecret(): Boolean
    begin
        exit(not GetSecret().IsEmpty());
    end;
}
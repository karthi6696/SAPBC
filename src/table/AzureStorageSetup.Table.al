table 85004 "AzureStorageSetup"
{
    Access = Internal;
    Caption = 'Azure Storage Account Setup';

    fields
    {
        field(1; PrimaryKey; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; AccountName; Text[250])
        {
            Caption = 'Account Name';
        }
        field(5; KeyStorageId; Guid)
        {
            Caption = 'KeyStorageId';
        }
        field(6; IsEnabled; Boolean)
        {
            Caption = 'Is Enabled';
        }
        field(7; "Synapse CPMS File Container"; Text[150])
        {
            Caption = 'CPMS Error File Container';
        }
        field(8; "Synapse EOD File Container"; Text[150])
        {
            Caption = 'EOD Error File Container';
        }
        field(9; "Synapse TTS File Container"; Text[150])
        {
            Caption = 'TTS Error File Container';
        }
    }

    procedure SetSharedAccessKey(SharedAccessKey: Text)
    begin
        if IsNullGuid(KeyStorageId) then
            KeyStorageId := CreateGuid();

        if not EncryptionEnabled() then
            IsolatedStorage.Set(KeyStorageId, SharedAccessKey, DataScope::Module)
        else
            IsolatedStorage.SetEncrypted(KeyStorageId, SharedAccessKey, DataScope::Module);
    end;

    [NonDebuggable]
    internal procedure GetSharedAccessKey(): SecretText
    var
        Value: Text;
    begin
        if not IsNullGuid(KeyStorageId) then
            IsolatedStorage.Get(KeyStorageId, DataScope::Module, Value);
        exit(Value);
    end;

    [NonDebuggable]
    procedure HasSharedAccessKey(): Boolean
    begin
        exit(not GetSharedAccessKey().IsEmpty());
    end;
}
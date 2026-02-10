page 85006 "AzureStorageSetup"
{
    AccessByPermission = tabledata "AzureStorageSetup" = IM;
    Caption = 'Azure Storage Account Setup';
    SourceTable = "AzureStorageSetup";
    UsageCategory = Administration;
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(AccountName; Rec.AccountName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Storage Account name';
                }
                field(SharedAccessKey; SharedAccessKeyValue)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the access key used for authentication';
                    Caption = 'Shared Access Key';
                    trigger OnValidate()
                    begin
                        if (SharedAccessKeyValue <> '') and (not EncryptionEnabled()) then
                            if Confirm(EncryptionIsNotActivatedQst) then
                                Page.RunModal(Page::"Data Encryption Management");
                        Rec.SetSharedAccessKey(SharedAccessKeyValue);
                    end;
                }

                field(IsEnabled; Rec.IsEnabled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the Azure Storage Account is enabled';
                }
                field("Synapse TTS File Container"; Rec."Synapse TTS File Container")
                {
                    ToolTip = 'Specifies the value of the BC Container field.', Comment = '%';
                }
                field("Synapse CPMS File Container"; Rec."Synapse CPMS File Container")
                {
                    ToolTip = 'Specifies the value of the CPMS Error File Container field.', Comment = '%';
                }
                field("Synapse EOD File Container"; Rec."Synapse EOD File Container")
                {
                    ToolTip = 'Specifies the value of the EOD Error File Container field.', Comment = '%';
                }


            }

        }
    }

    var
        SharedAccessKeyValue: Text;
        EncryptionIsNotActivatedQst: Label 'Data encryption is currently not enabled. We recommend that you encrypt data. \Do you want to open the Data Encryption Management window?';

    trigger OnAfterGetRecord()
    begin
        if Rec.HasSharedAccessKey() then
            SharedAccessKeyValue := '*';
    end;


}
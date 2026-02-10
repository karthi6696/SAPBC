codeunit 85016 "BIN AzureStorageSetup"
{
#pragma warning disable AL0432
    [EventSubscriber(ObjectType::Table, Database::"Service Connection", 'OnRegisterServiceConnection', '', false, false)]
#pragma warning restore AL0432
#pragma warning disable AL0432
    local procedure OnRegisterServiceConnection(var ServiceConnection: Record "Service Connection");
#pragma warning restore AL0432
    var
        AzureStorageSetup: Record "AzureStorageSetup";
        RecRef: RecordRef;
    begin
        if not AzureStorageSetup.Get() then begin
            if not AzureStorageSetup.WritePermission() then
                exit;
            AzureStorageSetup.Init();
            AzureStorageSetup.Insert();
        end;

        RecRef.GetTable(AzureStorageSetup);
        if AzureStorageSetup.IsEnabled then
            ServiceConnection.Status := ServiceConnection.Status::Enabled
        else
            ServiceConnection.Status := ServiceConnection.Status::Disabled;

        ServiceConnection.InsertServiceConnection(
            ServiceConnection, RecRef.RecordId(), AzureStorageSetup.TableCaption(),
            AzureStorageSetup.AccountName,
            Page::"AzureStorageSetup");
    end;
}
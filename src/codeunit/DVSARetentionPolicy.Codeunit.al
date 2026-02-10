codeunit 85010 "DVSA Retention Policy"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        AddRetentionPolicyAllowedTables();
    end;


    local procedure AddRetentionPolicyAllowedTables()
    var
        CPMS: Record TTS_ARAP;
        TTS: Record TTS_SAP;
        EOD: Record "EOD Staging";
        SharePointLogEntries: Record "SharePoint Log Entries";
        RetentionPolicyAllowTab: Codeunit "Reten. Pol. Allowed Tables";
    begin
        RetentionPolicyAllowTab.AddAllowedTable(Database::TTS_ARAP, CPMS.FieldNo(SystemCreatedAt), 7);
        RetentionPolicyAllowTab.AddAllowedTable(Database::TTS_SAP, TTS.FieldNo(SystemCreatedAt), 7);
        RetentionPolicyAllowTab.AddAllowedTable(Database::"EOD Staging", EOD.FieldNo(SystemCreatedAt), 7);
        RetentionPolicyAllowTab.AddAllowedTable(Database::"SharePoint Log Entries", SharePointLogEntries.FieldNo(SystemCreatedAt), 7);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Company-Initialize", OnCompanyInitialize, '', false, false)]
    local procedure RunonCompanyInitialize()
    begin
        AddRetentionPolicyAllowedTables();
    end;
}
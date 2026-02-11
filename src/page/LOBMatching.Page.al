page 85017 "LOB Matching"
{
    ApplicationArea = All;
    Caption = 'LOB Matching';
    PageType = ListPart;
    SourceTable = TTS_SAP;
    SourceTableView = sorting("Matching Status", "Matching Processed Date Time") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = AllowEdit;
                field(Scheme; Rec.Scheme)
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(Activity; Rec.Activity)
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvoiceDate; Rec.InvoiceDate)
                {
                    ToolTip = 'Specifies the value of the InvoiceDate field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvoiceNumber; Rec.InvoiceNumber)
                {
                    ToolTip = 'Specifies the value of the INVOICE field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(PaymentReference; Rec.PaymentReference)
                {
                    ToolTip = 'Specifies the value of the PaymentReference field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(TestCostWithoutVat; Rec.TestCostWithoutVat)
                {
                    ToolTip = 'Specifies the value of the TestCostWithoutVat field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching ID"; Rec."Matching ID")
                {
                    ToolTip = 'Specifies the value of the Matching ID field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field("Matching Processed Date Time"; Rec."Matching Processed Date Time")
                {
                    ToolTip = 'Specifies the value of the Matching Processed Date Time field.', Comment = '%';
                }

                field("Matching Status"; Rec."Matching Status")
                {
                    ToolTip = 'Specifies the value of the Matching Status field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Match Details"; Rec."Match Details")
                {
                    ToolTip = 'Specifies the value of the Match Details field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Matched By"; Rec."Matched By")
                {
                    ToolTip = 'Specifies the value of the Matched By field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Match Type"; Rec."Match Type")
                {
                    ToolTip = 'Specifies the value of the Match Type field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(CustomerNumber; Rec.CustomerNumber)
                {
                    ToolTip = 'Specifies the value of the CustomerNumber field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(FinanceSapId; Rec.FinanceSapId)
                {
                    ToolTip = 'Specifies the value of the FinanceSapId field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(FileDate; Rec.FileDate)
                {
                    ToolTip = 'Specifies the value of the FileDate field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(INVOICE; Rec.INVOICE)
                {
                    ToolTip = 'Specifies the value of the INVOICE field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(InvAddressLine1; Rec.InvAddressLine1)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine1 field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(InvAddressLine2; Rec.InvAddressLine2)
                {
                    ToolTip = 'Specifies the value of the InvAdddressLine2 field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(InvAddressLine3; Rec.InvAddressLine3)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine3 field.', Comment = '%';
                }
                field(InvAddressLine4; Rec.InvAddressLine4)
                {
                    ToolTip = 'Specifies the value of the InvAddressLine4 field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvCity; Rec.InvCity)
                {
                    ToolTip = 'Specifies the value of the InvCity field.', Comment = '%';
                    StyleExpr = StyleExp;

                }
                field(InvCustomerName; Rec.InvCustomerName)
                {
                    ToolTip = 'Specifies the value of the InvCustomerName field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(test_duplicate; Rec.test_duplicate)
                {
                    ToolTip = 'Specifies the value of the test_duplicate field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(file_duplicate; Rec.file_duplicate)
                {
                    ToolTip = 'Specifies the value of the file_duplicate field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(TestReference; Rec.TestReference)
                {
                    ToolTip = 'Specifies the value of the TestReference field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(TESTMATCH; Rec.TESTMATCH)
                {
                    ToolTip = 'Specifies the value of the TESTMATCH field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(TestDate; Rec.TestDate)
                {
                    ToolTip = 'Specifies the value of the TestDate field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(REVTESTM; Rec.REVTESTM)
                {
                    ToolTip = 'Specifies the value of the REVTESTM field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(REFUNDOAB; Rec.REFUNDOAB)
                {
                    ToolTip = 'Specifies the value of the REFUNDOAB field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(REFGOODS; Rec.REFGOODS)
                {
                    ToolTip = 'Specifies the value of the REFGOODS field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(Product; Rec.Product)
                {
                    ToolTip = 'Specifies the value of the Product field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Exported to Summary field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(OabTransferValueGross; Rec.OabTransferValueGross)
                {
                    ToolTip = 'Specifies the value of the OabTransferValueGross field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(LongText; Rec.LongText)
                {
                    ToolTip = 'Specifies the value of the LongText field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(LineId; Rec.LineId)
                {
                    ToolTip = 'Specifies the value of the LineId field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(InvoicePostingDate; Rec.InvoicePostingDate)
                {
                    ToolTip = 'Specifies the value of the InvoicePostingDate field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field(InvPostalCode; Rec.InvPostalCode)
                {
                    ToolTip = 'Specifies the value of the InvPostalCode field.', Comment = '%';
                    StyleExpr = StyleExp;
                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Linked CPMS")
            {
                Image = Links;
                trigger OnAction()
                var
                    CPMS: Record TTS_ARAP;
                begin
                    if Rec."Matching Status" IN [Rec."Matching Status"::Matched, Rec."Matching Status"::Error] then begin
                        CPMS.Reset();
                        CPMS.SetRange("LOB Matching ID", Rec."Matching ID");
                        CPMS.SetRange("LOB Matching Status", Rec."Matching Status");
                        Page.RunModal(page::"CPMS with LOB Matching", CPMS);
                    end;
                end;
            }
            action("Force Match")
            {
                Image = LinkAccount;
                trigger OnAction()
                var
                    LOBData: Record TTS_SAP;
                    MatchID: Code[20];
                    Noseries: Codeunit "No. Series";
                    GLSetup: Record "General Ledger Setup";
                    ForceMatchLbl: Label 'Matched Forcefully';
                begin
                    if not Confirm('Do you want to proceed with Force Matching?', true) then
                        exit;

                    GLSetup.get();
                    MatchID := Noseries.GetNextNo(GLSetup."LOB-CPMS Matching No. Series");

                    CurrPage.SetSelectionFilter(LOBData);

                    if LOBData.FindSet() then
                        repeat
                            LOBData."Matching Status" := LOBData."Matching Status"::Matched;
                            LOBData."Matching ID" := MatchID;
                            LOBData."Match Type" := LOBData."Match Type"::Force;
                            LOBData."Matching Processed Date Time" := CurrentDateTime;
                            LOBData."Matched By" := UserId;
                            LOBData."Match Details" := ForceMatchLbl;
                            LOBData.Modify();
                        until LOBData.Next(-1) = 0;
                end;
            }
            action("Remove Match")
            {
                Image = LinkAccount;
                trigger OnAction()
                var
                    LOBData: Record TTS_SAP;
                begin
                    if not Confirm('Do you want to proceed with Remove Matching?', true) then
                        exit;
                    CurrPage.SetSelectionFilter(LOBData);

                    LOBData.SetRange("Match Type", LOBData."Match Type"::Force);
                    if LOBData.FindSet() then
                        repeat
                            LOBData.Validate("Matching Status", LOBData."Matching Status"::Unmatched);
                            LOBData.Modify();
                        until LOBData.Next() = 0;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        IntegrationSetup: Record "Integration Setup";

    begin
        if UserSetup.Get(UserId) then
            AllowEdit := UserSetup."Integration Admin";


        ExcludeAct := CommonFunctions.ExcludeActivity(gscheme, Excludetype::LOB);
        if ExcludeAct <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetFilter(Activity, ExcludeAct);
            Rec.FilterGroup(0);
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if not AllowEdit then
            Error('You do have permission to insert the record.')
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if not AllowEdit then
            Error('You do not have the permission to delete the record.');
    end;

    var
        AllowEdit: Boolean;

    trigger OnAfterGetRecord()
    begin
        Clear(StyleExp);
        case true of
            Rec."Matching Status" = Rec."Matching Status"::Matched:
                StyleExp := 'Favorable';
            Rec."Matching Status" = rec."Matching Status"::Error:
                StyleExp := 'UnFavorable';
        end;
    end;

    procedure RemoveLOBMatching()
    var
        LOBStaging, LOBStaging1 : Record TTS_SAP;
        CPMSStaging: Record TTS_ARAP;
        MatchingIDList: List of [Code[20]];
        MatchingID: Code[20];
        ProgressDialog: Dialog;
        Counter: Integer;
        TotalMatchingIDs: Integer;
        ProgressMsg: Label 'Removing Matching...\\Processing Matching ID #1###### of #2######', Comment = '#1 = Current count, #2 = Total count';
        CompletedMsg: Label 'Remove Matching completed successfully.\\%1 Matching IDs processed.', Comment = '%1 = Total count';
    begin
        CurrPage.SetSelectionFilter(LOBStaging);
        LOBStaging.SetLoadFields("Matching ID", "Matching Status");
        LOBStaging.SetRange("Matching Status", LOBStaging."Matching Status"::Matched);
        LOBStaging.SetFilter("Matching ID", '<>%1', '');
        
        // Collect all unique Matching IDs first
        if LOBStaging.FindSet() then
            repeat
                if not MatchingIDList.Contains(LOBStaging."Matching ID") then
                    MatchingIDList.Add(LOBStaging."Matching ID");
            until LOBStaging.Next() = 0;

        TotalMatchingIDs := MatchingIDList.Count();
        if TotalMatchingIDs = 0 then
            exit;

        // Show progress dialog
        ProgressDialog.Open(ProgressMsg);
        Counter := 0;

        // Process each unique Matching ID only once - using batch operations for speed
        foreach MatchingID in MatchingIDList do begin
            Counter += 1;
            ProgressDialog.Update(1, Counter);
            ProgressDialog.Update(2, TotalMatchingIDs);

            // Use ModifyAll for batch update - much faster than individual Modify() calls
            CPMSStaging.Reset();
            CPMSStaging.SetRange("LOB Matching ID", MatchingID);
            CPMSStaging.SetRange("LOB Matching Status", CPMSStaging."LOB Matching Status"::Matched);
            if not CPMSStaging.IsEmpty() then
                CPMSStaging.ModifyAll("LOB Matching Status", CPMSStaging."LOB Matching Status"::Unmatched, false);

            // Use ModifyAll for batch update - much faster than individual Modify() calls
            LOBStaging1.Reset();
            LOBStaging1.SetRange("Matching ID", MatchingID);
            LOBStaging1.SetRange("Matching Status", LOBStaging1."Matching Status"::Matched);
            if not LOBStaging1.IsEmpty() then
                LOBStaging1.ModifyAll("Matching Status", LOBStaging1."Matching Status"::Unmatched, false);
        end;

        ProgressDialog.Close();
        Message(CompletedMsg, TotalMatchingIDs);
    end;

    procedure ToggleMatchedFilter(SetFilterOn: Boolean)
    begin
        if SetFilterOn then begin
            rec.SetRange("Matching Status");
            Rec.SetRange("Matching Status", Rec."Matching Status"::Unmatched)
        end else
            Rec.SetRange("Matching Status");
        CurrPage.Update();
    end;

    procedure ShowErroredRecord()
    begin
        rec.SetRange("Matching Status");
        Rec.SetRange("Matching Status", Rec."Matching Status"::Error);
        CurrPage.Update();
    end;

    procedure ShowMatchedRecord()
    begin
        rec.SetRange("Matching Status");
        Rec.SetRange("Matching Status", Rec."Matching Status"::Matched);
        CurrPage.Update();
    end;

    procedure ShowForceMatchedRecord()
    begin
        rec.SetRange("Matching Status");
        Rec.SetRange("Matching Status", Rec."Matching Status"::Matched);
        Rec.SetRange("Match Type", Rec."Match Type"::Force);
        CurrPage.Update();
    end;

    procedure GetSelectedRecords(var SelectedLOB: Record TTS_SAP temporary)
    var
        LOB: Record TTS_SAP;
    begin
        CurrPage.SetSelectionFilter(LOB);
        if LOB.FindSet() then
            repeat
                SelectedLOB := LOB;
                SelectedLOB.Insert();
            until LOB.Next() = 0;
    end;

    procedure SetSchemeFilter(Scheme: Code[20])
    begin
        gscheme := Scheme;
        Rec.FilterGroup(2);
        Rec.SetRange(Scheme, Scheme);
        Rec.FilterGroup(0);
        CurrPage.Update();
    end;

    var
        StyleExp: Text;
        Excludetype: Option LOB,"LOB-CPMS","CPMS-EOD";
        CommonFunctions: Codeunit "Common Functions";
        ExcludeAct, gscheme : Text;

}

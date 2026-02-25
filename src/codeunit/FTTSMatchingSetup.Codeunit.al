codeunit 85050 "FTTS Matching Setup"
{
    // This codeunit sets up matching rules for FTTS scheme between TTS_SAP and TTS_ARAP
    // It creates two rules:
    // 1. Parent rule: Filters by Scheme='FTTS' and Status=Unmatched/Error
    // 2. Child rule: Filters by Activity and matches PaymentReference to ReceiptNumber

    procedure SetupFTTSMatchingRules()
    var
        MatchingRules: Record "Matching Rules";
        ParentRuleNo: Integer;
        ChildRuleNo: Integer;
        ConfirmLbl: Label 'This will create or update FTTS matching rules. Do you want to continue?';
        SuccessLbl: Label 'FTTS matching rules have been set up successfully.\\Parent Rule No.: %1\\Child Rule No.: %2';
    begin
        if not Confirm(ConfirmLbl, false) then
            exit;

        // Find the next available rule numbers
        MatchingRules.Reset();
        if MatchingRules.FindLast() then
            ParentRuleNo := MatchingRules."Matching Rule No." + 1
        else
            ParentRuleNo := 1;

        ChildRuleNo := ParentRuleNo + 1;

        // Create Parent Rule - Filters by Scheme and Status
        CreateParentRule(ParentRuleNo);

        // Create Child Rule - Filters by Activity and matches fields
        CreateChildRule(ChildRuleNo, ParentRuleNo);

        Message(SuccessLbl, ParentRuleNo, ChildRuleNo);
    end;

    local procedure CreateParentRule(RuleNo: Integer)
    var
        MatchingRules: Record "Matching Rules";
        LOBCondition: Text;
        CPMSCondition: Text;
    begin
        // Build LOB (TTS_SAP) condition: Scheme='FTTS' AND (Status=Unmatched OR Status=Error)
        LOBCondition := 'WHERE(Scheme=FILTER(FTTS),Matching Status=FILTER(Unmatched|Error))';

        // Build CPMS (TTS_ARAP) condition: Scheme='FTTS' AND (LOB Matching Status=Unmatched OR LOB Matching Status=Error)
        CPMSCondition := 'WHERE(Scheme=FILTER(FTTS),LOB Matching Status=FILTER(Unmatched|Error))';

        // Create or update the parent rule
        // Field numbers: 10=PaymentReference (TTS_SAP), 17=ReceiptNumber (TTS_ARAP), 0=No Parent
        if MatchingRules.Get(RuleNo, MatchingRules."Matching Type"::"CPMS-LOB", 'FTTS', 10, 17, 0) then
            MatchingRules.Delete();

        MatchingRules.Init();
        MatchingRules."Matching Rule No." := RuleNo;
        MatchingRules."Matching Type" := MatchingRules."Matching Type"::"CPMS-LOB";
        MatchingRules.Scheme := 'FTTS';
        MatchingRules."LOB Field No." := 10; // PaymentReference field in TTS_SAP
        MatchingRules."LOB Field Name" := 'PaymentReference';
        MatchingRules."CPMS Field No." := 17; // ReceiptNumber field in TTS_ARAP
        MatchingRules."CPMS Field Name" := 'ReceiptNumber';
        MatchingRules."LOB Condition" := LOBCondition;
        MatchingRules."CPMS Condition" := CPMSCondition;
        MatchingRules."Parent Condition No." := 0; // This is a parent rule
        MatchingRules.Insert(true);
    end;

    local procedure CreateChildRule(RuleNo: Integer; ParentRuleNo: Integer)
    var
        MatchingRules: Record "Matching Rules";
        LOBCondition: Text;
        CPMSCondition: Text;
    begin
        // Build LOB (TTS_SAP) condition: Additional filter for Activity='INVOICE'
        LOBCondition := 'SORTING(PaymentReference) WHERE(Scheme=FILTER(FTTS),Matching Status=FILTER(Unmatched|Error),Activity=FILTER(INVOICE))';

        // Build CPMS (TTS_ARAP) condition: Additional filter for Activity='PAYMENT'
        CPMSCondition := 'SORTING(ReceiptNumber) WHERE(Scheme=FILTER(FTTS),LOB Matching Status=FILTER(Unmatched|Error),Activity=FILTER(PAYMENT))';

        // Create or update the child rule
        // Field numbers: 14=TestCostWithoutVat (TTS_SAP), 16=ReceiptAmount (TTS_ARAP), 0=No Parent
        if MatchingRules.Get(RuleNo, MatchingRules."Matching Type"::"CPMS-LOB", 'FTTS', 14, 16, 0) then
            MatchingRules.Delete();

        MatchingRules.Init();
        MatchingRules."Matching Rule No." := RuleNo;
        MatchingRules."Matching Type" := MatchingRules."Matching Type"::"CPMS-LOB";
        MatchingRules.Scheme := 'FTTS';
        MatchingRules."LOB Field No." := 14; // TestCostWithoutVat field in TTS_SAP
        MatchingRules."LOB Field Name" := 'TestCostWithoutVat';
        MatchingRules."CPMS Field No." := 16; // ReceiptAmount field in TTS_ARAP
        MatchingRules."CPMS Field Name" := 'ReceiptAmount';
        MatchingRules."LOB Condition" := LOBCondition;
        MatchingRules."CPMS Condition" := CPMSCondition;
        MatchingRules."Parent Condition No." := ParentRuleNo; // Link to parent rule
        MatchingRules.Insert(true);
    end;

    procedure DeleteFTTSMatchingRules()
    var
        MatchingRules: Record "Matching Rules";
        ConfirmLbl: Label 'This will delete all FTTS matching rules. Do you want to continue?';
        DeletedCount: Integer;
    begin
        if not Confirm(ConfirmLbl, false) then
            exit;

        MatchingRules.Reset();
        MatchingRules.SetRange(Scheme, 'FTTS');
        MatchingRules.SetRange("Matching Type", MatchingRules."Matching Type"::"CPMS-LOB");
        if MatchingRules.FindSet() then begin
            DeletedCount := MatchingRules.Count();
            MatchingRules.DeleteAll();
            Message('Deleted %1 FTTS matching rules.', DeletedCount);
        end else
            Message('No FTTS matching rules found to delete.');
    end;
}

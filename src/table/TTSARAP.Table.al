table 85001 "TTS_ARAP" //CPMS
{
    LookupPageId = "CPMS Records";
    DrillDownPageId = "CPMS Records";
    Caption = 'CPMS';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;

        }
        field(2; FinanceArapId; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'FinanceArapID';
            BlankZero = true;
        }
        field(3; Scheme; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));


        }
        field(4; Country; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country';
            TableRelation = "Country/Region".Code;
        }
        field(5; Activity; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
        field(6; InvoiceNumber; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvoiceNumber';
        }
        field(7; InvoiceDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'InvoiceDate';
        }
        field(8; RuleStartDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'RuleStartDate';
        }
        field(9; RuleDuration; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RuleDuration';
        }
        field(10; TaxCode; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'TaxCode';
        }
        field(11; TaxAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'TaxAmount';
        }
        field(12; InvoiceAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'InvoiceAmount';
        }
        field(13; LineIdentifier; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'LineIdentifier';
        }
        field(14; LineDescription; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'LineDescription';
        }
        field(15; LineAmountNet; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'LineAmountNet';
        }
        field(16; ReceiptAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'ReceiptAmount';
        }
        field(17; ReceiptNumber; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'ReceiptNumber';
        }
        field(18; ReceiptDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'ReceiptDate';
        }
        field(19; ReceiptGlDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'ReceiptGlDate';
        }
        field(20; ReceiptMethod; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'ReceiptMethod';
            TableRelation = CPMS_Payment_Method.Name;
        }
        field(21; ReceiptMatchAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'ReceiptMatchAmount';
        }
        field(22; CcReference; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'CcReference';
        }
        field(23; RefundAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'RefundAmount';
        }
        field(24; InvCustomerNumber; Text[100]) //code
        {
            DataClassification = ToBeClassified;
            Caption = 'InvCustomerNumber';
        }
        field(25; InvCustomerName; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvCustomerName';
        }
        field(26; InvAddressLine1; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvAddressLine1';
        }
        field(27; InvAddressLine2; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvAddressLine2';
        }
        field(28; InvAddressLine3; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvAddressLine3';
        }
        field(29; InvAddressLine4; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvAddressLine4';
        }
        field(30; InvCity; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvCity';
        }
        field(31; InvPostalCode; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvPostalCode';
        }
        field(32; InvReference; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvReference';
        }
        field(33; RecCustomerNumber; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'RecCustomerNumber';
        }
        field(34; RecCustomerName; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'RecCustomerName';
        }
        field(35; RecAddressLine1; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'RecAddressLine1';
        }
        field(36; RecAddressLine2; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'RecAddressLine2';
        }
        field(37; RecAddressLine3; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'RecAddressLine3';
        }
        field(38; RecAddressLine4; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'RecAddressLine4';
        }
        field(39; RecCity; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'RecCity';
        }
        field(40; RecPostalCode; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'RecPostalCode';
        }
        field(41; RecReference; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'RecReference';
        }
        field(42; SalesPerson; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'SalesPerson';
            trigger OnLookup()
            var
                SalesPersonRec: Record "Salesperson/Purchaser";
            begin
                if page.RunModal(page::"Salespersons/Purchasers", SalesPersonRec) = Action::LookupOK then
                    SalesPerson := SalesPersonRec.Name;
            end;
        }
        field(43; OrderReference; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'OrderReference';
        }
        field(44; PayingInBatchReference; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'PayingInBatchReference';
        }
        field(45; FileDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'FileDate';
        }
        field(46; TESTMATCH; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'TESTMATCH';
        }
        field(47; INVOICE; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'INVOICE';
        }
        field(48; ORIGIN; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'ORIGIN';
        }
        field(49; TestType; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'TestType';
        }
        field(85000; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Processed';
        }
        field(85002; "SAP Register No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'SAP Register No.';
            Editable = false;
            BlankZero = true;
            trigger OnLookup()
            var
                SAPRegister: Record SAP_Summary_Register;
            begin
                if Rec."SAP Register No." <> 0 then begin
                    SAPRegister.SetRange("Entry No.", Rec."SAP Register No.");
                    page.RunModal(Page::SAP_Summary_Register, SAPRegister);
                end;
            end;
        }
        field(85004; "Processed Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Processed Date';
        }
        field(85005; "Payment Authcode"; Text[100])
        {
            Caption = 'Payment Authcode';

        }
        field(85006; "Payment Provider"; Text[100])
        {
            Caption = 'Payment Provider';

        }
        field(85007; "Payment Result"; Text[100])
        {
            Caption = 'Payment Result';

        }
        field(85008; "Payee"; Text[100])
        {
            Caption = 'Payee';

        }
        field(85009; "LOB Matching Status"; Option)
        {
            OptionMembers = Matched,Unmatched,Error,;
            OptionCaption = 'Matched,Unmatched,Error';
            Caption = 'CPMS-LOB Matching Status';
            InitValue = Unmatched;
            trigger OnValidate()
            begin
                if Rec."LOB Matching Status" = Rec."LOB Matching Status"::Unmatched then begin
                    Clear("LOB Matching ID");
                    Clear("LOB Processed Date Time");
                    Clear("LOB Match Details");
                    Clear("LOB Match Type");
                    Clear("LOB Matched By");
                    Modify();
                end;
            end;

        }
        field(85010; "LOB Matching ID"; code[20])
        {
            Caption = 'CPMS-LOB Matching ID';
        }
        field(85011; "EOD Matching Status"; Option)
        {
            OptionMembers = Matched,Unmatched,Error,;
            OptionCaption = 'Matched,Unmatched,Error';
            Caption = 'CPMS-EOD Matching Status';
            InitValue = Unmatched;
            trigger OnValidate()
            begin
                if Rec."EOD Matching Status" = Rec."EOD Matching Status"::Unmatched then begin
                    Clear("EOD Matching ID");
                    Clear("EOD Processed Date Time");
                    Clear("EOD Match Details");
                    Clear("EOD Match Type");
                    Clear("EOD Matched By");
                    Modify();
                end;
            end;


        }
        field(85012; "EOD Matching ID"; code[20])
        {
            Caption = 'CPMS-EOD Matching ID';
        }
        field(85013; "LOB Processed Date Time"; DateTime)
        {
            Caption = 'LOB Processed DateTime';
        }
        field(85014; "EOD Processed Date Time"; DateTime)
        {
            Caption = 'EOD Processed DateTime';

        }
        field(85015; "LOB Rule No."; Integer)
        {
            Caption = 'Rule No.';
        }
        field(85016; "EOD Rule No."; Integer)
        {
            Caption = 'Rule No.';
        }
        field(85017; "EOD Match Details"; Text[1000])
        {

        }
        field(85018; "LOB Match Details"; Text[1000])
        {

        }
        field(85019; "Error Exists"; Boolean)
        {
            Fieldclass = flowfield;
            calcformula = exist(Integration_Errors where("Record Type" = filter(cpms), "Record Entry No." = field("Entry No.")));
        }
        field(50; "EOD Matched By"; Text[100])
        {
        }
        field(51; "LOB Matched By"; Text[100])
        {
        }
        field(52; "EOD Match Type"; Enum "Match Type")
        {

        }
        field(53; "LOB Match Type"; Enum "Match Type")
        {

        }
        field(54; "Source Activity-Origin"; Code[20])
        {
            Caption = 'Source Activity (Origin)';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
        field(55; "Synapse Error"; Boolean)
        {
        }
        field(56; "Synapse Error Description"; Text[250])
        {
        }
        field(57; "Source Identifier"; text[100])
        {
        }
        field(58; "Payment Duplicate"; Text[100])
        {

        }
        field(60; "Credit Acc No."; Text[100])
        {

        }
        field(61; "Debit Acc No."; Text[100])
        {

        }
        field(62; "Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        //don't use 63
        field(70; "Select"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "LOB Matching Status", "LOB Processed Date Time")
        {

        }
        key(Key3; "EOD Matching Status", "EOD Processed Date Time")
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }



    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        IntegrationError: Record Integration_Errors;
    begin
        IntegrationError.Reset;
        IntegrationError.setrange("Record Type", IntegrationError."Record Type"::CPMS);
        IntegrationError.SetRange("Record Entry No.", Rec."Entry No.");
        IntegrationError.DeleteAll();
    end;

    trigger OnRename()
    begin

    end;

}
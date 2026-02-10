table 85016 "TTS Unsummarised Lines" //FTTS
{
    LookupPageId = "TTS Unsummarised Records";
    DrillDownPageId = "TTS Unsummarised Records";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; FinanceSapId; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'FinanceSapId';
            BlankZero = true;

        }
        field(3; Scheme; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
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
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';


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
        field(8; InvoicePostingDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'InvoicePostingDate';
        }
        field(9; CustomerNumber; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'CustomerNumber';
        }
        field(10; PaymentReference; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'PaymentReference';
        }
        field(11; LineId; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'LineId';
            BlankZero = true;
        }
        field(12; Product; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Product';
            trigger OnLookup()
            var
                Item: Record Item;
            begin
                if page.RunModal(page::"Item List", Item) = Action::LookupOK then
                    Product := Item.Description;
            end;
        }
        field(13; TestReference; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'TestReference';
        }
        field(14; TestCostWithoutVat; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'TestCostWithoutVat';
        }
        field(15; OabTransferValueGross; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'OabTransferValueGross';
        }
        field(16; TestDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'TestDate';
        }
        field(17; SalesPerson; Code[20])
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
        field(18; InvCustomerName; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvCustomerName';
        }
        field(19; InvAddressLine1; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvAddressLine1';
        }
        field(20; InvAddressLine2; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvAdddressLine2';
        }
        field(21; InvAddressLine3; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvAddressLine3';
        }
        field(22; InvAddressLine4; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvAddressLine4';
        }
        field(23; InvCity; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvCity';
        }
        field(24; InvPostalCode; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'InvPostalCode';
        }
        field(25; LongText; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'LongText';
        }
        field(26; FileDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'FileDate';
        }
        field(27; INVOICE; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'INVOICE';

            trigger OnValidate()
            begin
                Rec.INVOICE := uppercase(Rec.INVOICE);
            end;
        }
        field(28; REFGOODS; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'REFGOODS';
        }
        field(29; file_duplicate; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'file_duplicate';
        }
        field(30; test_duplicate; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'test_duplicate';
        }
        field(31; REFUNDOAB; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'REFUNDOAB';
        }
        field(32; REVTESTM; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'REVTESTM';
        }
        field(33; TESTMATCH; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'TESTMATCH';

            trigger OnValidate()
            begin
                Rec.TESTMATCH := uppercase(Rec.TESTMATCH);
            end;
        }
        field(85000; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Processed';
        }
        field(85001; CLE_EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(85002; "SAP Register No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'SAP Register No.';
        }
        field(85003; "Imported Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Imported Date Time';
        }
        field(85005; "Matching Status"; Option)
        {
            OptionMembers = Matched,Unmatched,Error,;
            OptionCaption = 'Matched,Unmatched,Error';
            InitValue = Unmatched;
            trigger OnValidate()
            begin
                if Rec."Matching Status" = Rec."Matching Status"::Unmatched then begin
                    Clear("Matching ID");
                    Clear("Matching Processed Date Time");
                    Clear("Match Details");
                    Clear("Match Type");
                    Clear("Matched By");
                    Modify();
                end;
            end;
        }
        field(85006; "Matching ID"; code[20])
        {

        }
        field(85007; "Matching Processed Date Time"; DateTime)
        {

        }
        field(85008; "Rule No."; Integer)
        {

        }
        field(85009; "Match Details"; Text[1000])
        {

        }
        field(85010; "Error Exists"; Boolean)
        {
            Fieldclass = flowfield;
            calcformula = exist(Integration_Errors where("Record Type" = filter(LOB), "Record Entry No." = field("Entry No.")));
        }
        field(34; "Tax Amount"; Decimal)
        {

        }
        field(35; "Tax Code"; code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Line Amount Net"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Line Description"; Guid)
        {

        }
        field(38; "Order Reference"; Text[30])
        {

        }
        field(39; "Paying in Batch Ref"; Text[30])
        {
        }
        field(40; "Test Location"; Text[50])
        {
        }
        field(41; "Matched By"; Text[100])
        {
        }
        field(42; "Match Type"; Enum "Match Type")
        {

        }
        field(44; "Synapse Error"; Boolean)
        {
        }
        field(45; "Synapse Error Description"; Text[250])
        {
        }
        field(46; "Journal Entry No."; Integer)
        {
        }
        field(47; "Source Identifier"; text[100])
        {
        }
        field(48; "Credit Acc No."; Text[100])
        {

        }
        field(49; "Debit Acc No."; Text[100])
        {

        }
        field(51; "Processed Date"; Date)
        {
        }
        field(52; "Credit Entry No."; Integer)
        {
        }
        field(53; "Debit Entry No."; Integer)
        {
        }

        field(54; "Staging Entry No."; Integer)
        {
        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Matching Status", "Matching Processed Date Time")
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        TTS_SAP: Record "TTS Unsummarised Lines";
    begin
        TTS_SAP.Reset();
        if TTS_SAP.FindLast() then
            "Entry No." := TTS_SAP."Entry No." + 1
        else
            "Entry No." := 1;

        "Imported Date Time" := CurrentDateTime;
    end;

    trigger OnModify()
    begin

    end;





    trigger OnRename()
    begin

    end;
}
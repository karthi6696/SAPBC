table 85005 "SAP Journal Rules"
{
    Caption = 'SAP Journal Rules';

    fields
    {
        field(1; Scheme; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }
        field(2; "Country Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country Code';
            TableRelation = "Country/Region".Code;
        }
        field(3; "Source Activity"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
        field(4; "Material Code"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Material Code';
        }
        field(5; "SAP Account (Debit)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'SAP Account (Debit)';
            TableRelation = "G/L Account"."No.";
            trigger OnValidate()
            begin
                if rec."Material Code" then
                    if (Rec."SAP Account (Debit)" <> '') and (Rec."SAP Account (Credit)" <> '') then
                        Error('Record cannot have both a Debit and a Credit Account.');
            end;
        }
        field(6; "SAP Account (Credit)"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'SAP Account (Credit)';
            TableRelation = "G/L Account"."No.";
            trigger OnValidate()
            begin
                if rec."Material Code" then
                    if (Rec."SAP Account (Debit)" <> '') and (Rec."SAP Account (Credit)" <> '') then
                        Error('Mapping cannot have both a Debit and a Credit Account on this record.');
            end;
        }
        field(7; Notes; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Notes';
        }
        field(8; TestMatch; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'TestMatch';
        }
        field(9; RefundOAB; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'RefundOAB';
        }
        field(10; "Receipt Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Method';
            // TableRelation = CPMS_Payment_Method.Name;

            trigger OnLookup()
            var
                PaymentMethod: Record CPMS_Payment_Method;
                PaymentMethodPage: Page CPMS_Payment_Method;
                Lookupvalue: TextBuilder;
            begin
                PaymentMethodPage.LookupMode := true;
                if PaymentMethodPage.RunModal() = Action::LookupOK then begin
                    PaymentMethodPage.SetSelectionFilter(PaymentMethod);
                    if PaymentMethod.FindSet() then begin
                        repeat
                            Lookupvalue.Append(paymentMethod.Name + '|');
                        until PaymentMethod.Next() = 0;
#pragma warning disable AA0139
                        Rec."Receipt Method" := CopyStr(Lookupvalue.ToText(), 1, Lookupvalue.Length - 1)
#pragma warning restore AA0139
                    end;
                end;
            end;
        }
        field(11; TOPUP; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'TOPUP';
        }
        field(12; RefGoods; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'RefGoods';
        }
        field(13; "VAT Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Code';
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(14; "SAP Posting Key (Debit)"; Text[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'SAP Posting Key (Debit)';
            InitValue = '40';
        }
        field(15; "SAP Posting Key (Credit)"; Text[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'SAP Posting Key (Credit)';
            InitValue = '50';
        }
        field(16; "Source Activity-Origin"; Code[20])
        {
            Caption = 'Source Activity (Origin)';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
        field(17; "Type"; Enum Type)
        {
        }
        field(18; "No TestMatch"; Boolean)
        {
        }
        field(19; "Payment Duplicate"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Type, Scheme, "Country Code", "Source Activity", "Material Code", "Source Activity-Origin", "SAP Account (Debit)", "SAP Account (Credit)", "SAP Posting Key (Credit)", "SAP Posting Key (Debit)", "Receipt Method")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
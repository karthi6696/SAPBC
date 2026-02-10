page 85007 "SAP Journal Rules"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SAP Journal Rules";
    Caption = 'SAP Mapping';
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Scheme; Rec.Scheme)
                {
                }
                field("Country Code"; Rec."Country Code")
                {
                }
                field("Source Activity"; Rec."Source Activity")
                {
                }
                field("Material Code"; Rec."Material Code")
                {
                }
                field("Source Activity-Origin"; Rec."Source Activity-Origin")
                {
                    ToolTip = 'Specifies the value of the Source Activity (Origin) field.', Comment = '%';
                }
                field("SAP Account (Debit)"; Rec."SAP Account (Debit)")
                {
                }
                field("SAP Posting Key (Debit)"; Rec."SAP Posting Key (Debit)")
                {
                }
                field("SAP Account (Credit)"; Rec."SAP Account (Credit)")
                {
                }
                field("SAP Posting Key (Credit)"; Rec."SAP Posting Key (Credit)")
                {
                }
                field(Notes; Rec.Notes)
                {
                }
                field(TestMatch; Rec.TestMatch)
                {
                }
                field("No TestMatch"; Rec."No TestMatch")
                {
                    ToolTip = 'Specifies the value of the No TestMatch field.', Comment = '%';
                }
                field("Payment Duplicate"; Rec."Payment Duplicate")
                {
                    ToolTip = 'Specifies the value of the Payment Duplicate field.', Comment = '%';
                }
                field("Receipt Method"; Rec."Receipt Method")
                {
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}
page 85002 "Integration Setup"
{
    Caption = 'Integration Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("TestType Validation Activity"; Rec."TestType Validation Activity")
                {

                }

            }
            group("Integration Setup")
            {
                Visible = false;
                group("TTS SAP")
                {
                    field("TTS SAP Retention Policy"; Rec."TTS SAP Retention Policy")
                    {
                        ToolTip = 'Specifies the value of the TTS SAP Retention Policy field.';
                        Visible = false;
                    }
                    // field("TTS Activity"; Rec."Exclude TTS Activity")
                    // {
                    //     ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = '%';
                    // }
                }
                group("CPMS")
                {
                    field("TTS ARAP Retention Policy"; Rec."TTS ARAP Retention Policy")
                    {
                        ToolTip = 'Specifies the value of the TTS ARAP Retention Policy field.';
                        Visible = false;
                    }
                    // field("CPMS Activity"; Rec."Exclude TTS-CPMS Activity")
                    // {
                    //     ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = '%';
                    // }
                    // field("Exclude CPMS-EOD Activity"; Rec."Exclude CPMS-EOD Activity")
                    // {
                    //     ToolTip = 'Specifies the value of the Exclude CPMS-EOD Activity field.', Comment = '%';
                    // }
                }
            }
            group(SAPJournalErr)
            {
                Caption = 'SAP Journal Error Email Setup';

                field("Email Subject"; Rec."Email Subject")
                {
                    ToolTip = 'Specifies the value of the Email Subject field.', Comment = '%';
                }
                field("To Email"; Rec."To Email")
                {
                    ToolTip = 'Specifies the value of the To Email field.', Comment = '%';
                }

            }
            group("BIN SAPJournalBody")
            {
                Caption = 'Email Notification Body';
                field("Richtext"; RichTextNBVar)
                {
                    ShowCaption = false;
                    MultiLine = true;
                    ExtendedDatatype = RichContent;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notification Body field.';
                    trigger OnValidate()
                    begin
                        rec.SetSAPJournalNBText(RichTextNBVar);
                    end;
                }
            }
            group(SynapseErr)
            {
                Caption = 'Synapse Error Email Setup';

                field("Syn. Err. Email Subject"; Rec."Syn. Err. Email Subject")
                {
                    Caption = 'Email Subject';
                    ToolTip = 'Specifies the value of the Syn. Err. Email Subject field.', Comment = '%';
                }
                field("Syn. Err. File To Email"; Rec."Syn. Err. File To Email")
                {
                    Caption = 'To Email';
                    ToolTip = 'Specifies the value of the Syn. Err. File To Email field.', Comment = '%';
                }
            }
            group("SynapseBody")
            {
                Caption = 'Synapse Email Notification Body';
                field(Synbody; RichTextSynapse)
                {
                    MultiLine = true;
                    ShowCaption = false;
                    ExtendedDatatype = RichContent;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notification Body field.';
                    trigger OnValidate()
                    begin
                        rec.SetSynErrNBText(RichTextSynapse);
                    end;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Exclude Matching Activities")
            {
                ApplicationArea = All;
                Image = RemoveFilterLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Exclude Matching Activities";
            }

            action("Matching Rules")
            {
                ApplicationArea = All;
                Image = MapSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Matching Rules";
                ToolTip = 'Executes the Matching Rules action.';
            }
            action("SAP_Mapping")
            {
                ApplicationArea = All;
                Caption = 'SAP Journal Rules';
                Image = MapSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "SAP Journal Rules";
                ToolTip = 'Executes the SAP Journal Rules action.';
            }
            action("Payment Method")
            {
                ApplicationArea = All;
                Caption = 'CPMS Payment Method';
                Image = MapSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page CPMS_Payment_Method;
            }
            action("G/L Accounts")
            {
                ApplicationArea = All;
                Image = ChartOfAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Chart of Accounts";
            }
            action("Items")
            {
                ApplicationArea = All;
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Item List";
            }
            action("Salespersons")
            {
                ApplicationArea = All;
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Salespersons/Purchasers";
            }
            action("Country/Regions")
            {
                ApplicationArea = All;
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Countries/Regions";
            }
            action("No. Series")
            {
                ApplicationArea = All;
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "No. Series";
            }
            action("GL Setup")
            {
                ApplicationArea = All;
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "General Ledger Setup";
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        RichTextNBVar := Rec.GetSAPJournalNBText();
        RichTextSynapse := Rec.GetSynErrNBText();
    end;


    var
        RichTextNBVar, RichTextSynapse : Text;

}
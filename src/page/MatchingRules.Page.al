page 85021 "Matching Rules"
{
    ApplicationArea = All;
    Caption = 'Matching Rules';
    PageType = List;
    SourceTable = "Matching Rules";
    SourceTableView = sorting("Matching Rule No.") order(ascending);
    UsageCategory = Lists;
    DelayedInsert = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Matching Rule No."; Rec."Matching Rule No.")
                {
                    ToolTip = 'Specifies the value of the Matching Rule No. field.', Comment = '%';

                }
                field("Matching Type"; Rec."Matching Type")
                {
                    ToolTip = 'Specifies the value of the Matching Type field.', Comment = '%';
                    trigger OnValidate()
                    begin
                        MakeLOBEODUneditable();
                        CurrPage.Update();
                    end;
                }
                field(Scheme; Rec.Scheme)
                {
                    ToolTip = 'Specifies the value of the Scheme field.', Comment = '%';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
                }
                field("LOB Condition"; Rec."LOB Condition")
                {
                    ToolTip = 'Specifies the value of the LOB Condition field.', Comment = '%';
                    Editable = MakeLOBUnEditable;
                    trigger OnDrillDown()
                    var
                        LOBPage: FilterPageBuilder;
                        LOBRec: Record TTS_SAP;
                    begin
                        if (Rec."Matching Type" = Rec."Matching Type"::"CPMS-EOD") or (not CurrPage.Editable) then
                            Error('');

                        Clear(LOBPage);
                        LOBPage.AddRecord('LOB', LOBRec);
                        if Rec."LOB Condition" <> '' then
                            LOBPage.SetView('LOB', Rec."LOB Condition");
                        LOBPage.PageCaption := 'LOB Conditions';
                        if LOBPage.RunModal() then
                            Rec."LOB Condition" := LOBPage.GetView('LOB');

                    end;

                    trigger OnValidate()
                    var
                        LOBRec: Record TTS_SAP;
                    begin
                        LOBRec.SetView(Rec."LOB Condition");
                    end;
                }
                field("LOB Field Name"; Rec."LOB Field Name")
                {
                    ToolTip = 'Specifies the value of the LOB Field Name field.', Comment = '%';
                    Editable = MakeLOBUnEditable;

                }
                field("LOB Filter"; Rec."LOB Filter")
                {
                    ToolTip = 'Specifies the value of the LOB Filter field.', Comment = '%';
                    Editable = MakeLOBUnEditable;
                    Visible = false;
                }
                field("Parent Condition"; Rec."Parent Condition No.")
                {
                    ToolTip = 'Specifies the value of the Parent Condition field.', Comment = '%';
                }
                field("CPMS Condition"; Rec."CPMS Condition")
                {
                    ToolTip = 'Specifies the value of the CPMS Condition field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        CPMSPage: FilterPageBuilder;
                        CPMSRec: Record TTS_ARAP;
                    begin
                        if (not CurrPage.Editable) then
                            exit;

                        Clear(CPMSPage);
                        CPMSPage.AddRecord('CPMS', CPMSRec);
                        if Rec."CPMS Condition" <> '' then
                            CPMSPage.SetView('CPMS', Rec."CPMS Condition");
                        CPMSPage.PageCaption := 'CPMS Conditions';
                        if CPMSPage.RunModal() then
                            Rec."CPMS Condition" := CPMSPage.GetView('CPMS');
                    end;

                    trigger OnValidate()
                    var
                        CPMSRec: Record TTS_ARAP;
                    begin
                        CPMSRec.SetView(Rec."CPMS Condition");
                    end;
                }
                field("CPMS Field Name"; Rec."CPMS Field Name")
                {
                    ToolTip = 'Specifies the value of the CPMS Field Name field.', Comment = '%';

                }
                field("CPMS Filter"; Rec."CPMS Filter")
                {
                    ToolTip = 'Specifies the value of the CPMS Filter field.', Comment = '%';
                    Visible = false;
                }
                field("EOD Condition"; Rec."EOD Condition")
                {
                    ToolTip = 'Specifies the value of the EOD Condition field.', Comment = '%';
                    Editable = MakeEODUnEditable;
                    trigger OnDrillDown()
                    var
                        EODPage: FilterPageBuilder;
                        EODRec: Record "EOD Staging";
                    begin
                        if (Rec."Matching Type" = Rec."Matching Type"::"CPMS-LOB") or (not CurrPage.Editable) then
                            Error('');

                        Clear(EODPage);
                        EODPage.AddRecord('EOD', EODRec);
                        if Rec."EOD Condition" <> '' then
                            EODPage.SetView('EOD', Rec."EOD Condition");
                        EODPage.PageCaption := 'EOD Conditions';
                        if EODPage.RunModal() then
                            Rec."EOD Condition" := EODPage.GetView('EOD');
                    end;

                    trigger OnValidate()
                    var
                        EODRec: Record "EOD Staging";
                    begin
                        EODRec.SetView(Rec."EOD Condition");
                    end;
                }
                field("EOD Field Name"; Rec."EOD Field Name")
                {
                    ToolTip = 'Specifies the value of the EOD Field Name field.', Comment = '%';
                    Editable = MakeEODUnEditable;
                }
                field("EOD Filter"; Rec."EOD Filter")
                {
                    ToolTip = 'Specifies the value of the CPMS Filter field.', Comment = '%';
                    Editable = MakeEODUnEditable;
                    Visible = false;

                }
            }
        }
    }



    trigger OnOpenPage()
    begin
        CommonFunctions.AllowonlySuperUser();
    end;

    trigger OnAfterGetRecord()
    begin
        MakeLOBEODUneditable();
    end;

    local procedure MakeLOBEODUneditable()
    begin
        MakeEODUnEditable := false;
        MakeLOBUnEditable := false;

        if Rec."Matching Type" = Rec."Matching Type"::"CPMS-EOD" then
            MakeEODUnEditable := true;
        if Rec."Matching Type" = Rec."Matching Type"::"CPMS-LOB" then
            MakeLOBUnEditable := true;
    end;

    var
        MakeEODUnEditable, MakeLOBUnEditable : Boolean;
        CommonFunctions: Codeunit "Common Functions";
}

page 85010 "DVSA_Integration_Activities"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = DVSA_Activities;
    Caption = 'DVSA TTS Integration Activities';

    layout
    {
        area(Content)
        {
            cuegroup("Incoming TTS / CPMS Data")
            {
                Caption = 'Incoming Data';

                field("TTS SAP"; Rec."TTS SAP")
                {
                    ToolTip = 'Specifies the value of the Unprocessed TTS field.';

                }
                field("TTS ARAP"; Rec."TTS ARAP")
                {
                    ToolTip = 'Specifies the value of the Unprocessed CPMS field.';
                    MultiLine = true;
                }
                field("EOD"; Rec."EOD")
                {
                    ToolTip = 'Specifies the value of the Unprocessed EOD field.';
                }

            }
            cuegroup("TTS / CPMS / EOD Error Data")
            {
                Caption = 'Matching Error Data';
                Visible = false;
                field("TTS"; ErrTTSMatching)
                {
                    Style = Unfavorable;
                    ToolTip = 'Specifies the value of the Error TTS field.';
                    trigger OnDrillDown()
                    begin
                        RunTTSLookup(gMatchStatus::Error, false);
                    end;
                }
                field("ErrCPMS"; ErrTTSCPMSMatching)
                {
                    Style = Unfavorable;
                    ToolTip = 'Specifies the value of the Error LOB-CPMS field.';
                    Caption = 'LOB-CPMS';
                    trigger OnDrillDown()
                    var
                        LOBCPMSMatch: Page "LOB-CPMS Matching";
                    begin
                        Clear(LOBCPMSMatch);
                        LOBCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Error);
                        LOBCPMSMatch.Run();
                    end;
                }
                field("Error EOD ARAP"; ErrCPMSEODMatching)
                {
                    ToolTip = 'Specifies the value of the Error EOD-CPMS field.', Comment = '%';
                    Style = Unfavorable;
                    Caption = 'CPMS-EOD';
                    trigger OnDrillDown()
                    var
                        EODCPMSMatch: Page "EOD-CPMS Matching";
                    begin
                        Clear(EODCPMSMatch);
                        EODCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Error);
                        EODCPMSMatch.Run();
                    end;
                }

                field("Error EOD"; Rec."Error EOD")
                {
                    ToolTip = 'Specifies the value of the Error EOD field.', Comment = '%';
                    Style = Unfavorable;
                }
            }


            cuegroup("Force Match")
            {

                field("Force TTS SAP"; ForceTTSMatching)
                {
                    ToolTip = 'Specifies the value of the TTS field.', Comment = '%';
                    Caption = 'LOB';
                    trigger OnDrillDown()
                    begin
                        RunTTSLookup(gMatchStatus::Matched, true);
                    end;
                }
                field("Force TTS ARAP"; ForceTTSCPMSMatching)
                {
                    ToolTip = 'Specifies the value of the CPMS field.', Comment = '%';
                    Caption = 'LOB-CPMS';
                    trigger OnDrillDown()
                    var
                        LOBCPMSMatch: Page "LOB-CPMS Matching";
                    begin
                        Clear(LOBCPMSMatch);
                        LOBCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Force);
                        LOBCPMSMatch.Run();
                    end;
                }
                field("Force EOD ARAP"; ForceCPMSEODMatching)
                {
                    ToolTip = 'Specifies the value of the EOD-CPMS field.', Comment = '%';
                    Caption = 'CPMS-EOD';
                    trigger OnDrillDown()
                    var
                        EODCPMSMatch: Page "EOD-CPMS Matching";
                    begin
                        Clear(EODCPMSMatch);
                        EODCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Force);
                        EODCPMSMatch.Run();
                    end;
                }
                field("Force EOD"; Rec."Force EOD")
                {
                    ToolTip = 'Specifies the value of the EOD field.', Comment = '%';
                }
            }
            cuegroup("Unmatched Transactions")
            {
                field("Unmatched TTS"; UnmatTTSMatching)
                {
                    Caption = 'LOB';
                    ToolTip = 'Specifies the value of the Unmatched TTS field.';
                    trigger OnDrillDown()
                    begin
                        RunTTSLookup(gMatchStatus::UnMatched, false);
                    end;
                }
                field("Unmatched TTS-CPMS"; UnmatTTSCPMSMatching)
                {
                    ToolTip = 'Specifies the value of the UnMatched LOB-CPMS field.', Comment = '%';
                    Caption = 'LOB-CPMS';
                    trigger OnDrillDown()
                    var
                        LOBCPMSMatch: Page "LOB-CPMS Matching";
                    begin
                        Clear(LOBCPMSMatch);
                        LOBCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Unmatched);
                        LOBCPMSMatch.Run();
                    end;
                }
                field("Unmatched EOD-CPMS"; UnmatCPMSEODMatching)
                {
                    ToolTip = 'Specifies the value of the UnMatched EOD-CPMS field.', Comment = '%';
                    Caption = 'CPMS-EOD';
                    trigger OnDrillDown()
                    var
                        EODCPMSMatch: Page "EOD-CPMS Matching";
                    begin
                        Clear(EODCPMSMatch);
                        EODCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Unmatched);
                        EODCPMSMatch.Run();
                    end;
                }
                field("Unmatched EOD"; Rec."Unmatched EOD")
                {
                    ToolTip = 'Specifies the value of the Unmatched EOD field.', Comment = '%';
                }

            }
            cuegroup("Matched Transactions")
            {
                field("Matched TTS"; MatchedTTSMatching)
                {
                    ToolTip = 'Specifies the value of the Matched TTS field.', Comment = '%';
                    Caption = 'LOB';
                    trigger OnDrillDown()
                    begin
                        RunTTSLookup(gMatchStatus::Matched, false);
                    end;
                }
                field("TTS-CPMS"; MatchedTTSCPMSMatching)
                {
                    ToolTip = 'Specifies the value of the Matched LOB-CPMS field.', Comment = '%';
                    Caption = 'LOB-CPMS';
                    trigger OnDrillDown()
                    var
                        LOBCPMSMatch: Page "LOB-CPMS Matching";
                    begin
                        Clear(LOBCPMSMatch);
                        LOBCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Matched);
                        LOBCPMSMatch.Run();
                    end;
                }
                field("CPMS-EOD"; MatchedCPMSEODMatching)
                {
                    ToolTip = 'Specifies the value of the Matched EOD-CPMS field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        EODCPMSMatch: Page "EOD-CPMS Matching";
                    begin
                        Clear(EODCPMSMatch);
                        EODCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Matched);
                        EODCPMSMatch.Run();
                    end;
                }
                field("Matched EOD"; Rec."Matched EOD")
                {
                    ToolTip = 'Specifies the value of the Matched EOD field.', Comment = '%';
                }
            }
            cuegroup("Synapse Error Data")
            {
                field("Synapse TTS Error"; Rec."Synapse TTS Error")
                {
                    Caption = 'LOB';
                    ToolTip = 'Specifies the value of the Synapse TTS Error field.', Comment = '%';
                }
                field("Synapse CPMS Error"; Rec."Synapse CPMS Error")
                {
                    Caption = 'CPMS';
                    ToolTip = 'Specifies the value of the Synapse CPMS Error field.', Comment = '%';
                }
                field("Synapse EOD Error"; Rec."Synapse EOD Error")
                {
                    Caption = 'EOD';
                    ToolTip = 'Specifies the value of the Synapse EOD Error field.', Comment = '%';
                }
            }
            cuegroup("Invalid Staging Data")
            {

                field("Validation TTS Error"; Rec."Validation TTS Error")
                {
                    Caption = 'LOB';
                    ToolTip = 'Specifies the value of the Validation TTS Error field.', Comment = '%';
                }
                field("Validation CPMS Error"; Rec."Validation CPMS Error")
                {
                    Caption = 'CPMS';
                    ToolTip = 'Specifies the value of the Validation CPMS Error field.', Comment = '%';
                }
                field("Validation EOD Error"; Rec."Validation EOD Error")
                {
                    Caption = 'EOD';
                    ToolTip = 'Specifies the value of the Validation EOD Error field.', Comment = '%';
                }
            }
            cuegroup("SAP Exports")
            {
                field("SAP Registers TTS"; Rec."SAP Registers TTS")
                {
                    Caption = 'LOB Registers';
                    ToolTip = 'Specifies the value of the SAP TTS Registers field.';
                }
                field("SAP Registers CPMS"; Rec."SAP Registers CPMS")
                {
                    Caption = 'CPMS Registers';
                    ToolTip = 'Specifies the value of the SAP CPMS Registers field.';
                }
            }
            cuegroup("Processed SAP Journal")
            {

                field("Processed TTS"; Rec."Processed TTS Journal")
                {
                    ToolTip = 'Specifies the value of the Processed TTS Journal field.', Comment = '%';
                    Caption = 'LOB';
                }
                field("Processed CPMS"; Rec."Processed CPMS Journal")
                {
                    ToolTip = 'Specifies the value of the Processed CPMS Journal field.', Comment = '%';
                    Caption = 'CPMS';
                }
            }
            cuegroup("Unprocessed SAP Journal")
            {

                field("Unprocessed TTS Journal"; Rec."Unprocessed TTS Journal")
                {
                    ToolTip = 'Specifies the value of the Unprocessed TTS Journal field.', Comment = '%';
                    Caption = 'LOB';
                }
                field("Unprocessed CPMS Journal"; Rec."Unprocessed CPMS Journal")
                {
                    ToolTip = 'Specifies the value of the Unprocessed CPMS Journal field.', Comment = '%';
                    Caption = 'CPMS';
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        IntegrationSetup.Get();
        //  gscheme := 'FTTS';
        Clear(ForceFilter);
        Clear(ErrTTSMatching);
        Clear(ErrCPMSEODMatching);
        Clear(ErrTTSCPMSMatching);
        Clear(ForceCPMSEODMatching);
        Clear(ForceTTSCPMSMatching);
        Clear(ForceTTSMatching);
        Clear(MatchedCPMSEODMatching);
        Clear(MatchedTTSCPMSMatching);
        Clear(MatchedTTSMatching);
        Clear(UnmatCPMSEODMatching);
        Clear(UnmatTTSCPMSMatching);
        Clear(UnmatTTSMatching);

        ErrTTSMatching := GetTTSCount(gMatchStatus::Error);
        ErrCPMSEODMatching := GetCPMSEODCount(gMatchStatus::Error);
        ErrTTSCPMSMatching := GetCPMSLOBCount(gMatchStatus::Error);

        MatchedTTSMatching := GetTTSCount(gMatchStatus::Matched);
        MatchedCPMSEODMatching := GetCPMSEODCount(gMatchStatus::Matched);
        MatchedTTSCPMSMatching := GetCPMSLOBCount(gMatchStatus::Matched);

        UnmatTTSMatching := GetTTSCount(gMatchStatus::Unmatched);
        UnmatCPMSEODMatching := GetCPMSEODCount(gMatchStatus::Unmatched);
        UnmatTTSCPMSMatching := GetCPMSLOBCount(gMatchStatus::Unmatched);

        ForceFilter := true;
        ForceTTSMatching := GetTTSCount(gMatchStatus::Matched);
        ForceCPMSEODMatching := GetCPMSEODCount(gMatchStatus::Matched);
        ForceTTSCPMSMatching := GetCPMSLOBCount(gMatchStatus::Matched);
    end;

    local procedure GetTTSCount(poption: Option Matched,Unmatched,Error,Force): Integer
    begin
        ExcludeAct := CommonFunctions.ExcludeActivity(gscheme, Excludetype::"LOB");

        TTS.Reset();
        TTS.SetRange("Matching Status", poption);
        if ExcludeAct <> '' then
            tts.SetFilter(Activity, ExcludeAct);
        if gscheme <> '' then
            tts.SetFilter(Scheme, gscheme);
        if ForceFilter then
            tts.SetRange("Match Type", tts."Match Type"::Force);
        exit(tts.Count)
    end;

    local procedure GetCPMSEODCount(poption: Option Matched,Unmatched,Error,Force): Integer
    begin
        ExcludeAct := CommonFunctions.ExcludeActivity(gscheme, Excludetype::"CPMS-EOD");
        CPMS.Reset();
        CPMS.SetRange("EOD Matching Status", poption);
        if ExcludeAct <> '' then
            CPMS.SetFilter(Activity, ExcludeAct);
        if gscheme <> '' then
            CPMS.SetFilter(Scheme, gscheme);
        if ForceFilter then
            CPMS.SetRange("EOD Match Type", CPMS."EOD Match Type"::Force);
        exit(CPMS.Count)
    end;

    local procedure GetCPMSLOBCount(poption: Option Matched,Unmatched,Error,Force): Integer
    begin
        ExcludeAct := CommonFunctions.ExcludeActivity(gscheme, Excludetype::"LOB-CPMS");
        CPMS.Reset();
        CPMS.SetRange("LOB Matching Status", poption);
        if ExcludeAct <> '' then
            CPMS.SetFilter(Activity, ExcludeAct);
        if gscheme <> '' then
            CPMS.SetFilter(Scheme, gscheme);
        if ForceFilter then
            CPMS.SetRange("LOB Match Type", CPMS."LOB Match Type"::Force);
        exit(CPMS.Count)
    end;

    local procedure RunTTSLookup(poption: Option Matched,Unmatched,Error; Force: Boolean)
    begin
        ExcludeAct := CommonFunctions.ExcludeActivity(gscheme, Excludetype::"LOB");

        TTS.Reset();
        TTS.SetRange("Matching Status", poption);
        if ExcludeAct <> '' then
            tts.SetFilter(Activity, ExcludeAct);
        if gscheme <> '' then
            tts.SetFilter(Scheme, gscheme);
        if Force then
            tts.SetRange("Match Type", tts."Match Type"::Force);
        Page.Run(Page::"TTS Records", tts);
    end;

    var
        ForceFilter: Boolean;
        IntegrationSetup: Record "Integration Setup";
        gMatchStatus: Option Matched,Unmatched,Error,Force;
        TTS: Record TTS_SAP;
        CPMS: Record TTS_ARAP;
        EOD: Record "EOD Staging";
        MatchedLOBCPMS, MatchedEODCPMS, ErrTTSMatching, ErrTTSCPMSMatching, ErrCPMSEODMatching, ForceTTSMatching, ForceTTSCPMSMatching, ForceCPMSEODMatching,
        UnmatTTSMatching, UnmatTTSCPMSMatching, UnmatCPMSEODMatching, MatchedTTSMatching, MatchedTTSCPMSMatching, MatchedCPMSEODMatching : Integer;

        Excludetype: Option LOB,"LOB-CPMS","CPMS-EOD";
        CommonFunctions: Codeunit "Common Functions";
        ExcludeAct, gscheme : Text;

}
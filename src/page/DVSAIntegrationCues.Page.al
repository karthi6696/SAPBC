page 85044 "DVSA_Integration_Cues"
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

                actions
                {
                    action("LOBIncoming")
                    {
                        ApplicationArea = All;
                        Caption = 'LOB';
                        Image = TileReport;
                        RunObject = page "TTS Records";
                    }
                    action("CPMSInocoming")
                    {
                        ApplicationArea = All;
                        Caption = 'CPMS';
                        Image = TileReport;
                        RunObject = page "CPMS Records";
                    }
                    action("EODIncoming")
                    {
                        ApplicationArea = All;
                        Caption = 'EOD';
                        Image = TileReport;
                        RunObject = page "EOD Staging";

                    }
                }
            }

            cuegroup("Force Match")
            {

                actions
                {
                    action(LOBForceMatch)
                    {
                        ApplicationArea = All;
                        Caption = 'LOB';
                        Image = TileReport;
                        trigger OnAction()
                        begin
                            RunTTSLookup(gMatchStatus::Matched, true);
                        end;
                    }
                    action(TTSCPMSForceMatch)
                    {
                        ApplicationArea = All;
                        Caption = 'LOB-CPMS';
                        Image = TileReport;
                        trigger OnAction()
                        var
                            LOBCPMSMatch: Page "LOB-CPMS Matching";
                        begin
                            Clear(LOBCPMSMatch);
                            LOBCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Force);
                            LOBCPMSMatch.Run();
                        end;
                    }

                    action(CPMSForceMatch)
                    {
                        ApplicationArea = All;
                        Caption = 'CPMS-EOD';
                        Image = TileReport;
                        trigger OnAction()
                        var
                            EODCPMSMatch: Page "EOD-CPMS Matching";
                        begin
                            Clear(EODCPMSMatch);
                            EODCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Force);
                            EODCPMSMatch.Run();
                        end;
                    }
                    action(EODForceMatch)
                    {
                        ApplicationArea = All;
                        Caption = 'EOD';
                        Image = TileReport;
                        RunObject = page "EOD Staging";
                        RunPageView = where("Match Type" = filter(Force));
                    }

                }
            }
            cuegroup("Unmatched Transactions")
            {
                actions
                {
                    action(LOBUnmatched)
                    {
                        ApplicationArea = all;
                        Caption = 'LOB';
                        Image = TileReport;
                        trigger OnAction()
                        begin
                            RunTTSLookup(gMatchStatus::UnMatched, false);
                        end;
                    }
                    action(TTSCPMSUnmatched)
                    {
                        ApplicationArea = all;
                        Caption = 'LOB-CPMS';
                        Image = TileReport;
                        trigger OnAction()
                        var
                            LOBCPMSMatch: Page "LOB-CPMS Matching";
                        begin
                            Clear(LOBCPMSMatch);
                            LOBCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::UnMatched);
                            LOBCPMSMatch.Run();
                        end;
                    }
                    action(CPMSEODUnmatched)
                    {
                        ApplicationArea = all;
                        Caption = 'CPMS-EOD';
                        Image = TileReport;
                        trigger OnAction()
                        var
                            EODCPMSMatch: Page "EOD-CPMS Matching";
                        begin
                            Clear(EODCPMSMatch);
                            EODCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::UnMatched);
                            EODCPMSMatch.Run();
                        end;
                    }
                    action(EODUnmatched)
                    {
                        ApplicationArea = all;
                        Caption = 'EOD';
                        Image = TileReport;
                        RunObject = page "EOD Staging";
                        RunPageView = where("Matching Status" = filter(UnMatched));
                    }
                }

            }
            cuegroup("Matched Transactions")
            {
                actions
                {
                    action(MatchedLOB)
                    {
                        applicationArea = all;
                        Caption = 'LOB';
                        Image = TileReport;
                        trigger OnAction()
                        begin
                            RunTTSLookup(gMatchStatus::Matched, false);
                        end;
                    }
                    action(TTSCPMSMatched)
                    {
                        ApplicationArea = all;
                        Caption = 'LOB-CPMS';
                        Image = TileReport;
                        trigger OnAction()
                        var
                            LOBCPMSMatch: Page "LOB-CPMS Matching";
                        begin
                            Clear(LOBCPMSMatch);
                            LOBCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Matched);
                            LOBCPMSMatch.Run();
                        end;
                    }
                    action(CPMSEODMatched)
                    {
                        ApplicationArea = all;
                        Caption = 'CPMS-EOD';
                        Image = TileReport;
                        trigger OnAction()
                        var
                            EODCPMSMatch: Page "EOD-CPMS Matching";
                        begin
                            Clear(EODCPMSMatch);
                            EODCPMSMatch.SkipSchemeSelectionAndApplyMatchFilter(gMatchStatus::Matched);
                            EODCPMSMatch.Run();
                        end;
                    }
                    action(EODMatched)
                    {
                        ApplicationArea = all;
                        Caption = 'EOD';
                        Image = TileReport;
                        RunObject = page "EOD Staging";
                        RunPageView = where("Matching Status" = filter(Matched));
                    }
                }

            }
            cuegroup("Synapse Error Data")
            {
                actions
                {
                    action(LOBError)
                    {
                        ApplicationArea = all;
                        Caption = 'LOB';
                        Image = TileReport;
                        RunObject = page "TTS Records";
                        RunPageView = where("Synapse Error" = const(true));
                    }
                    action(CPMSerror)
                    {
                        ApplicationArea = all;
                        Caption = 'CPMS';
                        Image = TileReport;
                        RunObject = page "CPMS Records";
                        RunPageView = where("Synapse Error" = const(true));
                    }
                    action(EODError)
                    {
                        ApplicationArea = all;
                        Caption = 'EOD';
                        Image = TileReport;
                        RunObject = page "EOD Staging";
                        RunPageView = where("Synapse Error" = const(true));
                    }
                }

            }
            cuegroup("Invalid Staging Data")
            {

                actions
                {
                    action(LOBInvalid)
                    {
                        ApplicationArea = all;
                        Caption = 'LOB';
                        Image = TileReport;
                        RunObject = page "TTS Records";
                        RunPageView = where("Error Exists" = const(true));
                    }
                    action(CPMSInvalid)
                    {
                        ApplicationArea = all;
                        Caption = 'CPMS';
                        Image = TileReport;
                        RunObject = page "CPMS Records";
                        RunPageView = where("Error Exists" = const(true));
                    }
                    action(EODInvalid)
                    {
                        ApplicationArea = all;
                        Caption = 'EOD';
                        Image = TileReport;
                        RunObject = page "EOD Staging";
                        RunPageView = where("Error Exists" = const(true));
                    }
                }
            }
            cuegroup("SAP Exports")
            {
                actions
                {
                    action(LOBRegisters)
                    {
                        ApplicationArea = all;
                        Caption = 'LOB Registers';
                        Image = TileReport;
                        RunObject = page SAP_Summary_Register;
                        RunPageView = where("Type" = filter(LOB));
                    }
                    action(CPMSRegisters)
                    {
                        ApplicationArea = all;
                        Caption = 'CPMS Registers';
                        Image = TileReport;
                        RunObject = page SAP_Summary_Register;
                        RunPageView = where("Type" = filter(CPMS));
                    }
                }
            }
            cuegroup("Processed SAP Journal")
            {

                actions
                {
                    action("Processed TTS")
                    {
                        ApplicationArea = all;
                        Caption = 'LOB';
                        Image = TileReport;
                        RunObject = page "TTS Records";
                        RunPageView = where(Posted = filter(true));
                    }
                    action("Processed CPMS")
                    {
                        ApplicationArea = all;
                        Caption = 'CPMS';
                        Image = TileReport;
                        RunObject = page "CPMS Records";
                        RunPageView = where(Posted = filter(true));
                    }
                }

            }
            cuegroup("Unprocessed SAP Journal")
            {

                actions
                {
                    action(UnprocesseedTTS)
                    {
                        ApplicationArea = all;
                        Caption = 'LOB';
                        Image = TileReport;
                        RunObject = page "TTS Records";
                        RunPageView = where(Posted = filter(false));
                    }
                    action(UnprocessedCPMS)
                    {
                        ApplicationArea = all;
                        Caption = 'CPMS';
                        Image = TileReport;
                        RunObject = page "CPMS Records";
                        RunPageView = where(Posted = filter(false));
                    }
                }
            }
        }

    }


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
        IntegrationSetup: Record "Integration Setup";
        gMatchStatus: Option Matched,Unmatched,Error,Force;
        TTS: Record TTS_SAP;

        Excludetype: Option LOB,"LOB-CPMS","CPMS-EOD";
        CommonFunctions: Codeunit "Common Functions";
        ExcludeAct, gscheme : Text;

}
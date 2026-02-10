page 85030 "TTS-ARAP Matching"
{
    ApplicationArea = All;
    Caption = 'TTS-ARAP Matching';
    PageType = Card;
    UsageCategory = Tasks;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'TTS-ARAP Matching';
                
                field(Description; DescriptionText)
                {
                    Caption = 'Description';
                    Editable = false;
                    MultiLine = true;
                    ToolTip = 'Describes the TTS-ARAP matching process.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(RunMatching)
            {
                ApplicationArea = All;
                Caption = 'Run TTS-ARAP Matching';
                Image = MapAccounts;
                ToolTip = 'Execute the TTS-ARAP matching process.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                var
                    TTSARAPMatching: Codeunit "TTS-ARAP Matching";
                    ConfirmMsg: Label 'This will match TTS_SAP records (Scheme=FTTS, Activity=INVOICE) with TTS_ARAP records (Scheme=FTTS, Activity=PAYMENT) based on PaymentReference/ReceiptNumber and matching amounts.\Do you want to proceed?';
                begin
                    if not Confirm(ConfirmMsg, true) then
                        exit;
                    
                    TTSARAPMatching.MatchTTSARAPData();
                end;
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        DescriptionText := 'This matching process will:\' +
                          '1. Filter TTS_SAP records: Scheme=FTTS, Activity=INVOICE, Status=Unmatched/Error\' +
                          '2. Filter TTS_ARAP records: Scheme=FTTS, Activity=PAYMENT, Status=Unmatched/Error\' +
                          '3. Group and sum TestCostWithoutVat by PaymentReference\' +
                          '4. Group and sum ReceiptAmount by ReceiptNumber\' +
                          '5. Match when PaymentReference=ReceiptNumber and amounts are equal\' +
                          '6. Generate matching IDs and update all matched records';
    end;
    
    var
        DescriptionText: Text;
}

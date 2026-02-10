report 85009 "Cheque Refunds"
{
    ApplicationArea = All;
    Caption = 'Cheque Refunds';
    DefaultLayout = Excel;
    ExcelLayout = './layouts/ChequeRefunds.xlsx';
    UsageCategory = ReportsAndAnalysis;



    dataset
    {
        dataitem("Cheque Refunds"; TTS_ARAP)
        {
            RequestFilterHeading = 'Cheque Refunds';
            RequestFilterFields = ReceiptGlDate;
            column(Scheme; Scheme)
            {
            }
            column(ReceiptNumber; ReceiptNumber)
            {
            }
            column(VendorNumber; VendorNumber)
            {
            }
            column(GL; GL)
            {
            }
            column(BookingReference; BookingReference)
            {
            }
            column(RefundAmount; RefundAmount)
            {
            }
            column(RecCustomerName; RecCustomerName)
            {
            }
            column(RecAddressLine1; RecAddressLine1)
            {
            }
            column(RecAddressLine2; RecAddressLine2)
            {
            }
            column(RecAddressLine3; RecAddressLine3)
            {
            }
            column(RecAddressLine4; RecAddressLine4)
            {
            }
            column(RecCity; RecCity)
            {
            }
            column(RecPostalCode; RecPostalCode)
            {
            }
            trigger OnAfterGetRecord()
            var
                TTS: Record TTS_SAP;
            begin
                Clear(VendorNumber);
                Clear(GL);
                Clear(BookingReference);
                case true of
                    "Cheque Refunds".Scheme = 'FTTS':
                        begin
                            VendorNumber := 'R0000800';
                            GL := '250320';
                        end;
                    "Cheque Refunds".Scheme = 'FTNI':
                        begin
                            VendorNumber := 'R0001000';
                            GL := '250321';
                        end;
                end;

                if TestRefDic.ContainsKey("Cheque Refunds".InvoiceNumber) then
                    BookingReference := TestRefDic.Get("Cheque Refunds".InvoiceNumber);
            end;


            trigger OnPreDataItem()
            var
                TTS: Record TTS_SAP;
            begin
                TTS.SetLoadFields(InvoiceNumber, TestReference);
                if tts.FindSet(false) then
                    repeat
                        if not TestRefDic.ContainsKey(TTS.InvoiceNumber) then
                            TestRefDic.Add(TTS.InvoiceNumber, TTS.TestReference);
                    until tts.Next() = 0;
            end;

        }
    }

    requestpage
    {
        layout
        {

        }
        trigger OnOpenPage()
        begin
            "Cheque Refunds".SetFilter(Activity, 'REFGOODS|REFUND');
            "Cheque Refunds".SetFilter(ReceiptMethod, 'CHEQUE');
            "Cheque Refunds".SetFilter(ReceiptNumber, '<>%1', '');
        end;
    }

    var
        VendorNumber, GL, BookingReference : Text;
        TestRefDic: Dictionary of [Text[100], Text[100]];
}

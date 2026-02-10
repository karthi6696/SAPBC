query 85002 GetCPMSSummary
{
    QueryType = Normal;


    elements
    {
        dataitem(CPMS; TTS_ARAP)
        {
            //  DataItemTableFilter = Posted = filter(false);
            column(Scheme; Scheme)
            {

            }
            column(country; Country)
            {
            }
            column(activity; Activity)
            {
            }
            filter(Product; TestType)
            {

            }
            filter(Entry_No_; "Entry No.")
            {

            }
            filter(Select; Select)
            {

            }
            filter(SalesPerson; SalesPerson)
            {

            }
            filter(Source_Activity_Origin; "Source Activity-Origin")
            {

            }
            filter(ReceiptMethod; ReceiptMethod)
            {

            }
            filter(TESTMATCH; TESTMATCH)
            {

            }
            filter(REFUNDOAB; ReceiptMethod)
            {

            }
            column(ReceiptAmount; ReceiptAmount)
            {
                Method = Sum;
            }
            column(RefundAmount; RefundAmount)
            {
                Method = Sum;
            }
            filter(Payment_Duplicate; "Payment Duplicate")
            {

            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
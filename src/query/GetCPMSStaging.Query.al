query 85007 GetCPMSStaging
{
    QueryType = Normal;


    elements
    {
        dataitem(CPMS; TTS_ARAP)
        {
            //DataItemTableFilter = Posted = filter(false);
            column(Scheme; Scheme)
            {

            }
            column(country; Country)
            {
            }
            column(activity; Activity)
            {
            }
            column(Product; TestType)
            {

            }
            column(Entry_No_; "Entry No.")
            {

            }
            column(SalesPerson; SalesPerson)
            {

            }
            column(Source_Activity_Origin; "Source Activity-Origin")
            {

            }
            column(ReceiptMethod; ReceiptMethod)
            {

            }
            column(TESTMATCH; TESTMATCH)
            {

            }
            column(REFUNDOAB; ReceiptMethod)
            {

            }
            column(Payment_Duplicate; "Payment Duplicate")
            {

            }
            filter(Select; Select)
            {

            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
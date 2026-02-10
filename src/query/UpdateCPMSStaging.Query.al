query 85003 UpdateCPMSStaging
{
    QueryType = Normal;


    elements
    {
        dataitem(CPMS; TTS_ARAP)
        {
            DataItemTableFilter = Posted = filter(false);
            column(Entry; "Entry No.")
            {

            }
            column(Scheme; Scheme)
            {

            }
            column(country; Country)
            {
            }
            column(activity; Activity)
            {
            }
            filter(Entry_No_; "Entry No.")
            {

            }
            filter(SalesPerson; SalesPerson)
            {

            }
            filter(Product; TestType)
            {

            }
            filter(Source_Activity_Origin; "Source Activity-Origin")
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
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
query 85005 FilterCPMSMaterials
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
            column(product; TestType)
            {
            }
            filter(SalesPerson; SalesPerson)
            {

            }
            filter(Select; Select)
            {

            }
            filter(TESTMATCH; TESTMATCH)
            {

            }
            filter(REFUNDOAB; ReceiptMethod)
            {

            }
            filter(ReceiptMethod; ReceiptMethod)
            {

            }
            filter(Source_Activity_Origin; "Source Activity-Origin")
            {

            }
            filter(Entry_No_; "Entry No.")
            {

            }
            filter(Payment_Duplicate; "Payment Duplicate")
            {

            }
            column(Count)
            {
                Method = Count;
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
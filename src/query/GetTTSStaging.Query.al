query 85006 GetTTSStaging
{
    QueryType = Normal;


    elements
    {
        dataitem(TTS; TTS_SAP)
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
            column(Entry_No_; "Entry No.")
            {

            }
            column(SalesPerson; SalesPerson)
            {

            }
            filter(Select; Select)
            {

            }
            column(Product; Product)
            {

            }
            column(TESTMATCH; TESTMATCH)
            {

            }
            column(REFUNDOAB; REFUNDOAB)
            {

            }
            column(TestCostWithoutVat; TestCostWithoutVat)
            {

            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
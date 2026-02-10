query 85004 UpdateTTSStaging
{
    QueryType = Normal;


    elements
    {
        dataitem(TTS; TTS_SAP)
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
            filter(Product; Product)
            {

            }
            filter(TESTMATCH; TESTMATCH)
            {

            }
            filter(REFUNDOAB; REFUNDOAB)
            {

            }
            column(TestCostWithoutVat; TestCostWithoutVat)
            {
                Method = Sum;
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
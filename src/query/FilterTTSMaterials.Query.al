query 85000 FilterTTSMaterials
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
            column(product; Product)
            {
            }
            filter(Select; Select)
            {

            }
            filter(SalesPerson; SalesPerson)
            {

            }
            filter(TESTMATCH; TESTMATCH)
            {

            }
            filter(REFUNDOAB; REFUNDOAB)
            {

            }
            filter(Entry_No_; "Entry No.")
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
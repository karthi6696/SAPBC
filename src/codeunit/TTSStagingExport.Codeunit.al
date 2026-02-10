codeunit 85007 "TTS Staging Export"
{
    trigger OnRun()
    begin
        CreateTTSCSVFile()
    end;

    procedure CreateTTSCSVFile()
    var
        InStr: InStream;
        OutStr: OutStream;
        tmpBlob: Codeunit "Temp Blob";
        FileName: Text;
        TTSStaging: Record TTS_SAP;
        DateCapture: Page "Date Capture";
        StartDate: Date;
        EndDate: Date;
        FilterStart: DateTime;
        FilterEnd: DateTime;
    begin
        DateCapture.RunModal();
        DateCapture.ReturnDates(StartDate, EndDate);

        If StartDate = 0D then
            error('You must specify a start date');

        If EndDate = 0D then
            error('You must specify an end date');

        FilterStart := CreateDateTime(StartDate, 000000T);
        FilterEnd := CreateDateTime(EndDate, 235959T);

        FileName := 'TTSTransactions' + format(Today, 0, '<Year4><Month,2><Day,2>') + '.csv';
        tmpBlob.CreateOutStream(OutStr, TextEncoding::Windows);
        CR := 13;
        LF := 10;

        WriteFileHdrLine(OutStr);

        //SourceTableView = sorting(ReceiptDate, "EOD Matching Status") order(descending);
        TTSStaging.Reset();
        TTSStaging.SetRange(TTSStaging.SystemCreatedAt, FilterStart, FilterEnd);
        If TTSStaging.FindFirst() then
            repeat
                WriteFileBodyLines(OutStr, TTSStaging);
            until TTSStaging.Next() = 0;

        tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
        if GuiAllowed then
            DownloadFromStream(InStr, '', '', '', FileName);
    end;

    procedure WriteFileHdrLine(var OutStr: OutStream)
    var
        Line: Text;
    begin
        Line := 'FinanceSapId,Scheme,Country,Activity,InvoiceNumber,InvoiceDate,InvoicePostingDate,PaymentReference,LineId,Product,TestReference,TestCostWithoutVat,OabTransferValueGross,TestDate,SalesPerson,InvCustomerName,InvAddressLine1,InvAddressLine2,InvAddressLine3,InvAddressLine4,InvCity,InvPostalCode,LongText,FileDate,INVOICE,REFGOODS,file_duplicate,test_duplicate,REFUNDOAB,REVTESTM,TESTMATCH,ImportedDateTime';
        OutStr.WriteText(Line + CR + LF);
    end;

    procedure WriteFileBodyLines(var OutStr: OutStream; var TTSStaging: Record TTS_SAP)
    var
        Line: Text;
    begin
        Line := Format(TTSStaging.FinanceSapId) + ',';
        Line += TTSStaging.Scheme + ',';
        Line += TTSStaging.Country + ',';
        Line += TTSStaging.Activity + ',';
        Line += TTSStaging.InvoiceNumber + ',';
        Line += Format(TTSStaging.InvoiceDate) + ',';
        Line += Format(TTSStaging.InvoicePostingDate) + ',';
        Line += TTSStaging.PaymentReference + ',';
        Line += Format(TTSStaging.LineId) + ',';
        Line += TTSStaging.Product + ',';
        Line += TTSStaging.TestReference + ',';
        Line += delchr(Format(TTSStaging.TestCostWithoutVat), '=', ',') + ',';
        Line += delchr(Format(TTSStaging.OabTransferValueGross), '=', ',') + ',';
        Line += Format(TTSStaging.TestDate) + ',';
        Line += TTSStaging.SalesPerson + ',';
        Line += TTSStaging.InvCustomerName + ',';
        Line += TTSStaging.InvAddressLine1 + ',';
        Line += TTSStaging.InvAddressLine2 + ',';
        Line += TTSStaging.InvAddressLine3 + ',';
        Line += TTSStaging.InvAddressLine4 + ',';
        Line += TTSStaging.InvCity + ',';
        Line += TTSStaging.InvPostalCode + ',';
        Line += TTSStaging.LongText + ',';
        Line += Format(TTSStaging.FileDate) + ',';
        Line += TTSStaging.INVOICE + ',';
        Line += TTSStaging.REFGOODS + ',';
        Line += TTSStaging.file_duplicate + ',';
        Line += TTSStaging.test_duplicate + ',';
        Line += TTSStaging.REFUNDOAB + ',';
        Line += TTSStaging.REVTESTM + ',';
        Line += TTSStaging.TESTMATCH + ',';
        Line += Format(TTSStaging.SystemCreatedAt);
        OutStr.WriteText(Line + CR + LF);
    end;

    var
        CR: char;
        LF: char;
}
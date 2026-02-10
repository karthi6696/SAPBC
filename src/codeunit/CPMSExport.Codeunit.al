codeunit 85005 "CPMS Export"
{
    trigger OnRun()
    begin

    end;

    procedure CreateCPMSCSVFile()
    var
        InStr: InStream;
        OutStr: OutStream;
        tmpBlob: Codeunit "Temp Blob";
        FileName: Text;
        CPMSStaging: Record TTS_ARAP;
    begin
        FileName := 'UnmatchedCPMS' + format(Today, 0, '<Year4><Month,2><Day,2>') + '.csv';
        tmpBlob.CreateOutStream(OutStr, TextEncoding::Windows);
        CR := 13;
        LF := 10;

        WriteFileHdrLine(OutStr);

        //SourceTableView = sorting(ReceiptDate, "EOD Matching Status") order(descending);
        CPMSStaging.Reset();
        CPMSStaging.SetCurrentKey(ReceiptDate, "EOD Matching Status");
        CPMSStaging.SetAscending(ReceiptDate, false);
        If CPMSStaging.FindFirst() then
            repeat
                WriteFileBodyLines(OutStr, CPMSStaging);
            until CPMSStaging.Next() = 0;

        tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
        DownloadFromStream(InStr, '', '', '', FileName);
    end;

    procedure WriteFileHdrLine(var OutStr: OutStream)
    var
        Line: Text;
    begin
        Line := 'Scheme Code,Country,Activity Code,Invoice Date,Invoice Number,Receipt Number,Receipt Method,Receipt Date,Receipt Amount,Refund Amount,Matching Id,Matching Status';
        OutStr.WriteText(Line + CR + LF);
    end;

    procedure WriteFileBodyLines(var OutStr: OutStream; var CPMSStaging: Record TTS_ARAP)
    var
        Line: Text;
    begin
        Line := CPMSStaging.Scheme + ',';
        Line += CPMSStaging.Country + ',';
        Line += CPMSStaging.Activity + ',';
        Line += Format(CPMSStaging.InvoiceDate) + ',';
        Line += CPMSStaging.InvoiceNumber + ',';
        Line += CPMSStaging.ReceiptNumber + ',';
        Line += CPMSStaging.ReceiptMethod + ',';
        Line += Format(CPMSStaging.ReceiptDate) + ',';
        Line += delchr(Format(CPMSStaging.ReceiptAmount), '=', ',') + ',';
        Line += delchr(Format(CPMSStaging.RefundAmount), '=', ',') + ',';
        Line += Format(CPMSStaging."EOD Matching ID") + ',';
        Line += Format(CPMSStaging."EOD Matching Status");
        OutStr.WriteText(Line + CR + LF);
    end;

    var
        CR: char;
        LF: char;
}
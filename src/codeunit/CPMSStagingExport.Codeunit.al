codeunit 85006 "CPMS Staging Export"
{
    trigger OnRun()
    begin
        CreateCPMSCSVFile()
    end;

    procedure CreateCPMSCSVFile()
    var
        InStr: InStream;
        OutStr: OutStream;
        tmpBlob: Codeunit "Temp Blob";
        FileName: Text;
        CPMSStaging: Record TTS_ARAP;
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

        FileName := 'CPMSTransactions' + format(Today, 0, '<Year4><Month,2><Day,2>') + '.csv';
        tmpBlob.CreateOutStream(OutStr, TextEncoding::Windows);
        CR := 13;
        LF := 10;

        WriteFileHdrLine(OutStr);

        CPMSStaging.Reset();
        CPMSStaging.SetRange(CPMSStaging.SystemCreatedAt, FilterStart, FilterEnd);
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
        Line := 'FinanceArapId,Scheme,Country,Activity,InvoiceNumber,InvoiceDate,RuleStartDate,RuleDuration,TaxCode,TaxAmount,InvoiceAmount,LineIdentifier,LineDescription,LineAmountNet,ReceiptAmount,ReceiptDate,ReceiptGlDate,ReceiptMethod,ReceiptMatchAmount,CcReference,RefundAmount,InvCustomerNumber,InvCustomerName,InvAddressLine1,InvAddressLine2,InvAddressLine3,InvAddressLine4,InvCity,InvPostalCode,InvReference,RecCustomerNumber,RecCustomerName,RecAddressLine1,RecAddressLine2,RecAddressLine3,RecCity,RecPostalCode,RecReference,ReceiptNumber,SalesPerson,OrderReference,PayingInBatchReference,FileDate,TESTMATCH,INVOICE,ORIGIN,TestType,Payee,PaymentAuthcode,PaymentProvider,PaymentResult,ImportedDateTime';
        OutStr.WriteText(Line + CR + LF);
    end;

    procedure WriteFileBodyLines(var OutStr: OutStream; var CPMSStaging: Record TTS_ARAP)
    var
        Line: Text;
    begin
        Line := Format(CPMSStaging.FinanceArapId) + ',';
        Line += CPMSStaging.Scheme + ',';
        Line += CPMSStaging.Country + ',';
        Line += CPMSStaging.Activity + ',';
        Line += CPMSStaging.InvoiceNumber + ',';
        Line += Format(CPMSStaging.InvoiceDate) + ',';
        Line += Format(CPMSStaging.RuleStartDate) + '';
        Line += Format(CPMSStaging.RuleDuration) + ',';
        Line += CPMSStaging.TaxCode + ',';
        Line += delchr(Format(CPMSStaging.TaxAmount), '=', ',') + ',';
        Line += delchr(Format(CPMSStaging.InvoiceAmount), '=', ',') + ',';
        Line += Format(CPMSStaging.LineIdentifier) + ',';
        Line += CPMSStaging.LineDescription + ',';
        Line += Format(CPMSStaging.LineAmountNet) + ',';
        Line += delchr(Format(CPMSStaging.ReceiptAmount), '=', ',') + ',';
        Line += Format(CPMSStaging.ReceiptDate) + ',';
        Line += Format(CPMSStaging.ReceiptGlDate) + ',';
        Line += CPMSStaging.ReceiptMethod + ',';
        Line += delchr(Format(CPMSStaging.ReceiptMatchAmount), '=', ',') + ',';
        Line += CPMSStaging.CcReference + ',';
        Line += delchr(Format(CPMSStaging.RefundAmount), '=', ',') + ',';
        Line += CPMSStaging.InvCustomerNumber + ',';
        Line += CPMSStaging.InvCustomerName + ',';
        Line += CPMSStaging.InvAddressLine1 + ',';
        Line += CPMSStaging.InvAddressLine2 + ',';
        Line += CPMSStaging.InvAddressLine3 + ',';
        Line += CPMSStaging.InvAddressLine4 + ',';
        Line += CPMSStaging.InvCity + ',';
        Line += CPMSStaging.InvPostalCode + ',';
        Line += CPMSStaging.InvReference + ',';
        Line += CPMSStaging.RecCustomerNumber + ',';
        Line += CPMSStaging.RecCustomerName + ',';
        Line += CPMSStaging.RecAddressLine1 + ',';
        Line += CPMSStaging.RecAddressLine2 + ',';
        Line += CPMSStaging.RecAddressLine3 + ',';
        Line += CPMSStaging.RecAddressLine4 + ',';
        Line += CPMSStaging.RecCity + ',';
        Line += CPMSStaging.RecPostalCode + ',';
        Line += CPMSStaging.RecReference + ',';
        Line += CPMSStaging.ReceiptNumber + ',';
        Line += CPMSStaging.SalesPerson + ',';
        Line += CPMSStaging.OrderReference + ',';
        Line += CPMSStaging.PayingInBatchReference + ',';
        Line += Format(CPMSStaging.FileDate) + ',';
        Line += CPMSStaging.TESTMATCH + ',';
        Line += CPMSStaging.INVOICE + ',';
        Line += CPMSStaging.ORIGIN + ',';
        Line += CPMSStaging.TestType + ',';
        Line += CPMSStaging.Payee + ',';
        Line += CPMSStaging."Payment Authcode" + ',';
        Line += CPMSStaging."Payment Provider" + ',';
        Line += CPMSStaging."Payment Result" + ',';
        Line += Format(CPMSStaging.SystemCreatedAt);
        OutStr.WriteText(Line + CR + LF);
    end;

    var
        CR: char;
        LF: char;
}
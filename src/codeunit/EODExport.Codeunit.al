codeunit 85004 "EOD Export"
{
    trigger OnRun()
    begin
        // test that i can sync to the repo
    end;

    procedure CreateEODCSVFile()
    var
        InStr: InStream;
        OutStr: OutStream;
        tmpBlob: Codeunit "Temp Blob";
        FileName: Text;
        EODStaging: Record "EOD Staging";
    begin
        FileName := 'UnmatchedEOD' + format(Today, 0, '<Year4><Month,2><Day,2>') + '.csv';
        tmpBlob.CreateOutStream(OutStr, TextEncoding::Windows);
        CR := 13;
        LF := 10;

        WriteFileHdrLine(OutStr);

        EODStaging.Reset();
        If EODStaging.FindFirst() then
            repeat
                WriteFileBodyLines(OutStr, EODStaging);
            until EODStaging.Next() = 0;

        tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
        DownloadFromStream(InStr, '', '', '', FileName);
    end;

    procedure WriteFileHdrLine(var OutStr: OutStream)
    var
        Line: Text;
    begin
        Line := 'Reference Number,Reference Number 2,Transaction Date,Fund Code,Pay Code, Transaction Amount,Pay Amount,Last 4 Card Digits,Card Transaction Type,Processed,Reversed,Matching ID,Matching Status';
        OutStr.WriteText(Line + CR + LF);
    end;

    procedure WriteFileBodyLines(var OutStr: OutStream; var EodStaging: Record "EOD Staging")
    var
        Line: Text;
    begin
        Line := EodStaging."Reference Number" + ',';
        Line += EodStaging."Reference Number 2" + ',';
        Line += Format(EodStaging."Transaction Date") + ',';
        Line += EodStaging."Fund Code" + ',';
        Line += EodStaging."Pay Code" + ',';
        Line += delchr(Format(EodStaging."Transaction Amount"), '=', ',') + ',';
        Line += delchr(Format(EodStaging."Pay Amount"), '=', ',') + ',';
        Line += EodStaging."Last 4 Card Digits" + ',';
        Line += EodStaging."Card Transaction Type" + ',';
        Line += Format(EodStaging.Processed) + ',';
        Line += Format(EodStaging.Reversed) + ',';
        Line += EodStaging."Matching ID" + ',';
        Line += Format(EodStaging."Matching Status");
        OutStr.WriteText(Line + CR + LF);
    end;

    var
        CR: char;
        LF: char;
}
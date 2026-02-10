codeunit 85011 "SharePoint Export"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        Rec.TestField("Report ID");
        Rec.CalcFields("Report Name");
        SharepointConnection.InitializeConnection();

        Sharepointfiles.Init();
        Sharepointfiles."Report Name" := Rec."Report Name";
        Sharepointfiles."File Name" := SanitizeFileName(Rec."Report Name" + '_' + Format(CurrentDateTime) + '.xlsx');
        Sharepointfiles."Schedule ID" := Rec.ID;

        if not ExportReportToStream(Tempblob, Rec."Report ID") then begin
            Sharepointfiles.Message := 'Failed - ' + GetLastErrorText();
            Sharepointfiles.Status := Sharepointfiles.Status::Failed;
            Sharepointfiles.Insert(true);
            exit;
        end;

        // Verify file has data before uploading
        if not HasExcelData(Tempblob) then begin
            Sharepointfiles.Message := 'Failed - No data to export';
            Sharepointfiles.Status := Sharepointfiles.Status::Failed;
            Sharepointfiles.Insert(true);
            exit;
        end;

        // Save blob to record
        Tempblob.CreateInStream(Istream);
        Sharepointfiles.Report.CreateOutStream(OStream);
        CopyStream(OStream, Istream);
        Sharepointfiles.Status := Sharepointfiles.Status::Success;
        Sharepointfiles.Message := 'Exported to SharePoint Successfully';
        Sharepointfiles.Insert(true);

        // Upload to SharePoint
        Sharepointfiles.CalcFields(Report);
        Sharepointfiles.Report.CreateInStream(Istream);
        if not SharepointConnection.UploadFile(Sharepointfiles, Istream, Sharepointfiles."File Name") then begin
            Sharepointfiles.Message := 'Failed - ' + GetLastErrorText();
            Sharepointfiles.Status := Sharepointfiles.Status::Failed;
            Sharepointfiles.Modify(true);
        end;
    end;

    local procedure ExportReportToStream(var TempBlob: Codeunit "Temp Blob"; ReportID: Integer): Boolean
    var
        FileStream: OutStream;
    begin
        TempBlob.CreateOutStream(FileStream);
        exit(Report.SaveAs(ReportID, '', ReportFormat::Excel, FileStream));
    end;

    local procedure HasExcelData(var TempBlob: Codeunit "Temp Blob"): Boolean
    var
        Istream: InStream;
        NameValueBuffer: Record "Name/Value Buffer" temporary;
    begin
        TempBlob.CreateInStream(Istream);
        ExcelBuff.Reset();
        ExcelBuff.DeleteAll();
        ExcelBuff.GetSheetsNameListFromStream(Istream, NameValueBuffer);

        if not NameValueBuffer.FindFirst() then
            exit(false);

        ExcelBuff.OpenBookStream(Istream, NameValueBuffer.Value);
        ExcelBuff.ReadSheet();
        ExcelBuff.SetRange("Row No.", 2);

        exit(not ExcelBuff.IsEmpty);
    end;

    local procedure SanitizeFileName(FileName: Text): Text
    begin
        FileName := Text.DelChr(FileName, '=', '/');
        FileName := Text.DelChr(FileName, '=', ':');
        exit(FileName);
    end;

    var
        OStream, FileStream : OutStream;
        Istream: InStream;
        Sharepointfiles: Record "SharePoint Log Entries";
        SharepointConnection: Codeunit "Sharepoint Connection";
        ExcelBuff: Record "Excel Buffer" temporary;
        Tempblob: Codeunit "Temp Blob";
}
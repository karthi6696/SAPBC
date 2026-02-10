// codeunit 85000 "Import_Functions"
// {
//     trigger OnRun()
//     begin

//     end;

//     procedure Manual_Import_TTS_SAP()
//     var
//         IStream: InStream;
//         FileName: Text;
//         CSVBuffer: Record "CSV Buffer" temporary;
//         LineNo: Integer;
//         TTS_SAP: Record TTS_SAP;
//     begin
//         if not UploadIntoStream('Select File', '', '', FileName, IStream) then
//             exit;

//         CSVBuffer.Reset();
//         CSVBuffer.DeleteAll();
//         CSVBuffer.LoadDataFromStream(IStream, '~');
//         for LineNo := 2 to CSVBuffer.GetNumberOfLines() do begin
//             Clear(TTS_SAP);
//             TTS_SAP.Init();
//             TTS_SAP.Insert(true);
//             TTS_SAP.FinanceSapId := CSVBuffer.GetValue(LineNo, 1);
//             TTS_SAP.Scheme := CSVBuffer.GetValue(LineNo, 2);
//             TTS_SAP.Country := CSVBuffer.GetValue(LineNo, 3);
//             TTS_SAP.Activity := CSVBuffer.GetValue(LineNo, 4);
//             TTS_SAP.InvoiceNumber := CSVBuffer.GetValue(LineNo, 5);
//             TTS_SAP.InvoiceDate := CSVBuffer.GetValue(LineNo, 6);
//             TTS_SAP.InvoicePostingDate := CSVBuffer.GetValue(LineNo, 7);
//             TTS_SAP.CustomerNumber := CSVBuffer.GetValue(LineNo, 8);
//             TTS_SAP.PaymentReference := CSVBuffer.GetValue(LineNo, 9);
//             TTS_SAP.LineId := CSVBuffer.GetValue(LineNo, 10);
//             TTS_SAP.Product := CSVBuffer.GetValue(LineNo, 11);
//             TTS_SAP.TestReference := CSVBuffer.GetValue(LineNo, 12);
//             TTS_SAP.TestCostWithoutVat := CSVBuffer.GetValue(LineNo, 13);
//             TTS_SAP.OabTransferValueGross := CSVBuffer.GetValue(LineNo, 14);
//             TTS_SAP.TestDate := CSVBuffer.GetValue(LineNo, 15);
//             TTS_SAP.SalesPerson := CSVBuffer.GetValue(LineNo, 16);
//             TTS_SAP.InvCustomerName := CSVBuffer.GetValue(LineNo, 17);
//             TTS_SAP.InvAddressLine1 := CSVBuffer.GetValue(LineNo, 18);
//             TTS_SAP.InvAddressLine2 := CSVBuffer.GetValue(LineNo, 19);
//             TTS_SAP.InvAddressLine3 := CSVBuffer.GetValue(LineNo, 20);
//             TTS_SAP.InvAddressLine4 := CSVBuffer.GetValue(LineNo, 21);
//             TTS_SAP.InvCity := CSVBuffer.GetValue(LineNo, 22);
//             TTS_SAP.InvPostalCode := CSVBuffer.GetValue(LineNo, 23);
//             TTS_SAP.LongText := CSVBuffer.GetValue(LineNo, 24);
//             TTS_SAP.FileDate := CSVBuffer.GetValue(LineNo, 25);
//             TTS_SAP.INVOICE := CSVBuffer.GetValue(LineNo, 26);
//             TTS_SAP.REFGOODS := CSVBuffer.GetValue(LineNo, 27);
//             TTS_SAP.file_duplicate := CSVBuffer.GetValue(LineNo, 28);
//             TTS_SAP.test_duplicate := CSVBuffer.GetValue(LineNo, 29);
//             TTS_SAP.REFUNDOAB := CSVBuffer.GetValue(LineNo, 30);
//             TTS_SAP.REVTESTM := CSVBuffer.GetValue(LineNo, 31);
//             TTS_SAP.TESTMATCH := CSVBuffer.GetValue(LineNo, 32);
//             TTS_SAP."Imported Date Time" := CurrentDateTime;
//             TTS_SAP.Modify();
//         end;
//     end;

//     procedure Manual_Import_TTS_ARAP()
//     var
//         IStream: InStream;
//         FileName: Text;
//         CSVBuffer: Record "CSV Buffer" temporary;
//         LineNo: Integer;
//         TTS_ARAP: Record TTS_ARAP;
//     begin
//         if not UploadIntoStream('Select File', '', '', FileName, IStream) then
//             exit;

//         CSVBuffer.Reset();
//         CSVBuffer.DeleteAll();
//         CSVBuffer.LoadDataFromStream(IStream, '~');
//         for LineNo := 2 to CSVBuffer.GetNumberOfLines() do begin
//             Clear(TTS_ARAP);
//             TTS_ARAP.Init();
//             TTS_ARAP.Insert(true);
//             TTS_ARAP.FinanceArapId := CSVBuffer.GetValue(LineNo, 1);
//             TTS_ARAP.Scheme := CSVBuffer.GetValue(LineNo, 2);
//             TTS_ARAP.Country := CSVBuffer.GetValue(LineNo, 3);
//             TTS_ARAP.Activity := CSVBuffer.GetValue(LineNo, 4);
//             TTS_ARAP.InvoiceNumber := CSVBuffer.GetValue(LineNo, 5);
//             TTS_ARAP.InvoiceDate := CSVBuffer.GetValue(LineNo, 6);
//             TTS_ARAP.RuleStartDate := CSVBuffer.GetValue(LineNo, 7);
//             TTS_ARAP.RuleDuration := CSVBuffer.GetValue(LineNo, 8);
//             TTS_ARAP.TaxCode := CSVBuffer.GetValue(LineNo, 9);
//             TTS_ARAP.TaxAmount := CSVBuffer.GetValue(LineNo, 10);
//             TTS_ARAP.InvoiceAmount := CSVBuffer.GetValue(LineNo, 11);
//             TTS_ARAP.LineIdentifier := CSVBuffer.GetValue(LineNo, 12);
//             TTS_ARAP.LineDescription := CSVBuffer.GetValue(LineNo, 13);
//             TTS_ARAP.LineAmountNet := CSVBuffer.GetValue(LineNo, 14);
//             TTS_ARAP.ReceiptAmount := CSVBuffer.GetValue(LineNo, 15);
//             TTS_ARAP.ReceiptNumber := CSVBuffer.GetValue(LineNo, 16);
//             TTS_ARAP.ReceiptDate := CSVBuffer.GetValue(LineNo, 17);
//             TTS_ARAP.ReceiptGlDate := CSVBuffer.GetValue(LineNo, 18);
//             TTS_ARAP.ReceiptMethod := CSVBuffer.GetValue(LineNo, 19);
//             TTS_ARAP.ReceiptMatchAmount := CSVBuffer.GetValue(LineNo, 20);
//             TTS_ARAP.CcReference := CSVBuffer.GetValue(LineNo, 21);
//             TTS_ARAP.RefundAmount := CSVBuffer.GetValue(LineNo, 22);
//             TTS_ARAP.InvCustomerNumber := CSVBuffer.GetValue(LineNo, 23);
//             TTS_ARAP.InvCustomerName := CSVBuffer.GetValue(LineNo, 24);
//             TTS_ARAP.InvAddressLine1 := CSVBuffer.GetValue(LineNo, 25);
//             TTS_ARAP.InvAddressLine2 := CSVBuffer.GetValue(LineNo, 26);
//             TTS_ARAP.InvAddressLine3 := CSVBuffer.GetValue(LineNo, 27);
//             TTS_ARAP.InvAddressLine4 := CSVBuffer.GetValue(LineNo, 28);
//             TTS_ARAP.InvCity := CSVBuffer.GetValue(LineNo, 29);
//             TTS_ARAP.InvPostalCode := CSVBuffer.GetValue(LineNo, 30);
//             TTS_ARAP.InvReference := CSVBuffer.GetValue(LineNo, 31);
//             TTS_ARAP.RecCustomerNumber := CSVBuffer.GetValue(LineNo, 32);
//             TTS_ARAP.RecCustomerName := CSVBuffer.GetValue(LineNo, 33);
//             TTS_ARAP.RecAddressLine1 := CSVBuffer.GetValue(LineNo, 34);
//             TTS_ARAP.RecAddressLine2 := CSVBuffer.GetValue(LineNo, 35);
//             TTS_ARAP.RecAddressLine3 := CSVBuffer.GetValue(LineNo, 36);
//             TTS_ARAP.RecAddressLine4 := CSVBuffer.GetValue(LineNo, 37);
//             TTS_ARAP.RecCity := CSVBuffer.GetValue(LineNo, 38);
//             TTS_ARAP.RecPostalCode := CSVBuffer.GetValue(LineNo, 39);
//             TTS_ARAP.RecReference := CSVBuffer.GetValue(LineNo, 40);
//             TTS_ARAP.SalesPerson := CSVBuffer.GetValue(LineNo, 41);
//             TTS_ARAP.OrderReference := CSVBuffer.GetValue(LineNo, 42);
//             TTS_ARAP.PayingInBatchReference := CSVBuffer.GetValue(LineNo, 43);
//             TTS_ARAP.FileDate := CSVBuffer.GetValue(LineNo, 44);
//             TTS_ARAP.TESTMATCH := CSVBuffer.GetValue(LineNo, 45);
//             TTS_ARAP.INVOICE := CSVBuffer.GetValue(LineNo, 46);
//             TTS_ARAP.ORIGIN := CSVBuffer.GetValue(LineNo, 47);
//             TTS_ARAP.TestType := CSVBuffer.GetValue(LineNo, 48);
//             TTS_ARAP."Imported Date Time" := CurrentDateTime;
//             TTS_ARAP.Modify();
//         end;
//     end;

//     var
//         myInt: Integer;
// }
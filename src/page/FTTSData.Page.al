page 85013 "FTTS Data"
{
    APIGroup = 'bcsap';
    APIPublisher = 'dvsa';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'fttsData';
    DelayedInsert = true;
    EntityName = 'fttsData';
    EntitySetName = 'fttsData';
    PageType = API;
    SourceTable = TTS_SAP;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(activity; Rec.Activity)
                {
                    Caption = 'Acitivity';
                }
                field(cleEntryNo; Rec.CLE_EntryNo)
                {
                    Caption = 'CLE_EntryNo';
                }
                field(country; Rec.Country)
                {
                    Caption = 'Country';
                }
                field(customerNumber; Rec.CustomerNumber)
                {
                    Caption = 'Customer Number';
                }
                field(entryNo; Rec.Id)
                {
                    Caption = 'Entry No.';
                }
                field(fileDate; Rec.FileDate)
                {
                    Caption = 'FileDate';
                }
                field(financeSapId; Rec.FinanceSapId)
                {
                    Caption = 'FinanceSapId';
                }
                field(invoice; Rec.INVOICE)
                {
                    Caption = 'INVOICE';
                }
                field(invAddressLine1; Rec.InvAddressLine1)
                {
                    Caption = 'InvAddressLine1';
                }
                field(invAddressLine2; Rec.InvAddressLine2)
                {
                    Caption = 'InvAdddressLine2';
                }
                field(invAddressLine3; Rec.InvAddressLine3)
                {
                    Caption = 'InvAddressLine3';
                }
                field(invAddressLine4; Rec.InvAddressLine4)
                {
                    Caption = 'InvAddressLine4';
                }
                field(invCity; Rec.InvCity)
                {
                    Caption = 'InvCity';
                }
                field(invCustomerName; Rec.InvCustomerName)
                {
                    Caption = 'InvCustomerName';
                }
                field(invPostalCode; Rec.InvPostalCode)
                {
                    Caption = 'InvPostalCode';
                }
                field(invoiceDate; Rec.InvoiceDate)
                {
                    Caption = 'Invoice Date';
                }
                field(invoiceNumber; Rec.InvoiceNumber)
                {
                    Caption = 'Invoice Number';
                }
                field(invoicePostingDate; Rec.InvoicePostingDate)
                {
                    Caption = 'Invoice PostingDate';
                }
                field(lineId; Rec.LineId)
                {
                    Caption = 'LineId';
                }
                field(longText; Rec.LongText)
                {
                    Caption = 'LongText';
                }
                field(oabTransferValueGross; Rec.OabTransferValueGross)
                {
                    Caption = 'OAB Transfer Value (gross)';
                }
                field(paymentReference; Rec.PaymentReference)
                {
                    Caption = 'Payment Reference';
                }
                field(posted; Rec.Posted)
                {
                    Caption = 'Exported to Summary';
                }
                field(processedDate; Rec."Processed Date")
                {
                    Caption = 'Processed Date';
                }
                field(product; Rec.Product)
                {
                    Caption = 'Product';
                }
                field(refgoods; Rec.REFGOODS)
                {
                    Caption = 'REFGOODS';
                }
                field(refundoab; Rec.REFUNDOAB)
                {
                    Caption = 'REFUNDOAB';
                }
                field(revtestm; Rec.REVTESTM)
                {
                    Caption = 'REVTESTM';
                }
                field(sapRegisterNo; Rec."SAP Register No.")
                {
                    Caption = 'SAP Register No.';
                }
                field(salesPerson; Rec.SalesPerson)
                {
                    Caption = 'Sales Person';
                }
                field(scheme; Rec.Scheme)
                {
                    Caption = 'Scheme';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(testmatch; Rec.TESTMATCH)
                {
                    Caption = 'TESTMATCH';
                }
                field(testCostWithoutVat; Rec.TestCostWithoutVat)
                {
                    Caption = 'Test Cost Without Vat';
                }
                field(testDate; Rec.TestDate)
                {
                    Caption = 'TestDate';
                }
                field(testReference; Rec.TestReference)
                {
                    Caption = 'Test Reference';
                }
                field(fileDuplicate; Rec.file_duplicate)
                {
                    Caption = 'file_duplicate';
                }
                field(testDuplicate; Rec.test_duplicate)
                {
                    Caption = 'test_duplicate';
                }
                field(lineAmountNet; Rec."Line Amount Net")
                {
                    Caption = 'Line Amount Net';
                }
                field(lineDescription; Rec."Line Description")
                {
                    Caption = 'Line Description';
                }
                field(orderReference; Rec."Order Reference")
                {
                    Caption = 'Order Reference';
                }
                field(payingInBatchRef; Rec."Paying in Batch Ref")
                {
                    Caption = 'Paying in Batch Ref';
                }
                field(taxAmount; Rec."Tax Amount")
                {
                    Caption = 'Tax Amount';
                }
                field(taxCode; Rec."Tax Code")
                {
                    Caption = 'Tax Code';
                }
                field(testLocation; Rec."Test Location")
                {
                    Caption = 'Test Location';
                }
                field(synapseError; Rec."Synapse Error")
                {
                    Caption = 'Synapse Error';
                }
                field(synapseErrorDescription; Rec."Synapse Error Description")
                {
                    Caption = 'Synapse Error Description';
                }
                field(sourceIdentifier; Rec."Source Identifier")
                {
                    Caption = 'Source Identifier';
                }
            }
        }
    }

}

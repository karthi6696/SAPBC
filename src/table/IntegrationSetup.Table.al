table 85002 "Integration Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "TTS Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'TTS Customer No.';
            TableRelation = Customer;
        }
        field(3; "TTS SAP Journal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
            Caption = 'TTS SAP Journal Template';
        }
        field(4; "TTS SAP Journal Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("TTS SAP Journal Template"));
            Caption = 'TTS SAP Journal Batch';
        }
        field(5; "TTS ARAP Journal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
            Caption = 'TTS ARAP Journal Template';
        }
        field(6; "TTS ARAP Journal Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("TTS ARAP Journal Template"));
            Caption = 'TTS ARAP Journal Batch';
        }
        field(7; "TTS SAP Retention Policy"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Caption = 'TTS SAP Retention Policy';
        }
        field(8; "TTS ARAP Retention Policy"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Caption = 'CPMS Retention Policy';
        }
        field(9; "TestType Validation Activity"; Text[250])
        {
            Caption = 'TestType Validation (Activity)';
            trigger OnLookup()
            var
                DimensionValues: Record "Dimension Value";
                DimValuePage: Page "Dimension Values";
                Lookupvalue: TextBuilder;
            begin
                DimValuePage.LookupMode := true;
                DimensionValues.Reset();
                DimensionValues.SetRange("Global Dimension No.", 2);
                DimensionValues.SetRange(Blocked, false);
                DimValuePage.SetTableView(DimensionValues);
                if DimValuePage.RunModal() = Action::LookupOK then begin
                    DimValuePage.SetSelectionFilter(DimensionValues);
                    if DimensionValues.FindSet() then begin
                        repeat
                            Lookupvalue.Append(DimensionValues.Code + '|');
                        until DimensionValues.Next() = 0;
#pragma warning disable AA0139
                        Rec."TestType Validation Activity" := CopyStr(Lookupvalue.ToText(), 1, Lookupvalue.Length - 1)
#pragma warning restore AA0139
                    end;
                end;
            end;

            trigger OnValidate()
            begin
                Error('');
            end;
        }
        //         field(10; "Exclude TTS-CPMS Activity"; Code[250])
        //         {
        //             trigger OnLookup()
        //             var
        //                 DimensionValues: Record "Dimension Value";
        //                 DimValuePage: Page "Dimension Values";
        //                 Lookupvalue: TextBuilder;
        //             begin
        //                 DimValuePage.LookupMode := true;
        //                 DimensionValues.Reset();
        //                 DimensionValues.SetRange("Global Dimension No.", 2);
        //                 DimensionValues.SetRange(Blocked, false);
        //                 DimValuePage.SetTableView(DimensionValues);
        //                 if DimValuePage.RunModal() = Action::LookupOK then begin
        //                     DimValuePage.SetSelectionFilter(DimensionValues);
        //                     if DimensionValues.FindSet() then begin
        //                         repeat
        //                             Lookupvalue.Append('<>' + DimensionValues.Code + '&');
        //                         until DimensionValues.Next() = 0;
        // #pragma warning disable AA0139
        //                         Rec."Exclude TTS-CPMS Activity" := CopyStr(Lookupvalue.ToText(), 1, Lookupvalue.Length - 1)
        // #pragma warning restore AA0139
        //                     end;
        //                 end;
        //             end;


        //             trigger OnValidate()
        //             begin
        //                 Error('');
        //             end;
        //         }
        field(11; "To Email"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Email Body"; Blob)
        {

        }
        field(13; "Email Subject"; Text[250])
        {

        }
        field(14; "Syn. Err. File To Email"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Syn. Err. Email Body"; Blob)
        {

        }
        field(16; "Syn. Err. Email Subject"; Text[250])
        {

        }
        //         field(17; "Exclude CPMS-EOD Activity"; Code[250])
        //         {
        //             trigger OnLookup()
        //             var
        //                 DimensionValues: Record "Dimension Value";
        //                 DimValuePage: Page "Dimension Values";
        //                 Lookupvalue: TextBuilder;
        //             begin
        //                 DimValuePage.LookupMode := true;
        //                 DimensionValues.Reset();
        //                 DimensionValues.SetRange("Global Dimension No.", 2);
        //                 DimensionValues.SetRange(Blocked, false);
        //                 DimValuePage.SetTableView(DimensionValues);
        //                 if DimValuePage.RunModal() = Action::LookupOK then begin
        //                     DimValuePage.SetSelectionFilter(DimensionValues);
        //                     if DimensionValues.FindSet() then begin
        //                         repeat
        //                             Lookupvalue.Append('<>' + DimensionValues.Code + '&');
        //                         until DimensionValues.Next() = 0;
        // #pragma warning disable AA0139
        //                         Rec."Exclude CPMS-EOD Activity" := CopyStr(Lookupvalue.ToText(), 1, Lookupvalue.Length - 1)
        // #pragma warning restore AA0139
        //                     end;
        //                 end;
        //             end;


        //             trigger OnValidate()
        //             begin
        //                 Error('');
        //             end;
        //         }
        field(18; "EOD Retention Policy"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Caption = 'EOD Retention Policy';
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;


    procedure GetSAPJournalNBText() Body: Text
    var
        RichTextInS: InStream;
    begin
        Rec.CalcFields("Email Body");
        Rec."Email Body".CreateInStream(RichTextInS, TextEncoding::UTF8);
        RichTextInS.Read(Body);
    end;

    procedure SetSAPJournalNBText(Body: Text)
    var
        RichTextOutS: OutStream;
    begin
        Rec."Email Body".CreateOutStream(RichTextOutS, TextEncoding::UTF8);
        RichTextOutS.Write(Body);
        Rec.Modify(true);
    end;

    procedure GetSynErrNBText() Body: Text
    var
        RichTextInS: InStream;
    begin
        Rec.CalcFields("Syn. Err. Email Body");
        Rec."Syn. Err. Email Body".CreateInStream(RichTextInS, TextEncoding::UTF8);
        RichTextInS.Read(Body);
    end;

    procedure SetSynErrNBText(Body: Text)
    var
        RichTextOutS: OutStream;
    begin
        Rec."Syn. Err. Email Body".CreateOutStream(RichTextOutS, TextEncoding::UTF8);
        RichTextOutS.Write(Body);
        Rec.Modify(true);
    end;

}
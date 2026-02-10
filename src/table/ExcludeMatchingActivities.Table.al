table 85015 "Exclude Matching Activities"
{
    Caption = 'Exclude Matching Activities';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Scheme Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

        }
        field(2; "LOB Activity"; Text[2000])
        {
            Caption = 'LOB Activity';
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
                            Lookupvalue.Append('<>' + DimensionValues.Code + '&');
                        until DimensionValues.Next() = 0;
#pragma warning disable AA0139
                        Rec."LOB Activity" := CopyStr(Lookupvalue.ToText(), 1, Lookupvalue.Length - 1)
#pragma warning restore AA0139
                    end;
                end;
            end;


            trigger OnValidate()
            begin
                Error('');
            end;
        }
        field(3; "LOB-CPMS Activity"; Text[2000])
        {
            Caption = 'LOB-CPMS Activity';
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
                            Lookupvalue.Append('<>' + DimensionValues.Code + '&');
                        until DimensionValues.Next() = 0;
#pragma warning disable AA0139
                        Rec."LOB-CPMS Activity" := CopyStr(Lookupvalue.ToText(), 1, Lookupvalue.Length - 1)
#pragma warning restore AA0139
                    end;
                end;
            end;


            trigger OnValidate()
            begin
                Error('');
            end;
        }
        field(4; "CPMS-EOD Activity"; Text[2000])
        {
            Caption = 'CPMS-EOD Activity';
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
                            Lookupvalue.Append('<>' + DimensionValues.Code + '&');
                        until DimensionValues.Next() = 0;
#pragma warning disable AA0139
                        Rec."CPMS-EOD Activity" := CopyStr(Lookupvalue.ToText(), 1, Lookupvalue.Length - 1)
#pragma warning restore AA0139
                    end;
                end;
            end;


            trigger OnValidate()
            begin
                Error('');
            end;
        }
    }
    keys
    {
        key(PK; "Scheme Code")
        {
            Clustered = true;
        }
    }
}

page 85029 "Choose Scheme"
{
    PageType = StandardDialog;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(Input)
            {
                field(Scheme; Scheme)
                {
                    CaptionClass = '1,2,1';
                    Caption = 'Shortcut Dimension 1 Code';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
                    ToolTip = 'Specifies the value of the Scheme field.';
                }
            }
        }
    }

    procedure GetScheme(): Code[20]
    begin
        exit(Scheme);
    end;


    var
        Scheme: Text[20];
}
table 50108 NewPaymentJournTable
{
    Caption = 'PaymentJournTable';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(4; "Account No."; Text[30])
        {
            Caption = 'Account No.';
        }
        field(5; "Sort Code"; Text[50])
        {
            Caption = 'Sort Code';
        }
        field(6; Reference; Text[30])
        {
            Caption = 'Reference';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}

table 50107 PaymentJournTable
{
    fields
    {
        field(1; Amount; Decimal) { }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Account No."; Text[30])
        {
            Caption = 'Account No.';
        }
        field(4; "Sort Code"; Text[20])
        {
            Caption = 'Sort Code';
        }
        field(5; Reference; Code[20])
        {
            Caption = 'Reference';
        }

    }
    keys
    {
        key(PK; Amount)
        {
            Clustered = true;
        }

    }
}

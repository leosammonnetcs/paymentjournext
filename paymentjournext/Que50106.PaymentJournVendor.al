namespace PaymentJournalExt.PaymentJournalExt;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Purchases.Vendor;

query 50106 PaymentJournVendor
{
    Caption = 'PaymentJournVendor';
    QueryType = Normal;

    elements
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            dataitem(Vendor; Vendor)
            {
                DataItemLink = "SystemId" = GenJournalLine."Vendor Id";

                dataitem(Vendor_Bank_Account; "Vendor Bank Account")
                {
                    DataItemLink = "Vendor No." = Vendor."No.";

                    column(Name; Name) { }
                    column(Bank_Account_No_; "Bank Account No.") { }
                    column(Bank_Branch_No_; "Bank Branch No.") { }

                    // column(Reference_No_; "Reference No.") { }
                }

            }

            column(Amount; Amount)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}

report 50105 "PaymentJournalExportReport"
{
    Caption = 'Export to Bank';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = 'PAYMENTJOURNALEXPORT.xlsx';

    dataset
    {
        dataitem(PaymentJournTable; NewPaymentJournTable)
        {
            DataItemTableView = SORTING("Entry No.");

            column(Amount; Amount) { }
            column(Name; Name) { }
            column(Account_No_; "Account No.") { }
            column(Sort_Code; "Sort Code") { }
            // column(Reference; Reference) { }
        }
    }

    /*requestpage
    {
        layout
        {
            area(content)
            {
                group(Project)
                {
                    field(JobNoFilter; JobNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Job No.';
                        TableRelation = "Job"."No.";
                    }
                }
            }
        }
    }*/

    var
        GenJournalLine: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        VendorBankAcc: Record "Vendor Bank Account";

    trigger OnPreReport()
    begin

        // Populate temporary table
        GenJournalLine.SetRange(Amount, 0.01, 1000000000);
        if GenJournalLine.FindSet() then begin
            repeat
                PaymentJournTable.Init();
                PaymentJournTable."Entry No." := GenJournalLine.SystemRowVersion;
                PaymentJournTable.Amount := GenJournalLine.Amount;

                // Retrieve vendor information
                if Vendor.Get(GenJournalLine."Bill-to/Pay-to No.") then begin
                    if VendorBankAcc.Get(Vendor."No.", Vendor."No.") then begin
                        PaymentJournTable.Name := VendorBankAcc.Name;
                        PaymentJournTable."Account No." := VendorBankAcc."Bank Account No.";
                        PaymentJournTable."Sort Code" := VendorBankAcc."Bank Branch No.";
                        // PaymentJournTable.Reference := VendorBankAcc."Reference No.";
                    end;
                end;

                PaymentJournTable.Insert();
            until GenJournalLine.Next() = 0;
        end;
    end;

    trigger OnPostReport()
    begin
        PaymentJournTable.DeleteAll();
    end;

    procedure PopulateTempJobLedgerVendor()
    var
        PaymentJournTable: Record NewPaymentJournTable;
        PaymentJournVendor: Query PaymentJournVendor;
    begin
        PaymentJournVendor.Open();
        while PaymentJournVendor.Read() do begin
            PaymentJournTable.Init();
            PaymentJournTable.Amount := PaymentJournVendor.Amount;
            PaymentJournTable.Name := PaymentJournVendor.Name;
            PaymentJournTable."Account No." := PaymentJournVendor.Bank_Account_No_;
            PaymentJournTable."Sort Code" := PaymentJournVendor.Bank_Branch_No_;
            // PaymentJournTable.Reference := PaymentJournVendor.Reference_No_;
            PaymentJournTable.Insert();
        end;
        PaymentJournVendor.Close();
    end;
}

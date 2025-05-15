// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.PaymentJournalExt;

using Microsoft.Sales.Customer;
using Microsoft.Finance.GeneralLedger.Journal;

pageextension 50104 PaymentJourn extends "Payment Journal"
{
    actions
    {
        addlast("&Payments")
        {
            action("Export Payment Journal")
            {
                ApplicationArea = All;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;
                ToolTip = 'Open the list of suppliers';

                trigger OnAction();
                begin
                    Report.Run(50105);
                end;
            }
        }
    }
}
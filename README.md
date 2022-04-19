Pacioli.jl is a double entry bookkeeping package, to allow accounting to be done in Julia, and especilly within Pluto.  Written in Julia and Markdown, it's intended to allow for a printable document to be created in Pluto.

## Instalation

This program is designed to be used in Pluto, but may work in Juno, or and IDE.  futre testing will test the usability in these environments.

Juno is required.  Currently version requirements are untested but 1.6.3 or 1.7 rc1 or higher is recomended.  These can be downloaded here.
https://julialang.org/downloads/


### Pluto

#### Install Pluto

Once Julia is loaded according to the instructions for your OS and computer archetecture, enter Julia in a terminal or IDE

```
]add Pluto #installs Pluto.jl to Julia in the package manager
```

```
import Pkg; Pkg.add("Pluto") #installs  Pluto.jl to Julia in the terminal or IDE
```

#### Load Pluto

in the terminal or IDE enter:

```
import Pluto; using Pluto
Pluto.run()
```
#### Load Pacioli to Pluto

From the Pluto homepage, add the link to Pluto  in the GitHub registry to 'Open from file:'
or 
Download Pacioli.jl
and
Enter the path to 'Open from file'

This notebook can then be used as an accounting ledger, or tested and modified at personal risk.  However for good practice, it is better to start a new notebooke and save as:

```
<name>ledger<year>.jl
```

Save to a common folder for other materials of the same year, such as the starting balnce, recipts, and invoices.



# Using Pacioli

##Loading Pacioli

Since Pacioli is not currently registered as a Julia package, it must be downloaded and extracted to a destination.

add the relevant packages
```
using DecFP #allows data to exist as fixed point decimals

using DataFrames #allows data to be shown in dataframes

using XLSX # allows spreadsheets to be loaded
```
## Loading Accounts from XLSX
stay tuned!

## Balance Sheet

```
balancesheet(starting_balance)
```
This will produce the starting balance sheet.

Replace ```starting_balance``` with another ledger, such as ```general_ledger``` will a balance sheet after all transactions in the ledger.  If there is a problem such as a sub ledger not being recorded property will result in an imbalance.  In this case the error needs to be fixed, and an issue report should be filled, to ensure such problems with the program are fixed. 

## Set Up General Ledger
```
general_ledger=deepcopy(starting_balance)
```
This sets creates a copy of the starting balance, in a form that can then be edited.

## Transaction

a transaction is recoreded as follows
```
transaction(<memo>,# string to 
<date> # date is entered using the format day <3 letter abbreviation for month> <Year> seperated by spaces
 [debit_ledger_entries],# sub ledger keys sepperated by commas, keys are all strings
 [debit_account_entries], # accounts are entered as strings 
 [debit_ammount_entires], # the actual values that go in each account, entered as Float values, these will convert to Dec64 to 2 decimal places,
                          [credit_ledger_entries],# sub ledger keys sepperated by commas, keys are all strings
                          [credit_account_entries], # accounts are entered as strings 
                          [credit_ammount_entires], # the actual values that go in each account, entered as Float values, these will convert to Dec64 to 2 decimal places,
 ledger # the ledger to be modified, general_ledger by default   
 )
 
 ###Transaction breakdown
 
 ####Date
 ex."1 Jan 2021"
 
 Day - is a 1 or 2 digit number
 
 Month- is the first three letters of each month name, with the first letter capitalized
 
 Year - is the 4 digit year (Y2K)
 
 
 ## Income Statement

```
income_statement(ledger) # enter the ledger that is last used, usually this would be general_ledger, after the year/months entries
```
This will produce an income statement listing each revenue, and expense, as well as the Net Income/Loss of the above transactions. 

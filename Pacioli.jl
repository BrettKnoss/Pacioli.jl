### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ bc8fa216-410d-4cc5-b273-22f07c9334ad
using DataFrames

# ╔═╡ 516f8e5e-8c4b-4208-896f-945d0138eadc
using DecFP

# ╔═╡ 98085028-358d-48df-865d-b4efc1b0fb6a
using XLSX





# ╔═╡ af2597a2-b942-4d45-bb86-98ea9b7f051c
starting_balance=starting_balance=Dict(
	# Starting Balance consists of a dictionary, containing debit and credit dictionaries, containing accounts as empty dictionaries.

	#accounts are organized into credit and debit, then into subledgers based on DEALER acrynym
	
	#Debit Accounts
		#Drawings
		#Expenses
		#Assets
	#Credit Accounts
		#Liabilities
		#Equity
		#Revenue
	
		#Year End Accounts   # These are used to close temporary accounts
			# Gross Revenue
			# Gross Expenses
			# Earned Income
	"debit"=>Dict(
					# balance = Σdebit - Σcredit		
		"drawings"=>Dict(),	#debit normal ledgers
		"expenses"=>Dict(),
		"assets"=>Dict()),
	"credit"=>Dict(  # revenue, liabilities, equtiy, and year_end, are credit normal
					 # balance = Σcredit -  Σdebit
		"liabilities"=>Dict(),
		"equity"=>Dict(),
		"revenue"=>Dict(),
			"retained"=> Dict( #Closing Accounts - No Balance Until Temp Accounts Closed
			"Retained Earnings"=>DataFrame(
        date=Vector{String}(),
		memo=Vector{String}(),
        debit=Vector{Dec64}(),
        credit=Vector{Dec64}(),
		balance=Vector{Dec64}()),
			"Gross Income"=>DataFrame(
        date=Vector{String}(),
		memo=Vector{String}(),
        debit=Vector{Dec64}(),
        credit=Vector{Dec64}(),
		balance=Vector{Dec64}()),
			"Gross Expenses"=>DataFrame(
        date=Vector{String}(),
		memo=Vector{String}(),
        debit=Vector{Dec64}(),
        credit=Vector{Dec64}(),
		balance=Vector{Dec64}()),
			"Net Income"=>DataFrame(
        date=Vector{String}(),
		memo=Vector{String}(),
        debit=Vector{Dec64}(),
        credit=Vector{Dec64}(),
		balance=Vector{Dec64}()),
			"Total Drawings"=>DataFrame(
        date=Vector{String}(),
		memo=Vector{String}(),
        debit=Vector{Dec64}(),
        credit=Vector{Dec64}(),
		balance=Vector{Dec64}()),
		)
	)
	)

# ╔═╡ 3a090d48-4b75-41ab-a22c-82b30bd6b38a
md"""
I don't think I need the starting XLSX or starting date
"""

# ╔═╡ 58be383e-fd15-46bf-b140-fd5b78eb37c1
md"""
Load enters each starting balance from an XLSX file, I can create multiple load functions, for different types of files, but I need to see if I end up using a SQL on NoSQL database later on.
"""

# ╔═╡ f3389620-94dd-4b58-ac3e-5a63ee92a1aa
function load(startingDate,startingXLSX)
	row =1
	
		while row <= length(XLSX.readtable(startingXLSX, "Drawings")[1][1])
	
				starting_balance["debit"]["drawings"][(XLSX.readtable(startingXLSX, "Drawings")[1][1][row])]= DataFrame(
		        			date=Vector{String}([startingDate]),
							memo=Vector{String}(["Starting Balance"]),
        					debit=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Drawings")[1][2][row])]),
        					credit=Vector{Dec64}([Dec64(0.00)]),
							balance=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Drawings")[1][2][row])]))
			

			row+=1
		end

	
		expense=1
	
		while expense <= length(XLSX.readtable(startingXLSX, "Expenses")[1][1])
	
				starting_balance["debit"]["expenses"][(XLSX.readtable(startingXLSX, "Expenses")[1][1][expense])]= DataFrame(
		        			date=Vector{String}([startingDate]),
							memo=Vector{String}(["Starting Balance"]),
        					debit=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Expenses")[1][2][expense])]),
        					credit=Vector{Dec64}([Dec64(0.00)]),
							balance=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Expenses")[1][2][expense])]))
			

			expense+=1
		end
	
			asset=1
	
		while asset <= length(XLSX.readtable(startingXLSX, "Assets")[1][1])
			

				starting_balance["debit"]["assets"][(XLSX.readtable(startingXLSX, "Assets")[1][1][asset])]= DataFrame(
		        			date=Vector{String}([startingDate]),
							memo=Vector{String}(["Starting Balance"]),
        					debit=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Assets")[1][2][asset])]),
        					credit=Vector{Dec64}([Dec64(0.00)]),
							balance=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Assets")[1][2][asset])]))


			asset+=1
		end
	
			liability=1
	
		while liability <= length(XLSX.readtable(startingXLSX, "Liabilities")[1][1])
			

				starting_balance["credit"]["liabilities"][(XLSX.readtable(startingXLSX, "Liabilities")[1][1][liability])]= DataFrame(
		        			date=Vector{String}([startingDate]),
							memo=Vector{String}(["Starting Balance"]),
        					debit=Vector{Dec64}([Dec64(0.00)]),
							credit=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Liabilities")[1][2][liability])]),
        			
							balance=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Liabilities")[1][2][liability])]))


			liability+=1
		end
	
			equity=1
	
		while equity <= length(XLSX.readtable(startingXLSX, "Equity")[1][1])
			

				starting_balance["credit"]["equity"][(XLSX.readtable(startingXLSX, "Equity")[1][1][equity])]= DataFrame(
		        			date=Vector{String}([startingDate]),
							memo=Vector{String}(["Starting Balance"]),
        					debit=Vector{Dec64}([Dec64(0.00)]),
							credit=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Equity")[1][2][equity])]),
        			
							balance=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Equity")[1][2][equity])]))


			equity+=1
		end
	
			revenue=1
	
		while revenue <= length(XLSX.readtable(startingXLSX, "Revenues")[1][1])
			

				starting_balance["credit"]["revenue"][(XLSX.readtable(startingXLSX, "Revenues")[1][1][revenue])]= DataFrame(
		        			date=Vector{String}([startingDate]),
							memo=Vector{String}(["Starting Balance"]),
        					debit=Vector{Dec64}([Dec64(0.00)]),
							credit=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Revenues")[1][2][revenue])]),
        			
							balance=Vector{Dec64}([Dec64(XLSX.readtable(startingXLSX, "Revenues")[1][2][revenue])]))


			revenue+=1
		end
	
end

# ╔═╡ 66ad3f66-d24c-43c6-bc22-c3fa65bd4a0d
function add2ledger!(
    			date,
				general_ledger,
				journal_entry,
				ledger,
    			account,
    			debit_amount,
				credit_amount,
				balance,
				memo)

	# test to see if there is a date
    if length(date) == 0
        return (false,"Error -- no date entered")
		
    #elseif credit_amount-debit_amount != 0          
    #    return (false,"Error -- credit and debit must match." )
	
	#once I know there are no errors-- I can execute the function
    else
		
        default_values=Dict(
			:date=>"",
			:memo=>"",
			:credit=>0,
			:debit=>0,
			:balance=>0)

        spec = Dict(
            :date => date,
			:memo => memo,
            :credit => round(credit_amount; digits=2), 
            :debit => round(debit_amount; digits=2),
			:balance=> round(balance;digits=2))
	
		
		
		new_row = merge(default_values, spec)
 
		
		#now I need to add zeros to each row that isn't debit or credit I think
		
		#I need to save this to a database 
		
       push!(ledger[account],new_row)
	

		
        return (journal_entry,memo)   
    end
end;

# ╔═╡ 0155ee3d-148d-4c89-b011-7d634c88f4e3
function calc_debit_balance!(
				general_ledger,
    			journal_entry,
				date,
				debit_ledger_name,
    			debit_account,
    			debit_amount,
				memo)
	
	if (debit_ledger_name in keys(general_ledger["debit"]))
			
			balance=round(
						(
				round(
					sum(
					general_ledger["debit"][debit_ledger_name][debit_account].debit);
					digits=2)
				-round(
					sum(
					general_ledger["debit"][debit_ledger_name][debit_account].credit);
					digits=2)
				+round(debit_amount;digits=2)
				); digits=2)
			
			ledger=general_ledger["debit"][debit_ledger_name]
			
			account=debit_account
			
			credit_amount=0.0
		
			push!(journal_entry,["",debit_account,"",
				round(debit_amount; digits=2),0,floor(balance; digits=2)])
			
			return add2ledger!(
    			date,
				general_ledger,
				journal_entry,
				ledger,
    			account,
    			debit_amount,
				credit_amount,
				balance,
				memo)
			
			
		elseif (debit_ledger_name in keys(general_ledger["credit"]))
			
			balance=round((
		 	 sum(general_ledger["credit"][debit_ledger_name][debit_account].credit)
			-sum(general_ledger["credit"][debit_ledger_name][debit_account].debit)
			-debit_amount); digits=2)
			
			ledger=general_ledger["credit"][debit_ledger_name]
		
			account=debit_account
		
			credit_amount=0
		
			push!(journal_entry,["",debit_account,"",
				round(debit_amount;digits=2),0,round(balance;digits=2)])
		
			return add2ledger!(
    			date,
				general_ledger,
				journal_entry,
				ledger,
    			account,
    			debit_amount,
				credit_amount,
				balance,
				memo)
		
		else
		
			return (false, "Error -- "*debit_ledger_name*" not found")
		
		end
		
end;	

# ╔═╡ ae593bec-f69a-40bf-82c8-5d5f72512604
function calc_credit_balance!(
				general_ledger,
				journal_entry,
    			date,
				credit_ledger_name,
    			credit_account,
    			credit_amount,
				memo)
	
	if (credit_ledger_name in keys(general_ledger["debit"]))
			
			balance=round((
		 	 sum(general_ledger["debit"][credit_ledger_name][credit_account].debit)
			-sum(general_ledger["debit"][credit_ledger_name][credit_account].credit)
			-credit_amount); digits=2)
			
			ledger=general_ledger["debit"][credit_ledger_name]
			
			account=credit_account
			
			debit_amount=0
		
			push!(journal_entry,["","",credit_account,0,
				round(credit_amount;digits=2),round(balance;digits=2)])
		
			return add2ledger!(
    			date,
				general_ledger,
				journal_entry,
				ledger,
    			account,
				debit_amount,
    			credit_amount,
				balance,
				memo)
	
			
			
		elseif (credit_ledger_name in keys(general_ledger["credit"]))
			
			balance=round((
		 	 sum(general_ledger["credit"][credit_ledger_name][credit_account].credit)
			-sum(general_ledger["credit"][credit_ledger_name][credit_account].debit)
			+credit_amount); digits=2)
			
			ledger=general_ledger["credit"][credit_ledger_name]
		
			account=credit_account
			
			debit_amount=0
		
			push!(journal_entry,["","",credit_account,0,
				round(credit_amount;digits=2),round(balance;digits=2)])
		
			return add2ledger!(
    			date,
				general_ledger,
				journal_entry,
				ledger,
    			account,
    			debit_amount,
				credit_amount,
				balance,
				memo)
			

		
		
		else

			
			return (journal_entry, "Error -- "*credit_ledger_name*" not found")
		
		end
		
end;	

# ╔═╡ 80b0beb5-b364-4d5f-84a4-76219ffe2565
function transaction(
    memo,
	date,
	debit_ledger_entries=[],
	debit_account_entries=[],
    debit_amount_entries=[],
	credit_ledger_entries=[],
    credit_account_entries=[],
    credit_amount_entries=[],
	general_ledger=general_ledger
	)
	
	
	if length(credit_ledger_entries) != length(credit_account_entries)
		
		return "Error--there must be the same number of credit legders and accounts"
		
	else
		
		if length(credit_account_entries) != length(credit_amount_entries)
			
			return "Error-- each account needs a value and vice versa"
			
		else
			
				if length(debit_ledger_entries) != length(debit_account_entries)
		
						return "Error--there must be the same number of debit legders and accounts"
		
	else
		
				if length(debit_account_entries) != length(debit_amount_entries)
			
					return "Error-- each debit account needs a value and vice versa"
			
				else
					
					#test that debit amounts are balanced with credit amounts
					#totals are converted to Dec64 rounded to two decimals, to ensure that computer arithmetic, does not create a false imbalance
					
					#IMPORTANT when testing, revise code if imbalances are a problem
					
					if (round(Dec64(sum(debit_amount_entries)),digits=2)
					  -round(Dec64(sum(credit_amount_entries)),digits=2))!=0
						
						#there might be a problem, that the amounts no longer balance  I can move this test after the while loop, to ensure that is not a problem, but it may hurt performance, and it would mean adding invalid values to accounts
		
						return "Error-total credits does not match total debits"
					else
						
					journal_entry=DataFrame(Date=[date], 
											DebitedAccounts=[""],
											CreditedAccounts=[""],
											Debits=Vector{Dec64}([0.00]),
											Credits=Vector{Dec64}([0.00]),
											Balance=Vector{Dec64}([0.00]))
					i=1
	
	while i <= length(debit_amount_entries)
		
		# tests of individual entries are done in a while loop, after testing that the number and types of entries are correct.
		
		# after testing that the entries are all the same length, and the amounts balances are equal, I can then test that the leger and account names are entered correctly
		#These tests are done after the length tests, but before the entry, to avoid adding values 
		
			if !haskey(general_ledger["debit"], credit_ledger_entries[i]) 

				return "Error -- "*credit_ledger_entries[i]*" not found"
				
				if !haskey(general_ledger["credit"], credit_ledger_entries[i])
					
					return "Error -- "*credit_ledger_entries[i]*" not found"
				else

									
				end
				
			elseif !haskey(general_ledger["debit"], debit_ledger_entries[i])
			
				return "Error -- "*debit_ledger_entries[i]*" not found"
			
					if !haskey(general_ledger["credit"], debit_ledger_entries[i])
					
						return "Error -- "*debit_ledger_entries[i]*" not found"
					
					else
						# once I know the ledger is valid, I test if the account is valid
						# for some reason, this isn't working
									
                        if !haskey(general_ledger["debit"][credit_ledger_entries[i]],  credit_account_entries[i])
						
							return "Error --"*credit_account_entries[i]*" not found in" *credit_ledger_entries[i]*"."
						
						elseif !haskey(general_ledger["credit"][credit_ledger_entries[i]],  credit_account_entries[i])
						
							return "Error --"*credit_account_entries[i]*" not found in" *credit_ledger_entries[i]*"."
						
						elseif!haskey(general_ledger["debit"][debit_ledger_entries[i]],  debit_account_entries[i])
						
							return "Error --"*debit_account_entries[i]*" not found in" *debit_ledger_entries[i]*"."
						
						elseif !haskey(general_ledger["credit"][debit_ledger_entries[i]],  debit_account_entries[i])
										
						return "Error --"*credit_account_entries[i]*" not found in" *credit_ledger_entries[i]*"."
					end
								
								
			else #if each value passes it's tests. it goes on. 
				
					
				#I need a test to find if the account exists in the dictionary, since I'm using indexes, this should be used here, again checking debit then credit
								
				  #It might make my code conveluted to have two sub dictionaries for credit and debit.  I could also nest the check for accounts above
							
				#now that it's tested that leders and accounts exist in the general_ledger dictionary convert the account amounts to Dec64 values rounded to two digits.				
			
			debit_amount_entries[i]=Dec64(round(debit_amount_entries[i]; digits=2))
	
	
		
			credit_amount_entries[i]=Dec64(round(credit_amount_entries[i]; digits=2))
				
			i+=1
		end
	end
			
		# adding values to the journal_entry, and accounts, is done after testing, so errors in the names of accounts and ledgers, are found sooner
						
					i=1
					
					while i <= length(debit_ledger_entries)
						
						#values in arrays are identified with variables, then passed to other functions, to add information to accounts and the journal_entry
						
						#debit values are converted
							
						debit_ledger_name=debit_ledger_entries[i]
    					debit_amount = round(debit_amount_entries[i];digits=2)
    					debit_account=debit_account_entries[i]
							
						calc_debit_balance!(
									general_ledger,
									journal_entry,
    								date,
									debit_ledger_name,
    								debit_account,
    								debit_amount,
									memo)
	
						i+=1											
					end
						
					i=1
						
					while i <= length(credit_ledger_entries)
						
						#credit values are converted and added, after debit values
							
						credit_ledger_name=credit_ledger_entries[i]
						credit_account=credit_account_entries[i]
    					credit_amount=floor(credit_amount_entries[i];digits=2)
						
								
						calc_credit_balance!(
									general_ledger,
									journal_entry,
    								date,
									credit_ledger_name,
    								credit_account,
    								credit_amount,
									memo)
					
						i+=1
							
					end
					
					#after these values are added to the journal entry in individual while loops, these the total debits and credits are added to and  this is added to the journal entry.
					
						
					push!(journal_entry,["","Total","Transaction",
								round(sum(journal_entry.Debits); digits=2),
								round(sum(journal_entry.Credits); digits=2),0])
					
						#finally the journl entry and table are outputed
						
					return (journal_entry, memo)
					


					end
				end
			end
		end
	end
end;	

# ╔═╡ e945d296-25e7-4858-a617-0fbe4295e7d0
md"""
I need to test the rounding and descide on the proper format for variable names, but this should let me do a transaction.  

Issues:
Ensure all values round correctly
	This is annoying

Make sure tests work properly
	A misspelled ledger name should throw an error
	A misspelled account should throw a unique error
	Not specifing the ledger should throw a unique error
	An incorect date should throw a unique error
Make sure the lists are organized by order of date
See abouut other ways to organize transactions, such as time, or by use



Next item, is to create a income statement and balance Sheet.
"""

# ╔═╡ 3d2f840a-bf68-4a4b-8af4-c387abcf669e
function IncomeStatement(ledger)
	revenue=DataFrame(accounts= Vector{String}(), values=Vector{Dec64}())
	
	for account in keys(ledger["credit"]["revenue"])
		push!(revenue,[account,
			round(sum(ledger["credit"]["revenue"][account].credit)
			      -sum(ledger["credit"]["revenue"][account].debit),digits=2)])
	end	
	
	global TotalRevenue=sum(revenue.values)
	
	push!(revenue,["===============================",0.00])
	push!(revenue,["         Total Revenue         ", TotalRevenue])
	
	expenses=DataFrame(accounts= Vector{String}(), 
								  values=Vector{Dec64}())
	
	for account in keys(ledger["debit"]["expenses"])
		push!(expenses,[account,
			round(sum(ledger["debit"]["expenses"][account].credit)
			      -sum(ledger["debit"]["expenses"][account].debit),digits=2)])
	end	
	
	global TotalExpenses=sum(expenses.values)
	
	push!(expenses,["================================",0.0])
	push!(expenses,["         Total  Expenses        ", TotalExpenses])
	
	
	IncomeStatement= vcat(revenue,expenses)
	
	global NetIncome=(TotalRevenue+TotalExpenses)
	push!(IncomeStatement,["================================",0.0])
	push!(IncomeStatement,["            Net  Income         ",
							NetIncome])
	
	
	return IncomeStatement
	
end;

# ╔═╡ acb11c02-7174-493a-a7c7-abfc2f230807
md"""
Check to see that the rouunding is correct.
"""

# ╔═╡ f25ba1a2-6a01-4d4b-abd5-f9d873f90a73
function balancesheet(ledger)
	balance_sheet=DataFrame(DebitAccount=[],
							TotalDebit=[],
								CreditAccount=[],
								TotalCredit=[])
	
	
	push!(balance_sheet,["      Assets      ",0.0,"",0.0])
	
	
	for entry in keys(ledger["debit"]["assets"])
			push!(balance_sheet,[
				entry, 
				round(
				sum(ledger["debit"]["assets"][entry].debit)
				-sum(ledger["debit"]["assets"][entry].credit);
					digits=2),
				"",
				0.0
				])
	end
	
	
	push!(balance_sheet,["",0.0,"      Liabilities      ",0.0])
	
	#Use an if statement if there is a balance
	# see how to skip to the next key
	for entry in keys(ledger["credit"]["liabilities"])
			push!(balance_sheet,[
				"", 
				0.0, 
				entry,
				round( 
				sum(ledger["credit"]["liabilities"][entry].credit)
				-sum(ledger["credit"]["liabilities"][entry].debit)
					;digits=2)
				])
	end
	
		push!(balance_sheet,["",0.0,"       Equity       ",0.0])
	
	#use an if statement to determine if there is a balance
	#see how to skip to the next key
	
	for entry in keys(ledger["credit"]["equity"])
			push!(balance_sheet,["",0.0,
				entry, 
				round(
				sum(ledger["credit"]["equity"][entry].credit)
				-sum(ledger["credit"]["equity"][entry].debit);
					digits=2)])
		
	end	
	
	push!(balance_sheet,["---------------------------",
								    0.0,
						 "---------------------------",
									0.0])
	
	PermanentDebits = sum(balance_sheet.TotalDebit)
	
	PermanentCredits = sum(balance_sheet.TotalCredit)
	
	push!(balance_sheet,["   Total Permanent Debits  ",
								    PermanentDebits,
						 "   Total Permanent Credits ",
									PermanentCredits])
	
	push!(balance_sheet,["      Temorary Debits      ",0.0,
						 "    Tempororay  Credits    ",0.0])
	
	push!(balance_sheet,["        Drawings       ",0.0,"",0.0])
	
	for entry in keys(ledger["debit"]["drawings"])
		push!(balance_sheet,[entry, round(
			sum(ledger["debit"]["drawings"][entry].debit)
			-sum(ledger["debit"]["drawings"][entry].credit);digits=2),"",0.0])
		
	end
	
	push!(balance_sheet,["        Expenses       ",0.0,"",0.0])
	
	for entry in keys(ledger["debit"]["expenses"])
			push!(balance_sheet,[entry, 
				round(
				sum(ledger["debit"]["expenses"][entry].debit)
				-sum(ledger["debit"]["expenses"][entry].credit);digits=2),"",0.0])
		
	end
	
	push!(balance_sheet,["",0.0,"       Revenue       ",0.0])
	
	#use an if statement to determine if there is a balance
	#see how to skip to the next key
	
	for entry in keys(ledger["credit"]["revenue"])
			push!(balance_sheet,["",0.0,entry, round(
				sum(ledger["credit"]["revenue"][entry].credit)
				-sum(ledger["credit"]["revenue"][entry].debit);
					digits=2)])
		
	end
	
	
	push!(balance_sheet,["--------------------------",
									0.0 				,
						 "--------------------------",
									0.0])
	
	TemporaryDebit=sum(balance_sheet.TotalDebit)-(2*PermanentDebits)
	
	TemporaryCredit=sum(balance_sheet.TotalCredit)-(2*PermanentCredits)
	
	
	push!(balance_sheet,[" Temporary Debit Balance  ",
									TemporaryDebit 				,
						 " Temporary Credit Balance ",
									TemporaryCredit])	
	for entry in keys(ledger["credit"]["retained"])
			push!(balance_sheet,["",0.0,entry, round(
				sum(ledger["credit"]["retained"][entry].credit)
				-sum(ledger["credit"]["retained"][entry].debit);
					digits=2)])
		
	end
	
	ClosingDebits=(sum(balance_sheet.TotalDebit)
				  -2*(PermanentDebits+TemporaryDebit)
		)
	
	ClosingCredits=(sum(balance_sheet.TotalCredit)
				   -2*(PermanentCredits+TemporaryCredit)
		)
	
	push!(balance_sheet,["--------------------------",
										0.0			,
						 "--------------------------",
									0.0])
	
	
	push!(balance_sheet,["Closing Debits",
										ClosingDebits,
						 "Closing Credits",
									ClosingCredits])

	
	push!(balance_sheet,["==========================",
								0.0				,
						 "==========================",
								0.0])
	
	
	push!(balance_sheet,["     Total  Debit     ",
			TemporaryDebit+PermanentDebits+ClosingDebits,
			"Total Credit",
			TemporaryCredit+PermanentCredits+ClosingCredits])
	
	
	
	return balance_sheet
end;

# ╔═╡ 9b24ce06-c746-49e7-b0a6-67594111ffb7
md"""
Check to see that all the rouunding is correct.
"""

# ╔═╡ 0c2eb823-21d7-4fc7-9981-85d9a30de243
md"""
Other things to do
	Make it able to produce a unique file invoice and recipt when doing a sale.
	See about using PostgressQL instead of a library
"""

# ╔═╡ 99c7ee4d-486f-41e4-9928-49e793f5d38a


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
DecFP = "55939f99-70c6-5e9b-8bb0-5071ed7d61fd"
XLSX = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"

[compat]
DataFrames = "~1.2.2"
DecFP = "~1.1.0"
XLSX = "~0.7.8"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0-rc1"
manifest_format = "2.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "bd4afa1fdeec0c8b89dad3c6e92bc6e3b0fec9ce"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.6.0"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "1a90210acd935f222ea19657f143004d2c2a1117"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.38.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "d785f42445b63fc86caa08bb9a9351008be9b765"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.2.2"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DecFP]]
deps = ["DecFP_jll", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "ea62e5dfc21d89107ebedd962cc615b0ccd2124a"
uuid = "55939f99-70c6-5e9b-8bb0-5071ed7d61fd"
version = "1.1.0"

[[deps.DecFP_jll]]
deps = ["Libdl", "Pkg"]
git-tree-sha1 = "ebc359a7d11bb63e3a3b87c36d07a88947640eb9"
uuid = "47200ebd-12ce-5be5-abb7-8e082af23329"
version = "2.0.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "a32185f5428d3986f47c2ab78b1f216d5e6cc96f"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.5"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.EzXML]]
deps = ["Printf", "XML2_jll"]
git-tree-sha1 = "0fa3b52a04a4e210aeb1626def9c90df3ae65268"
uuid = "8f5d6c58-4d21-5cfd-889c-e3ad7ee6a615"
version = "1.1.0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "f76424439413893a832026ca355fe273e93bce94"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "34dc30f868e368f8a17b728a1238f3fcda43931a"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.3"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a193d6ad9c45ada72c14b731a318bedd3c2f00cf"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.3.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "0d1245a357cc61c8cd61934c07447aa569ff22e6"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.1.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ad42c30a6204c74d264692e633133dcea0e8b14e"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.6.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "1162ce4a6c4b7e31e0e6b14486a6986951c73be9"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.5.2"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.XLSX]]
deps = ["Dates", "EzXML", "Printf", "Tables", "ZipFile"]
git-tree-sha1 = "96d05d01d6657583a22410e3ba416c75c72d6e1d"
uuid = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"
version = "0.7.8"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[deps.ZipFile]]
deps = ["Libdl", "Printf", "Zlib_jll"]
git-tree-sha1 = "3593e69e469d2111389a9bd06bac1f3d730ac6de"
uuid = "a5390f91-8eb1-5f08-bee0-b1d1ffed6cea"
version = "0.9.4"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═bc8fa216-410d-4cc5-b273-22f07c9334ad
# ╠═516f8e5e-8c4b-4208-896f-945d0138eadc
# ╠═98085028-358d-48df-865d-b4efc1b0fb6a
# ╠═23a0c733-c717-4380-b0ae-bf9e12baf539
# ╠═097d2a2e-deeb-4b1d-b5bf-851ad05ea18f
# ╠═af2597a2-b942-4d45-bb86-98ea9b7f051c
# ╟─3a090d48-4b75-41ab-a22c-82b30bd6b38a
# ╟─58be383e-fd15-46bf-b140-fd5b78eb37c1
# ╠═f3389620-94dd-4b58-ac3e-5a63ee92a1aa
# ╠═66ad3f66-d24c-43c6-bc22-c3fa65bd4a0d
# ╠═0155ee3d-148d-4c89-b011-7d634c88f4e3
# ╠═ae593bec-f69a-40bf-82c8-5d5f72512604
# ╠═80b0beb5-b364-4d5f-84a4-76219ffe2565
# ╟─e945d296-25e7-4858-a617-0fbe4295e7d0
# ╠═3d2f840a-bf68-4a4b-8af4-c387abcf669e
# ╟─acb11c02-7174-493a-a7c7-abfc2f230807
# ╠═f25ba1a2-6a01-4d4b-abd5-f9d873f90a73
# ╟─9b24ce06-c746-49e7-b0a6-67594111ffb7
# ╟─0c2eb823-21d7-4fc7-9981-85d9a30de243
# ╠═99c7ee4d-486f-41e4-9928-49e793f5d38a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

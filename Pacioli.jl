### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ 3d5e6bd6-27a8-11ec-3e7d-15c091c0a256
using FunSQL

# ╔═╡ 28acaf3f-3444-42b9-818d-88d383566773
using DataFrames, DecFP

# ╔═╡ 331e3481-981e-4dc0-b9c9-033770034e46
using Dates

# ╔═╡ 1e9751a4-ebef-4d77-891b-f5f2662638ed
starting_balance=starting_balance=Dict(
	"debit"=>Dict(
		"drawings"=>Dict(),	#debit normal ledgers
		"expenses"=>Dict(),
		"assets"=>Dict()),
	"credit"=>Dict(
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
		balance=Vector{Dec64}())))
)

# ╔═╡ d1d70ab3-2f12-442a-bfef-a886ccfaaf34
function loadXLSX(startingDate,startingXLSX)
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

# ╔═╡ ef2d01d1-82c0-4840-987a-ac4a43e46bdd
#Transaction, each of these functions computes a transaction

#transaction

#abbrev_date! changes date to the corroct format

#get_ledger_entry -- tests that ledger is in dictioary
#get_account_entry -- tests that account is in ledger


#calc_debit_balance!-- computes balance of debited accounts
#calc_credit_balance!-- computes balance of credited accounts

#add2ledger! -- adds trancations to the appropreate ledgers

# ╔═╡ f25d873c-baed-4780-8194-34a7a0ab9781
function abbrev_date!(date)
 d = Date(date,DateFormat("d u Y"))
 Dates.format(d, "d u Y")


end

# ╔═╡ 972dfdd1-b17e-45fd-80ee-a57fa16ac98c
abbrev_date!("11 Oct 2021")

# ╔═╡ 51eac085-878e-4cc4-a26b-befc09430d43
function get_ledger_entry(general_ledger, ledger_entry)
	if haskey(general_ledger["debit"], ledger_entry)
		return general_ledger["debit"][ledger_entry]
	elseif haskey(general_ledger["credit"], ledger_entry)
		return general_ledger["credit"][ledger_entry]
	else
		return nothing
	end
end

# ╔═╡ b3defa9c-148e-487e-ac56-d8110554033e
function get_account_entry(ledger_entry, account_entry)
	if haskey(ledger_entry, account_entry)
		return ledger_entry[account_entry]
	else
		return nothing
	end
end

# ╔═╡ cb281fcf-3a91-4fbf-b5f6-a561c928d05d
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

# ╔═╡ fe229e2d-4030-43af-864b-c127c27ed973
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

# ╔═╡ 3c0ba899-6da3-4593-aca3-8c855a9abfb1
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

# ╔═╡ 5bf69e60-f5f3-4106-b4a0-5d2845000e7f
function transaction(memo, date,
	debit_ledger_entries=[], debit_account_entries=[],
	debit_amount_entries=[], credit_ledger_entries=[],
	credit_account_entries=[], credit_amount_entries=[],
	general_ledger=general_ledger)

	date=abbrev_date!(date)
	
	
	if length(credit_ledger_entries) != length(credit_account_entries)
		return "Error--there must be the same number of credit legders and accounts"
	end
	if length(credit_account_entries) != length(credit_amount_entries)
		return "Error-- each account needs a value and vice versa"
	end
	if length(debit_ledger_entries) != length(debit_account_entries)
	    return "Error--there must be the same number of debit legders and accounts"
	end
	if length(debit_account_entries) != length(debit_amount_entries)
		return "Error-- each debit account needs a value and vice versa"
	end
	if (round(Dec64(sum(debit_amount_entries)),digits=2)
	  -round(Dec64(sum(credit_amount_entries)),digits=2))!=0
		return "Error-total credits does not match total debits"
	end

	journal_entry=DataFrame(Date=[date],
							DebitedAccounts=[""],
							CreditedAccounts=[""],
							Debits=Vector{Dec64}([0.00]),
							Credits=Vector{Dec64}([0.00]),
							Balance=Vector{Dec64}([0.00]))

	i=1
	while i <= length(debit_amount_entries)
		ledger_entry = get_ledger_entry(general_ledger, debit_ledger_entries[i])
		if ledger_entry == nothing
        	return "Error -- "*debit_ledger_entries[i]*" not found"
		end
		account_entry = get_account_entry(ledger_entry, debit_account_entries[i])
        
		if account_entry == nothing
            return "Error -- "*debit_account_entries[i]*" not found in "*debit_ledger_entries[i]*"."
        end
		

        debit_amount_entries[i]=round(Dec64(debit_amount_entries[i]),digits=2)
    	i+=1
    end

	i=1
	while i <= length(credit_amount_entries)
		
		ledger_entry = get_ledger_entry(general_ledger, credit_ledger_entries[i])
		
		if ledger_entry == nothing
			return "Error -- "*credit_ledger_entries[i]*" not found"
		end
		
		account_entry = get_account_entry(ledger_entry, credit_account_entries[i])
		
		if account_entry == nothing
			return "Error -- "*credit_account_entries[i]*" not found in "*credit_ledger_entries[i]*"."
        end

        credit_amount_entries[i]=round(Dec64(credit_amount_entries[i]),digits=2)
    	i+=1
    end

	i=1
  	while i <= length(debit_ledger_entries)
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

    push!(journal_entry,["","Total","Transaction",
                round(sum(journal_entry.Debits); digits=2),
                round(sum(journal_entry.Credits); digits=2),0])
    return (journal_entry, memo)
end;

# ╔═╡ 4c1aaf5b-2f56-4384-b376-6466f66cdbc9
"""These functions exist to comupte tables based on lists of transactions"""

# ╔═╡ 8967af80-b20f-419f-9503-e334e4ae622c
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

# ╔═╡ 9277778a-4b68-4c6f-9330-ec0886008f90
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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
DecFP = "55939f99-70c6-5e9b-8bb0-5071ed7d61fd"
FunSQL = "cf6cc811-59f4-4a10-b258-a8547a8f6407"

[compat]
DataFrames = "~1.2.2"
DecFP = "~1.1.0"
FunSQL = "~0.7.0"
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
git-tree-sha1 = "a325370b9dd0e6bf5656a6f1a7ae80755f8ccc46"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.7.2"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "31d0151f5716b655421d9d75b7fa74cc4e744df2"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.39.0"

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

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FunSQL]]
deps = ["Dates", "PrettyPrinting"]
git-tree-sha1 = "075f45514e3f0226cbcce4aad910ccaaa668fce8"
uuid = "cf6cc811-59f4-4a10-b258-a8547a8f6407"
version = "0.7.0"

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

[[deps.PrettyPrinting]]
git-tree-sha1 = "a5db8a42938bc65c2679406c51a8f5fe9597c6e7"
uuid = "54e16d92-306c-5ea0-a30b-337be88ac337"
version = "0.3.2"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "69fd065725ee69950f3f58eceb6d144ce32d627d"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.2.2"

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
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "793793f1df98e3d7d554b65a107e9c9a6399a6ed"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.7.0"

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
git-tree-sha1 = "fed34d0e71b91734bf0a7e10eb1bb05296ddbcd0"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.0"

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
# ╠═3d5e6bd6-27a8-11ec-3e7d-15c091c0a256
# ╠═28acaf3f-3444-42b9-818d-88d383566773
# ╠═331e3481-981e-4dc0-b9c9-033770034e46
# ╠═1e9751a4-ebef-4d77-891b-f5f2662638ed
# ╠═d1d70ab3-2f12-442a-bfef-a886ccfaaf34
# ╠═ef2d01d1-82c0-4840-987a-ac4a43e46bdd
# ╠═f25d873c-baed-4780-8194-34a7a0ab9781
# ╠═972dfdd1-b17e-45fd-80ee-a57fa16ac98c
# ╠═51eac085-878e-4cc4-a26b-befc09430d43
# ╠═b3defa9c-148e-487e-ac56-d8110554033e
# ╠═5bf69e60-f5f3-4106-b4a0-5d2845000e7f
# ╠═fe229e2d-4030-43af-864b-c127c27ed973
# ╠═3c0ba899-6da3-4593-aca3-8c855a9abfb1
# ╠═cb281fcf-3a91-4fbf-b5f6-a561c928d05d
# ╠═4c1aaf5b-2f56-4384-b376-6466f66cdbc9
# ╠═8967af80-b20f-419f-9503-e334e4ae622c
# ╠═9277778a-4b68-4c6f-9330-ec0886008f90
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

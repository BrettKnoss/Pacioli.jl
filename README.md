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

Wait for Tutorial!


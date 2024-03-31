#Requires -Modules Microsoft.PowerShell.ConsoleGuiTools
using namespace Terminal.Gui

$TermGuiModule = 'Terminal.Gui.dll'
$NStackModule = 'NStack.dll'
$ConsoleGuiModule = 'Microsoft.PowerShell.ConsoleGuiTools'

function Find-TerminalGuiDll {
	[OutputType([string])]
	param()

	$m = Get-Module -Name $ConsoleGuiModule
	
	if ($m -eq $null) {
		throw "Microsoft.PowerShell.ConsoleGuiTools module not found"
	}
	$p = $m.Path
	
	$d1 = Get-ChildItem -Path $p -Recurse -Filter $NStackModule -ErrorAction SilentlyContinue
	$d2 = Get-ChildItem -Path $p -Recurse -Filter $TermGuiModule -ErrorAction SilentlyContinue

	return $d1,$d2
}

function Add-TerminalGuiTypes {
	[OutputType([void])]
	param()

	$modulePaths = Find-TerminalGuiDll
	$modulePaths | % {
		
		Add-Type -Path $_
	}
	
}


function New-TGApplication {
	
	
	return [Terminal.Gui.Application]::new()
}

Add-TerminalGuiTypes
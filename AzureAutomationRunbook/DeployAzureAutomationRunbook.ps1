param (
    [string][Parameter(Mandatory=$true)]$ConnectedServiceName,
    [string][Parameter(Mandatory=$true)]$ResourceGroupName,
    [string][Parameter(Mandatory=$true)]$AutomationAccountName,
    [string][Parameter(Mandatory=$false)]$AutomationRunbook = $null,
    [string][Parameter(Mandatory=$false)]$RunbookFile = $null,
    [string][Parameter(Mandatory=$false)]$StartRunbookJob,
    [string][Parameter(Mandatory=$false)]$RunbookToStart,
    [string][Parameter(Mandatory=$false)]$RunbookParametersFile = $null,
    [string][Parameter(Mandatory=$false)]$HybridWorker = $null
)

$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

if ($AutomationRunbook -and (-not($RunbookFile) -or ($RunbookFile -eq "D:\a\r1\a"))) {
    if ($StartRunbookJob -eq "true") {
        & ".\StartRunbook.ps1" -ConnectedServiceName $ConnectedServiceName -ResourceGroupName $ResourceGroupName `
        -AutomationAccountName $AutomationAccountName -RunbookName $AutomationRunbook -RunbookParametersFile $RunbookParametersFile -RunOn $HybridWorker
    }
}

elseif ($RunbookFile -and ($RunbookFile -ne "D:\a\r1\a") -and (-not($AutomationRunbook))) {
    & ".\ImportRunbook.ps1" -ConnectedServiceName $ConnectedServiceName -ResourceGroupName $ResourceGroupName `
    -AutomationAccountName $AutomationAccountName -RunbookPath $RunbookFile
    
    if ($StartRunbookJob -eq "true") {
        & ".\StartRunbook.ps1" -ConnectedServiceName $ConnectedServiceName -ResourceGroupName $ResourceGroupName `
        -AutomationAccountName $AutomationAccountName -RunbookName $RunbookToStart -RunbookParametersFile $RunbookParametersFile -RunOn $HybridWorker
    }
}
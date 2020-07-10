<#
    .SYNOPSIS
        Use this script in your Azure Automation Account to start and stop a VM.
        The Automation Schedule will handle the timing of each action.
	.NOTES
	@Author: Rene Rebsdorf, renerebsdorf@gmail.com
#>

Param(
    [Parameter(Mandatory=$true)][string]$VmName,
    [Parameter(Mandatory=$true)][string]$ResourceGroupName,
    [Parameter(Mandatory=$true)][ValidateSet("Startup", "Shutdown")][string]$VMAction
)
 
# Authenticate with your Automation Account
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Add-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
 
# Startup VM
switch ($VMAction) {
    "Startup" { Start-AzVM -Name $VmName -ResourceGroupName $ResourceGroupName }
    "Shutdown" { Stop-AzVM -Name $VmName -ResourceGroupName $ResourceGroupName -Force }
}

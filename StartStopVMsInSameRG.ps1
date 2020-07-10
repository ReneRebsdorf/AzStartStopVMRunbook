<#
    .SYNOPSIS
        Use this script in your Azure Automation Account to start and stop VM machines in the same resource group.
        The VMNames parameter is a comma-separated string.
        The Automation Schedule will handle the timing of each action.
	.NOTES
	@Author: Rene Rebsdorf, renerebsdorf@gmail.com
#>

Param(
    # Comma-separated list of VMs
    [Parameter(Mandatory=$true)][string]$VMNames,
    [Parameter(Mandatory=$true)][string]$ResourceGroupName,
    [Parameter(Mandatory=$true)][ValidateSet("Startup", "Shutdown")][string]$VMAction
)
 
# Authenticate with your Automation Account
#$Conn = Get-AutomationConnection -Name AzureRunAsConnection
#Add-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
 
# Split VMNames String into Array if multiple VMNames are provided 
if ($VMNames.Contains(",")) {
    Write-Verbose "Splitting VMNames param into array"
    $VMNamesArr = $VMNames.Split(",")
} else {
    Write-Verbose "Only One VM provided"
    $VMNamesArr = @($VMNames)    
}

# Perform VMAction on each VM
Write-Verbose "Performing $VMAction on $($VMNamesArr.Count) VM(s)"
foreach ($VMName in $VMNamesArr) {
    Write-Verbose "Performing action $VMAction on $VMName in RG: $ResourceGroupName"
    switch ($VMAction) {
        "Startup" {
            #Start-AzVM -Name $VmName -ResourceGroupName $ResourceGroupName 
            break
        }
        "Shutdown" { 
            #Stop-AzVM -Name $VmName -ResourceGroupName $ResourceGroupName -Force 
            break
        }
        Default { 
            throw "this shouldn't happen due to ValidateSet in param" 
        }
    }
}
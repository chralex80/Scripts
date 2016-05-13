function New-Portgroup
{
<#
.SYNOPSIS 
Creates a new portgroup on entire Datacenter, Cluster or single host.   
.DESCRIPTION
This function is useful for mass creating new portgroups on standard vSwitches.
.PARAMETER Target
Can be value Datacenter, Cluster or Host. Use TAB to autocomplete.
.PARAMETER Targetname
Name of Datacenter, Cluster or Host.
.PARAMETER vSwitch
Name of vSwitch to be targeted.
.PARAMETER PGname
Name for the new portgroup.
.PARAMETER VlanID
VLAN ID for the new portgroup. 

.EXAMPLE
New-Portgroup -Target Cluster -Targetname MainCluster1 -vSwitch vSwitch1 -PGname Dev-Net -VlanID 2345
.EXAMPLE
New-Portgroup -Target Datacenter -Targetname ProdDataCenter1 -vSwitch vSwitch1 -PGname DMZ -VlanID 1337
.NOTES
AUTHOR:    Christian A. Seneger
BLOG:      https://msitpros.com
LASTEDIT:  11.05.2016
VERSION: 1.1
#>

param (
		[Parameter(Mandatory=$True)][ValidateSet("Datacenter","Cluster","Host")][string]$Target,
        [Parameter(Mandatory=$True)][string]$Targetname,
		[Parameter(Mandatory=$True)][string]$vSwitch,
        [Parameter(Mandatory=$True)][string]$PGname,
        [Parameter(Mandatory=$False)][string]$VlanID
        )

if ($Target -match 'Datacenter')
    {
        Get-datacenter $Targetname | Get-VMHost | Get-VirtualSwitch -Name $vSwitch | New-VirtualPortGroup -Name $PGname -VLanId $VlanID
    }
if ($Target -match 'Cluster')
    {
        Get-cluster $Targetname | Get-VMHost | Get-VirtualSwitch -Name $vSwitch | New-VirtualPortGroup -Name $PGname -VLanId $VlanID
    }
if ($Scope -match 'Host')
    {
        Get-VMHost -Name $Targetname | Get-VirtualSwitch -Name $vSwitch | New-VirtualPortGroup -Name $PGname -VLanId $VlanID
    }
}
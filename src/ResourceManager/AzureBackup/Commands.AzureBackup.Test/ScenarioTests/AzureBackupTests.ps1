﻿# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

$ResourceGroupName = "backuprg"
$ResourceName = "backuprn"
$ContainerName = "iaasvmcontainer;dev01testing;dev01testing"
$ContainerType = "IaasVMContainer"
$DataSourceType = "VM"
$DataSourceId = "17593283453810"
$Location = "SouthEast Asia"

<#
.SYNOPSIS
Tests creating new resource group and a simple resource.
#>
function Test-GetAzureBackupProtectionPolicyTests
{
	$protectionPolicies = Get-AzureBackupProtectionPolicy -ResourceGroupName $ResourceGroupName -ResourceName $ResourceName
	Assert-NotNull $protectionPolicies 'Protection Policies should not be null'
	foreach($protectionPolicy in $protectionPolicies)
	{
		Assert-NotNull $protectionPolicy.InstanceId 'InstanceId should not be null'
		Assert-NotNull $protectionPolicy.Name 'Name should not be null'
		Assert-NotNull $protectionPolicy.WorkloadType 'WorkloadType should not be null'
		Assert-NotNull $protectionPolicy.BackupType 'BackupType should not be null'
		Assert-NotNull $protectionPolicy.ScheduleRunTimes 'ScheduleRunTimes should not be null'
		Assert-NotNull $protectionPolicy.RetentionDuration 'RetentionDuration should not be null'
		Assert-NotNull $protectionPolicy.ResourceGroupName 'ResourceGroupName should not be null'
		Assert-NotNull $protectionPolicy.ResourceName 'ResourceName should not be null'
	}
}

function GetAzureRecoveryPointTest
{
    $azureBackUpItem = New-Object Microsoft.Azure.Commands.AzureBackup.Cmdlets.AzureBackupItem
	$azureBackUpItem.ResourceGroupName = $ResourceGroupName
	$azureBackUpItem.ResourceName = $ResourceGroupName
	$azureBackUpItem.Location = $Location
	$azureBackUpItem.ContainerUniqueName = $ContainerName
	$azureBackUpItem.ContainerType = $ContainerType
	$azureBackUpItem.DataSourceId = $DataSourceId
	$azureBackUpItem.Type = $DataSourceType
	$recoveryPoints = Get-AzureBackupRecoveryPoint -item $azureBackUpItem
	Assert-NotNull $recoveryPoints 'Recovery Points should not be null'
	foreach($recoveryPoint in $recoveryPoints)
	{
	    Assert-NotNull $recoveryPoint.RecoveryPointTime 'RecoveryPointTime should not be null'
		Assert-NotNull $recoveryPoint.RecoveryPointType 'RecoveryPointType should not be null'
		Assert-NotNull $recoveryPoint.RecoveryPointId  'RecoveryPointId should not be null'
	}
}

function BackUpAzureBackUpItemTest
{
    $azureBackUpItem = New-Object Microsoft.Azure.Commands.AzureBackup.Cmdlets.AzureBackupItem
	$azureBackUpItem.ResourceGroupName = $ResourceGroupName
	$azureBackUpItem.ResourceName = $ResourceName
	$azureBackUpItem.Location = $Location
	$azureBackUpItem.ContainerUniqueName = $ContainerName
	$azureBackUpItem.ContainerType = $ContainerType
	$azureBackUpItem.DataSourceId = $DataSourceId
	$azureBackUpItem.Type = $DataSourceType
	$jobId = Backup-AzureBackupItem -item $azureBackUpItem
}



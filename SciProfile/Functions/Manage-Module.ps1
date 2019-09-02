# ============================================================================
#   Manage-Module.ps1 --------------------------------------------------------
# ============================================================================

#   validation ---------------------------------------------------------------
# ----------------------------------------------------------------------------
Class ValidatePSModuleAlias: System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [String[]] (Get-ProjectList -Unformatted | Where-Object {$_.Type -eq "psmodule"} | Select-Object -ExpandProperty Alias)
    }
}

#   function -----------------------------------------------------------------
# ----------------------------------------------------------------------------
function Import-FunctionSci {

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([PSCustomObject])]

    Param()

    Process {
        Get-ChildItem -Path $SciProfile.ScriptDir -Filter "*.ps1" | ForEach-Object {
            . $_.FullName
        }        
    }
}

#   function -----------------------------------------------------------------
# ----------------------------------------------------------------------------
function Import-ModuleSci {
    
    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([PSCustomObject])]

    Param(
        [Parameter(Position=1)]
        [System.String] $Profile = "Default"
    )

    Process {
        if ((New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)){
            $Profile = "Admin"
        }

        $profiles = Get-Content $SciProfile.Import | ConvertFrom-Json

        Write-FormattedProcess -Message "Begin to import profile '$Profile'" -Module $SciProfile.Name
        $profiles | Select-Object -ExpandProperty $Profile  | ForEach-Object {
            Write-FormattedMessage -Type "Import" -Message $_ -Color Cyan -Module $SciProfile.Name
            Import-Module -Name $_
        }

        if ($VerbosePreference){
            return Get-Module
        }
        return 
    }
}

#   function -----------------------------------------------------------------
# ----------------------------------------------------------------------------
function Remove-ModuleSci {
    
    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([PSCustomObject])]

    Param(
        [Parameter(Position=1, Mandatory=$True)]
        [System.String] $Profile
    )

    Process {
        $profiles = Get-Content $SciProfile.Import | ConvertFrom-Json

        $profiles | Select-Object -ExpandProperty $Profile  | ForEach-Object {
            Remove-Module -Name $_
        }

        Write-FormattedSuccess -Message "Finished removing profile '$Profile'." -Space -Module $SciProfile.Name
        
        if ($VerbosePreference){
            return Get-Module
        }
        return 
    }
}

#   function -----------------------------------------------------------------
# ----------------------------------------------------------------------------
function Import-RepositorySci {

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([PSCustomObject])]

    Param(
        [ValidateSet([ValidatePSModuleAlias])]
        [Parameter(Position=1, HelpMessage="Name or alias of an project.")]
        [System.String] $Name
    )

    Process {

        $module = Select-Project -Name $Name -Property "Name" -Type "PSModule"
        $module_path = Select-Project -Name $Name -Property "Local" -Type "PSModule"
        
        if ($module_path -and (Test-Path -Path $module_path)) {
            $SciProfile.ModuleDir | ForEach-Object {
                $module_local = (Join-Path -Path $_ -ChildPath $module)
                if (Test-Path  -Path  $module_local){
                    Remove-Item -Path $module_local -Recurse -Force
                }
                Write-FormattedProcess -Message "Begin to copy module to '$($module_local)'." -Module $SciProfile.Name
                Copy-Item -Path $module_path -Destination $module_local -Recurse -Force
                Write-FormattedSuccess -Message "Module copied to '$($module_local)'." -Module $SciProfile.Name
            }
        }      
        else { 
            Write-FormattedError -Message "Path of module $($module) is not valid." -Module $SciProfile.Name
        }
    }
}

# ============================================================================
#   Manage-Module.ps1 --------------------------------------------------------
# ============================================================================

#   function -----------------------------------------------------------------
# ----------------------------------------------------------------------------
function Import-PSMFunction {

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
function Import-PSMModule {
    
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
function Remove-PSMModule {
    
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
function Import-PSMRepository {

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([PSCustomObject])]

    Param(
        [ValidateSet([ValidatePSModuleProject])]
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

#   function -----------------------------------------------------------------
# ----------------------------------------------------------------------------
function Install-PSMRepository {

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([PSCustomObject])]

    Param(
        [ValidateSet([ValidatePSModuleProject])]
        [Parameter(Position=1, HelpMessage="Name or alias of an project.")]
        [System.String] $Name
    )

    Process {
        
        Import-PSMRepository -Name $Name

        Start-Process -FilePath "pwsh" -Wait -NoNewWindow

        $module = Select-Project -Name $Name -Property "Name" -Type "PSModule"
        Import-Module $module -Scope "Global"
    }
}




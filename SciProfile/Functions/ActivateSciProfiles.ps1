# ===========================================================================
#   ActivateSciProfileAutocompletion.ps1 ------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function ActivateSciProfileAutocompletion {

    <#
    .DESCRIPTION
        Import PSPocs activating autocompletion for validating input of module functions.

    .OUTPUTS
        ScriptBlock. Scriptblock with using command.
    #>

    [CmdletBinding(PositionalBinding)]

    [OutputType([ScriptBlock])]

    Param()

    Process {

        $script_list = @(
            ActivateVirtualEnvAutocompletion
            ActivatePocsAutocompletion
            $(Get-Command $(Join-Path -Path $Module.ClassDir -ChildPath "ModuleValidation.ps1") | Select-Object -ExpandProperty ScriptBlock)
        )

        return Join-ScriptBlock -Scripts $script_list
    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function ValidateSciProfileProjectType {

    <#
    .DESCRIPTION
        Return values for the use of validating existing
    
    .OUTPUTS
        System.String[]. Virtual environments
    #>

    [CmdletBinding(PositionalBinding)]
    
    [OutputType([System.String[]])]

    Param(
        [Parameter(Position=1, HelpMessage="Existing project type.")]
        [System.String] $Type
    )

    Process{

        $project_list = Get-ProjectList -Unformatted
        if ($Type) {
            $project_list | Where-Object { $_.Type -eq $Type }
        }

        return $project_list | Select-Object -ExpandProperty "Alias"
    
    }
}
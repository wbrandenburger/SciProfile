# ===========================================================================
#   Get-Validation.ps1 ------------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Get-ValidateProjectType {

    <#
    .DESCRIPTION
        Return values for the use of validating existing
    
    .OUTPUTS
        System.String[]. Virtual environments
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([System.String[]])]

    Param(
        [Parameter(Position=1, HelpMessage="Existing project type.")]
        [System.String] $Type="Project"
    )

    Process{

       return (Get-ProjectList -Unformatted | Where-Object { $_.Type -eq $Type } | Select-Object -ExpandProperty "Alias")
    
    }
}



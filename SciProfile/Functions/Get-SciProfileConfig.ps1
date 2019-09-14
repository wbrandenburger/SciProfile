# ===========================================================================
#   Get-SciProfileConfig.ps1 -----------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Get-SciProfileConfig {

    <#
    .SYNOPSIS

    .DESCRIPTION

    .OUTPUTS

    #>

    [CmdletBinding(PositionalBinding)]

    [OutputType([System.String])]

    Param()

    Process {

        $config_content = Get-IniContent -FilePath $Module.Config -IgnoreComments
        $config_content = Format-IniContent -Content $config_content -Substitution $SciProfile 
        
        $result = @()
        $config_content.Keys | ForEach-Object {
            $result += $config_content[$_] 
        }

        return $result | Format-Table

    }

}

# ===========================================================================
#   Get-Projects.ps1 --------------------------------------------------------
# ===========================================================================

#   validation --------------------------------------------------------------
# ---------------------------------------------------------------------------
Class ValidateProjectAlias: System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [String[]] ((Get-ProjectList -Unformatted | Select-Object -ExpandProperty "Alias") + "")
    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Get-ConfigurationFile {
    
    <#
    .DESCRIPTION
        Returns the path of a single module project configuration file.
    
    .PARAMETER Type

    .OUTPUTS
        System.String. Path of project configuration file.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([Void])]

    Param (
        [Parameter(Position=1, HelpMessage="Existing project type.")]
        [System.String] $Type="Project"
    )

    Process {

        return Join-Path -Path $SciProfile.ProjectDir -ChildPath "$($Type.ToLower()).json"

    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function New-ConfigurationFile {

    <#
    .DESCRIPTION
        Returns an object containing projects of all types found in modules project directory.

    .OUTPUTS
        System.String. Path of project configuration file.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([PSCustomObject])]

    Param ()

    Process {
        $project_name = "Project"

        $project_file = Get-ConfigurationFile -Type $project_name
        $project_json = $(ConvertTo-Json $project_list)

        if (Test-Path -Path $project_file) {
            Remove-Item -Path $project_file -Force
        }

        $project_list = @()
        Get-ChildItem -Path $SciProfile.ProjectDir -Filter "*.json" | ForEach-Object{
            $fileData = Get-Content $_ | ConvertFrom-Json
            $project_list += $fileData | Select-Object -Property $SciProfile.Format
        }

        Out-File -FilePath $project_file -InputObject $project_json

        return $project_file
    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Get-ProjectList {

    <#
    .DESCRIPTION
        Returns all entries of each user defined project type.
    
    .PARAMETER Type

    .PARAMETER Unformatted

    .OUTPUTS
        PSCustomObject. All project entries related to specified type.
    #>
    
    [CmdletBinding()]

    [OutputType([PSCustomObject])]

    Param (
        [Parameter(Position=1, HelpMessage="Existing project type.")]
        [System.String] $Type="Project",

        [Parameter(HelpMessage="Does not return information as readable table.")]
        [Switch] $Unformatted
    )

    Process {
        $project_file = Get-ConfigurationFile -Type $Type
        if ($Type -eq "Project" -and -not $(Test-Path -Path $project_file)) {
            New-ConfigurationFile
        }

        $project_list = Get-Content  $project_file | ConvertFrom-Json

        if ($Unformatted) {
            return $project_list
        }
        return Format-Project -Type $Type -Projects $project_list
    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Format-Project {
    
    <#
    .DESCRIPTION
        Returns all entries of each user defined project type as formatted table.
    
    .PARAMETER Type

    .PARAMETER Projects
    
    .OUTPUTS
        Format. All project entries as formatted table.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([PSCustomObject])]

    Param (
        [Parameter(Position=1, HelpMessage="Existing project type.")]
        [System.String] $Type="Project",

        [Parameter(Position=2, HelpMessage="Project list with all entries of specified project type")]
        [PSCustomObject] $Projects
    )

    Process {

        return $Projects | Format-Table -Property $SciProfile.Format

    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Test-Project {

    <#
    .DESCRIPTION
        Check whether a list of projects contains a entry with specified identifier.
    
    .PARAMETER Name

    .PARAMETER Projects

    .OUTPUTS
        PSCustomObject. Project which contains the specified identifier.
    #>

    [CmdletBinding(PositionalBinding=$True)]

    [OutputType([PSCustomObject])]

    Param (

        [Parameter(Position=1, HelpMessage="Name or alias of an project.")]
        [System.String] $Name,

        [Parameter(Position=2, HelpMessage="Project list with all entries of specified project type")]
        [PSCustomObject] $Projects
    )
    
    Process {

        $project = $Projects | Where-Object {$_.Name -eq $Name -or $_.Alias -eq $Name}
        if ($project) {
            return $project
        }
    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Get-ProjectType {

    <#
    .DESCRIPTION
        Get project type of specified identifier.
    
    .PARAMETER Name

    .OUTPUTS
        System.String. Project type of specified identifier
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([PSCustomObject])]

    Param(
        [Parameter(Position=1, HelpMessage="Name or alias of an project.")]
        [System.String] $Name
    )

    $project_list = Get-ProjectList -Unformatted
    $project = Test-Project -Name $Name -Projects $project_list

    if ($project) {
        return $project | Select-Object -ExpandProperty "Type"
    }
    else {
        Write-FormattedError -Message "No entry with user specification '$($Name)' was found in project type '$($Type)'." -Module $SciProfile.Name
        return
    }

}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Select-Project {

    <#
    .DESCRIPTION
        Returns a project entry as dictionary for a given.
    
    .PARAMETER Name

    .PARAMETER Property

    .PARAMETER Project

    .OUTPUTS
        PSCustomObject. All project entries as formatted table.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([PSCustomObject])]

    Param (
        [Parameter(Position=1, HelpMessage="Name or alias of an project.")]
        [System.String] $Name,

        [Parameter(Position=2, HelpMessage="Property of project entry, which shall be returned.")]
        [System.String] $Property,

        [Parameter(Position=1, HelpMessage="Existing project type.")]
        [System.String] $Type="Project"
    )

    Process{ 

        $project_list = Get-ProjectList -Type $Type -Unformatted
        $project = Test-Project -Name $Name -Projects $project_list

        if ($project.($Property)) {
            return  $project | Select-Object -ExpandProperty $Property
        }
        else {
            Write-FormattedError -Message "No property '$($Property)' for user specification '$($Name)' was found in project type '$($Type)'." -Module $SciProfile.Name
            return
        }
    }
}


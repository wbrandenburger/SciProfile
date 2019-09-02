# ===========================================================================
#   SciProfile_Config.ps1 ---------------------------------------------------
# ===========================================================================

#   configuration -----------------------------------------------------------
# ---------------------------------------------------------------------------

New-ProjectConfigDirs -Name $Module.Name.toLower()

# search for the local configuration file
if (-not $(Test-Path $Module.Config)) {
    $default_config_string | Out-File -FilePath $Module.Config -Force
}

@(
    @{  # manifest 
        Name="Manifest"
        Value=Join-Path -Path $Module.Dir -ChildPath ($Module.Name + ".psd1")
    }
    @{  # directory of functions
        Name="FunctionsDir"
        Value=Join-Path -Path $Module.Dir -ChildPath "Functions"
    }
    @{  # directory of functions
        Name="TestsDir"
        Value=Join-Path -Path $Module.Dir -ChildPath "Tests"
    }
    @{  # configuration file and content of configuration file
        Name="ConfigContent" 
        Value=Get-IniContent -FilePath $Module.Config
    }
) | ForEach-Object {
    $Module | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value
}

# set the default path where the virtual environments are located and their subdirectories defined in the configuration file
$SciProfile= New-Object -TypeName PSObject -Property @{
    Name = $Module.Name
}

$work_dir = Get-ConfigProjectDir -Name $Module.Name
@( 
    @{
        Name="work-dir"; Section="user"; Field="WorkDir"; 
        Default=$work_dir
    }
    @{
        Name="config-dir"; Section="user"; Field="ConfigDir"; 
        Default=$(Join-Path -Path $work_dir -ChildPath "config")
    }
    @{
        Name="scripts-dir"; Section="user"; Field="ScriptDir"; 
        Default=$(Join-Path -Path $work_dir -ChildPath "scripts")
    }
    @{
        Name="project-dir"; Section="user"; Field="ProjectDir"; 
        Default=$(Join-Path -Path $work_dir -ChildPath "project")
    }
    @{
        Name="local-dir"; Section="user"; Field="LocalDir"
        Default=$(Join-Path -Path $work_dir -ChildPath ".temp")
    }
    @{
        Name="module-dir"; Section="sciprofile"; Field="ModuleDir"
        Default=$(Join-Path -Path $work_dir -ChildPath "modules")
    }
) | ForEach-Object {
    $content = $Module.ConfigContent[$_.Section][$_.Name]

    if (-not $content -or -not $(Test-Path -Path $content)) {
        
        $path = $content
        if (-not $content) {
            $path = $_.Default
            $Module.ConfigContent | Set-IniContent -Sections $_.Section -NameValuePairs @{ $_.Name = $_.Default}
        }

        Write-FormattedWarning -Message "The path $($content) defined in field $($_.Name) of the module configuration file can not be found. Default directory $($path) will be created." -Module $Module.Name

        $content = $path
        If (-not $(Test-Path $path)) {
            New-Item -Path $path -ItemType Directory
        }
    }

    $SciProfile  | Add-Member -MemberType NoteProperty -Name $_.Field -Value $content
}

@( 
    @{Field="Format"; Value=@("Name", "Alias", "Type", "Description", "Folder", "Url")}
    @{Field="Import"; Value=Join-Path -Path $SciProfile.ConfigDir -ChildPath "import.json"}
) | ForEach-Object {
    $SciProfile  | Add-Member -MemberType NoteProperty -Name $_.Field -Value  $_.Value
}

$Module.ConfigContent | Out-IniFile -FilePath $Module.Config -Force
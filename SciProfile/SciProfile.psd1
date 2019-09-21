

@{
#
# Module manifest for module "SciProfile"
#
# Generated by: Wolfgang Brandenburger
#
# Generated on: 9/1/2019
#

# Script module or binary module file associated with this manifest.
RootModule = "SciProfile.psm1"

# Version number of this module.
ModuleVersion = "0.3.8"

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = "d2d0db7b-3fd0-47f4-ab12-19ed94d65590"

# Author of this module
Author = "Wolfgang Brandenburger <wolfgang.brandenburger@outlook.com>"

# Company or vendor of this module
CompanyName = ""

# Copyright statement for this module
Copyright = "(c) Wolfgang Brandenburger. All rights reserved."

# Description of the functionality provided by this module
Description = "The module SciProfile is a set of powershell extensions to the default powershell profile. The focus is on scientific work with python and C++."

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = "6.0"

# Name of the PowerShell host required by this module
# PowerShellHostName = ""

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ""

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ""

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ""

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ""= ""

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(
    @{
        ModuleName = "PSIni"; 
        ModuleVersion = "3.1.2"; 
    }
    @{
        ModuleName = "PSVirtualEnv";
        ModuleVersion = "0.5.0";
        GUID = "ca0b4a5a-af4a-416f-a478-e12d116f95b4";
    }
    @{
        ModuleName = "PSPocs"; 
        ModuleVersion = "0.4"; 
        GUID = "b20a743f-e2c0-4be9-9b96-076a7c6dad6a";
    }
)

# Assembslies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller"s environment prior to importing this module.
ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @("PSModuleUtils\PSModuleUtils.psm1")

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    "Attempt"
    "ActivateSciProfileAutocompletion",
    "Get-ProjectList",
    "New-ConfigurationFile",
    "Set-ProfileProjectList",
    "Get-ProjectLocation",
    "Get-WebLocation",
    "Get-ProjectChildItem",
    "Get-ValidateProjectType"
    "Set-ProjectLocation",
    "Open-ProjectWorkspace",
    "Open-ProjectFileExplorer",
    "Open-ProjectBrowser",
    "Import-PSMFunction",
    "Import-PSMModule",
    "Remove-PSMModule",
    "Import-PSMRepository",
    "Install-PSMRepository",
    "Get-EnvVariable",
    "Set-EnvVariable",
    "Test-EnvPath",
    "Test-Administrator"
    "Get-SciProfileConfig",
    "Edit-SciProfileConfig", 
    "ValidateSciProfileProjectType",
    "ValidateSciProfileConfigFiles"
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = "SciProfile"

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @(
    "activate-sci"
    "cdx",
    "exx",
    "dirx",
    "fox",
    "lsx",
    "ls-env"
    "sx",
    "t-env",
    "s-env",
    "vsx",
    "webx"
)

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @(
            "powershell",
            "profile",
            "management",
            "development",
            "science"
        )

        # A URL to the license for this module.
        LicenseUri = "https://github.com/wbrandenburger/SciProfile"

        # A URL to the main website for this project.
        ProjectUri = "https://github.com/wbrandenburger/SciProfile"

        # A URL to an icon representing this module.
        # IconUri = ""

        # ReleaseNotes of this module
        # ReleaseNotes = ""

        # External dependent modules of this module
        # ExternalModuleDependencies = ""

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ""

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ""

}

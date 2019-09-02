# ===========================================================================
#   SciProfile.psm1 ---------------------------------------------------------
# ===========================================================================

#   modules -----------------------------------------------------------------
# ---------------------------------------------------------------------------
Import-Module -Name $(Join-Path -Path $(Split-Path -Path $MyInvocation.MyCommand.Path -Parent) -ChildPath "Modules\PSUtils") -Scope Local

#   sciprofile---------------------------------------------------------------
# ---------------------------------------------------------------------------
$path = $MyInvocation.MyCommand.Path
$name = [System.IO.Path]::GetFileNameWithoutExtension($path)
$Module = New-Object -TypeName PSObject -Property @{
    Name = $name
    Dir =  Split-Path -Path $path -Parent
    Config = Get-ConfigProjectFile -Name $name
}

#   configuration -----------------------------------------------------------
# ---------------------------------------------------------------------------
. $(Join-Path -Path $Module.Dir -ChildPath "$($Module.Name)_Ini.ps1")

#   configuration -----------------------------------------------------------
# ---------------------------------------------------------------------------
. $(Join-Path -Path $Module.Dir -ChildPath "$($Module.Name)_Config.ps1")

#   functions ---------------------------------------------------------------
# ---------------------------------------------------------------------------
Get-ChildItem -Path $Module.FunctionsDir -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
}

#   environment -------------------------------------------------------------
# ---------------------------------------------------------------------------
# . $(Join-Path -Path $Module.Dir -ChildPath "$($Module.Name)_Environment.ps1")

#   aliases -----------------------------------------------------------------
# ---------------------------------------------------------------------------
. $(Join-Path -Path $Module.Dir -ChildPath "$($Module.Name)_Alias.ps1")
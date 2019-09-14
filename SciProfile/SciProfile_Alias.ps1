# ===========================================================================
#   SciProfile_Alias.ps1 ---------------------------------------------------
# ===========================================================================

#   aliases -----------------------------------------------------------------
# ---------------------------------------------------------------------------

# define aliases for specific function
@(
    @{ Name = "activate-sci";  Value = "ActivateSciProfileAutocompletion"}
    @{ Name = "cdx";  Value = "Set-ProjectLocation"}
    @{ Name = "exx";  Value = "Open-ProjectFileExplorer"}
    @{ Name = "dirx"; Value = "Get-ProjectLocation"}
    @{ Name = "webx"; Value = "Get-WebLocation"}
    @{ Name = "fox";  Value = "Open-ProjectBrowser"}    
    @{ Name = "lsx";  Value = "Get-ProjectChildItem"}
    @{ Name = "vsx";  Value = "Open-ProjectWorkspace"}
    @{ Name = "sx";  Value = "Set-ProfileProjectList"}

) | ForEach-Object {
    New-Alias -Name $_.Name -Value $_.Value
}
    
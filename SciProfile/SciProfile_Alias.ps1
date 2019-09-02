# ===========================================================================
#   SciProfile_Alias.ps1 ---------------------------------------------------
# ===========================================================================

#   aliases -----------------------------------------------------------------
# ---------------------------------------------------------------------------

# define aliases for specific function
@(
    @{ Name = "cdx";  Value = "Set-ProjectLocation"}
    @{ Name = "exx";  Value = "Open-ProjectFileExplorer"}
    @{ Name = "dirx"; Value = "Get-ProjectLocation"}
    @{ Name = "webx"; Value = "Get-WebLocation"}
    @{ Name = "fox";  Value = "Open-ProjectBrowser"}    
    @{ Name = "lsx";  Value = "Get-ProjectChildItem"}
    @{ Name = "vsx";  Value = "Open-ProjectWorkspace"}
    
) | ForEach-Object {
    Set-Alias -Name $_.Name -Value $_.Value
}
    
# Install.ps1
# Install Visual Studio Code extensions and settings

$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ExtensionsPath = Join-Path $ScriptPath "extensions.txt"

if (Test-Path $ExtensionsPath) {
    Get-Content $ExtensionsPath | ForEach-Object {
        code --install-extension $_
    }
}
$ErrorActionPreference = "Stop"

###############################################################################
# Paths
###############################################################################

$Repo = Split-Path -Parent $MyInvocation.MyCommand.Path

###############################################################################
# Helpers
###############################################################################

function Unlink-IfMine {
    param(
        [string]$Destination
    )

    if (-not (Test-Path $Destination)) {
        return
    }

    $Item = Get-Item $Destination

    # Only remove symbolic links
    if (-not $Item.LinkType) {
        Write-Host "Skipped $Destination"
        return
    }

    $RepoPath = (Resolve-Path $Repo).Path
    $TargetPath = (Resolve-Path $Item.Target).Path

    if (-not $TargetPath.StartsWith($RepoPath, [System.StringComparison]::OrdinalIgnoreCase)) {
        Write-Host "Skipped $Destination"
        return
    }

    Remove-Item $Destination -Force

    Write-Host "Removed $Destination"
}

function Uninstall-Manifest {
    param(
        [string]$Manifest
    )

    Get-Content (Join-Path $Repo "manifest\$Manifest") | ForEach-Object {

        $Line = $_.Trim()

        if ($Line -eq "") {
            return
        }

        if ($Line.StartsWith("#")) {
            return
        }

        $Source, $Target = $Line.Split('|')

        $Source = $Source.Trim()
        $Target = $Target.Trim()

        if ($Source -eq "" -or $Target -eq "") {
            return
        }

        Unlink-IfMine (Join-Path $HOME $Target)
    }
}

function Remove-GitInclude {

    $GitConfig = Join-Path $HOME ".gitconfig"

    if (-not (Test-Path $GitConfig)) {
        return
    }

    $Content = Get-Content $GitConfig

    $Output = @()

    $Skip = $false

    foreach ($Line in $Content) {

        if ($Line -eq "# >>> dotfiles install >>>") {
            $Skip = $true
            continue
        }

        if ($Line -eq "# <<< dotfiles install <<<") {
            $Skip = $false
            continue
        }

        if (-not $Skip) {
            $Output += $Line
        }
    }

    Set-Content $GitConfig $Output

    Write-Host "Removed Git include."
}

###############################################################################
# Uninstall
###############################################################################

Write-Host ""
Write-Host "Uninstalling dotfiles..."
Write-Host ""

Uninstall-Manifest "common.manifest"

Uninstall-Manifest "windows.manifest"

Remove-GitInclude

Write-Host ""
Write-Host "Done!"

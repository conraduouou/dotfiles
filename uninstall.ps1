$ErrorActionPreference = "Stop"

# this particular code can be removed if the following PR is resolved:
# https://github.com/charmbracelet/gum/pull/1142
$env:CLICOLOR_FORCE = 1

###############################################################################
# Paths
###############################################################################

$Repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$Tools = Join-Path $HOME "Tools"

###############################################################################
# Helpers
###############################################################################

function Check-Gum {

    if (-not (Get-Command gum -ErrorAction SilentlyContinue)) {
        Write-Host "This uninstall script uses $(Gum-Style "gum") to select plugins to remove."
        Write-Host "Ensure it is installed before using this script."
        exit
    }
}

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
        Gum-StyleFade "Skipped $Destination"
        return
    }

    $RepoPath = (Resolve-Path $Repo).Path
    $TargetPath = (Resolve-Path $Item.Target).Path

    if (-not $TargetPath.StartsWith($RepoPath, [System.StringComparison]::OrdinalIgnoreCase)) {
        Gum-StyleFade "Skipped $Destination"
        return
    }

    Remove-Item $Destination -Force

    Write-Host "Removed $(Gum-Style $Destination)"
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

function Uninstall-Packages {

    $ChocoList = choco list | ForEach-Object { ($_ -split " ")[0] }

    $Packages = Get-Content (Join-Path $Repo "Chocolateyfile") | ForEach-Object {
        $Package = $_.Trim()
        
        if ($ChocoList -contains $Package -and $Package -ne "gum") {
            return $Package
        }
    }

    $Header = "Choose packages to uninstall (this will remove them when you proceed)"
    $PackagesToRemove = gum choose --no-limit --header "$HEADER" $Packages

    Write-Host ""

    if ([string]::IsNullOrEmpty($PackagesToRemove)) {
        return
    }

    Write-Host "Removing $(Gum-Style "packages")..."

    $PackagesToRemove | ForEach-Object {
        $Package = $_.Trim()
        choco uninstall $Package -y
    }

}

function Remove-GitInclude {

    $GitConfig = Join-Path $HOME ".gitconfig"

    if (-not (Test-Path $GitConfig)) {
        Gum-StyleFade "Git include already removed."
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

    Write-Host "Removed $(Gum-Style "Git include")."
}

function Remove-StarshipFile {

    $StarshipFile = Join-Path $HOME ".config/starship.toml"

    if (-not (Test-Path $StarshipFile)) {
        Gum-StyleFade "Starship file already removed."
        return
    }

    Remove-Item $StarshipFile -ErrorAction SilentlyContinue
    Write-Host "Removed $(Gum-Style "Starship file")."
}

function Remove-VimPlug {

    $PlugFile = Join-Path $HOME "vimfiles/autoload/plug.vim"

    if (-not (Test-Path $PlugFile)) {
        Gum-StyleFade "plug.vim already removed."
        return
    }

    Remove-Item $PlugFile -ErrorAction SilentlyContinue
    Write-Host "Removed $(Gum-Style "plug.vim file")."
}

function Remove-Gum {
    
    if (-not (gum confirm "Remove gum as well?")) {
        return
    }
    
    if (-not (gum confirm "Really?")) {
        return
    }

    if (-not (gum confirm "Are you reeeeeally sure? Gum is a GREAT package...")) {
        return
    }

    Gum-StyleFade "Okay...."

    # TODO: change to choco uninstall gum if ever Chocolatey gets gum
    Remove-Item -Recurse -Force (Join-Path $Tools "gum")
    # choco uninstall gum -y
    Write-Host ""
}

function Gum-Style {

    param(
        [string] $Text,
        [string] $Color
    )

    gum style --foreground "$([string]::IsNullOrEmpty(($Color)) ? 212 : $Color)" "$Text"
}

function Gum-StyleFade {
    
    param(
        [string] $Text,
        [string] $Color
    )

    gum style --foreground "$([string]::IsNullOrEmpty(($Color)) ? 241 : $Color)" "$Text"
}

###############################################################################
# Uninstall
###############################################################################

function Main {

    Check-Gum

    Start-Sleep 3

    gum style --border double --border-foreground 212 --padding "1 6" "Remove-INATOR!"
    Write-Host ""

    Uninstall-Packages
    Write-Host ""

    Uninstall-Manifest "common.manifest"
    Write-Host ""

    # Remove plug.vim first before unlinking vim directory
    Remove-VimPlug
    Write-Host ""

    Uninstall-Manifest "windows.manifest"
    Write-Host ""

    Remove-GitInclude
    Remove-StarshipFile
    Write-Host ""

    Write-Host "Done!"
    Write-Host ""
}

Main

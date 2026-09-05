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

function Install-Chocolatey {

    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "Chocolatey already installed."
        return
    }

    Write-Host "Installing Chocolatey..."

    Set-ExecutionPolicy Bypass -Scope Process -Force

    [System.Net.ServicePointManager]::SecurityProtocol =
        [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

    Invoke-Expression (
        (New-Object System.Net.WebClient).DownloadString(
            "https://community.chocolatey.org/install.ps1"
        )
    )
}

function Install-Gum {

    if (Get-Command gum -ErrorAction SilentlyContinue) {
        Write-Host "gum already installed."
        return
    }

    Write-Host "Installing gum..."

    # TODO: Replace the below code once Chocolatey has gum
    try {

        curl.exe -fLo (Join-Path $Tools "gum.zip") `
            "https://github.com/charmbracelet/gum/releases/download/v2.0.0/gum_2.0.0_Windows_x86_64.zip"

        Expand-Archive (Join-Path $Tools "gum.zip") $Tools
        Move-Item (Join-Path $Tools "gum_2.0.0_Windows_x86_64") (Join-Path $Tools "gum")
        Remove-Item (Join-Path $Tools "gum_*")
        Remove-Item (Join-Path $Tools "gum.*")

	. (Join-Path $Repo "config\powershell\path.ps1")

        Write-Host "Installed gum."

    } catch {

        Write-Host "Failed to get gum zip. Please install manually."

    }
    
}

function Install-Packages {

    $Packages = Get-Content (Join-Path $Repo "Chocolateyfile")
    $Packages = $Packages -match "^((?!gum).)*$"

    $Header = "Choose packages to install (This will install them when you proceed)"
    $PackagesToInstall = gum choose --no-limit --header "$Header" --selected "*" $Packages

    if ([string]::IsNullOrEmpty(($PackagesToInstall))) {
        Gum-StyleFade "No packages selected. Skipping installation..."
        return
    }

    Write-Host "Installing $(Gum-Style "packages")..."

    $PackageFile = Join-Path $Repo "Chocolateyfile-temp"
    Write-Output $PackagesToInstall | Out-File -FilePath $PackageFile

    $ChocoList = choco list | ForEach-Object { ($_ -split " ")[0] }

    Get-Content $PackageFile |
        ForEach-Object {

            $Package = $_.Trim()

            if ($Package -eq "") { return }
            if ($Package.StartsWith("#")) { return }

            if ($ChocoList -contains $Package) {
                Gum-StyleFade "$Package already installed. Skipping..."
                return
            }

            Write-Host "Installing $(Gum-Style "$Package")..."

            choco install $Package -y
        }

    Remove-Item $PackageFile
}

function Welcome-User {

    gum style --border-foreground 212 --border double --padding "1 6" "Hello $USER!"
    Write-Host ""

    $Header = "Ready to install $(Gum-Style "dotfiles")?"
    $Choice = $(gum choose "Yes" "No" --header "$HEADER")
    Write-Host

    Write-Host "Doesn't matter... We're going to install $(gum style --italic --foreground 212 anyway!)"
}

function Backup {
    param(
        [string]$Target
    )

    if (-not (Test-Path $Target)) {
        return
    }

    if ((Get-Item $Target).LinkType) {
        return
    }

    $Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

    Gum-StyleFade "Backing up $Target"

    Move-Item $Target "$Target.backup-$Timestamp"
}

function Link {
    param(
        [string]$Source,
        [string]$Destination
    )

    $Source = Join-Path $Repo $Source

    $Parent = Split-Path $Destination

    New-Item `
        -ItemType Directory `
        -Force `
        -Path $Parent | Out-Null

    if (Test-Path $Destination) {

        $Item = Get-Item $Destination

        if ($Item.LinkType) {

            $Current = $Item.Target

            if ($Current -eq $Source) {
                Gum-StyleFade "Already linked $Destination"
                return
            }

            Remove-Item $Destination -Force
        }
        else {
            Backup $Destination
        }
    }

    try {

        New-Item `
            -ItemType SymbolicLink `
            -Path $Destination `
            -Target $Source | Out-Null

        Write-Host "Linked $(Gum-Style "$Destination")"

    }
    catch {

        Write-Host ""
        Write-Host "Failed to create symbolic link."
        Write-Host "Run PowerShell as Administrator or enable Developer Mode."
        throw
    }
}

function Install-Manifest {

    param(
        [string]$Manifest
    )

    Write-Host "Installing $(Gum-Style $Manifest)..."

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

        Link `
            $Source `
            (Join-Path $HOME $Target)
    }
}

function Append-GitInclude {

    $GitConfig = Join-Path $HOME ".gitconfig"

    if (-not (Test-Path $GitConfig)) {
        New-Item -ItemType File $GitConfig | Out-Null
    }

    $Content = Get-Content $GitConfig -Raw

    if ($null -ne $Content) {
        if ($Content.Contains("# >>> dotfiles install >>>")) {
            Gum-StyleFade "Git config already appended."
            return
        }
    }

    Add-Content $GitConfig @"

# >>> dotfiles install >>>
[include]
    path = ~/.config/git/config
# <<< dotfiles install <<<
"@

    Write-Host "$(Gum-Style "Git config") appended."
}

function Install-StarshipFile {

    $StarshipFile = Join-Path $HOME ".config/starship.toml"

    if (Test-Path $StarshipFile) {
        Gum-StyleFade "Starship preset already installed."
        return
    }

    &starship preset pure-preset -o $StarshipFile

    Write-Host "Installed $(Gum-Style "starship pure preset")."
}

function Install-VimPlug {

    $PlugFile = Join-Path $HOME "vimfiles/autoload/plug.vim"

    if (Test-Path $PlugFile) {
        Gum-StyleFade "plug.vim file already installed."
        return
    }

    $PlugDirectory = Split-Path $PlugFile

    New-Item $PlugDirectory -ItemType Directory -Force | Out-Null


    try {

        curl.exe -fLo $PlugFile `
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

        Write-Host "Installed $(Gum-Style "plug.vim file.")"

    } catch {

        Write-Host "Failed to get plug.vim file. Please install manually."

    }
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
# Install
###############################################################################

function Main {

    Install-Chocolatey
    Write-Host ""

    Install-Gum
    Write-Host ""

    Welcome-User
    Write-Host ""

    Install-Packages
    Write-Host ""

    Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
    refreshenv
    Write-Host ""
    . (Join-Path $Repo "config\powershell\path.ps1")

    Install-Manifest "common.manifest"
    Write-Host ""

    Install-Manifest "windows.manifest"
    Write-Host ""

    Append-GitInclude
    Install-StarshipFile
    Install-VimPlug
    Write-Host ""

    Write-Host "We are $(Gum-Style "DONE")!"
    Write-Host ""
}

Main

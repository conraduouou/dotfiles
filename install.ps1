$ErrorActionPreference = "Stop"

###############################################################################
# Paths
###############################################################################

$Repo = Split-Path -Parent $MyInvocation.MyCommand.Path

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

function Install-Packages {

    $PackageFile = Join-Path $Repo "Chocolateyfile"

    Get-Content $PackageFile |
        ForEach-Object {

            $Package = $_.Trim()

            if ($Package -eq "") { return }
            if ($Package.StartsWith("#")) { return }

            Write-Host "Installing $Package..."

            choco install $Package -y
        }
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

    Write-Host "Backing up $Target"

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
                Write-Host "Already linked $Destination"
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

        Write-Host "Linked $Destination"

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

    if ($Content.Contains("# >>> dotfiles install >>>")) {
        Write-Host "Git config already appended."
        return
    }

    Add-Content $GitConfig @"

# >>> dotfiles install >>>
[include]
    path = ~/.config/git/config
# <<< dotfiles install <<<
"@

    Write-Host "Git config appended."
}

function Install-StarshipFile {

    $StarshipFile = Join-Path $HOME ".config/starship.toml"

    if (Test-Path $StarshipFile) {
        Write-Host "Starship preset already installed."
        return
    }

    &starship preset pure-preset -o $StarshipFile

    Write-Host "Installed starship pure preset."
}

function Install-VimPlug {

    $PlugFile = Join-Path $HOME "vimfiles/autoload/plug.vim"

    if (Test-Path $PlugFile) {
        Write-Host "plug.vim file already installed."
        return
    }

    $PlugDirectory = Split-Path $PlugFile

    New-Item $PlugDirectory -ItemType Directory -Force | Out-Null

    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" `
        -OutFile $PlugFile

    Write-Host "Install plug.vim file"
}

###############################################################################
# Install
###############################################################################

function Main {

    Write-Host ""
    Write-Host "Installing Chocolatey..."
    Write-Host ""

    Install-Chocolatey

    Write-Host ""
    Write-Host "Installing packages..."
    Write-Host ""

    Install-Packages

    Write-Host ""
    Write-Host "Installing dotfiles..."
    Write-Host ""

    Install-Manifest "common.manifest"
    Install-Manifest "windows.manifest"

    Append-GitInclude
    Install-StarshipFile
    Install-VimPlug

    Write-Host ""
    Write-Host "Done!"
}

Main

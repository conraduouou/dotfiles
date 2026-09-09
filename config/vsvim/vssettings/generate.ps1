# generate.ps1

$ErrorActionPreference = "Stop"


###############################################################################
# Configuration
###############################################################################

$ScriptRoot = $PSScriptRoot

$InitFile     = Join-Path $ScriptRoot "init.vssettings"
$MappingsFile = Join-Path $ScriptRoot "mappings.xml"

$Marker = "<!-- MAPPINGS GO HERE -->"


###############################################################################
# Validate source files
###############################################################################

if (-not (Test-Path $InitFile)) {
    throw "Init settings file not found: $InitFile"
}

if (-not (Test-Path $MappingsFile)) {
    throw "Mappings file not found: $MappingsFile"
}


###############################################################################
# Read source files
###############################################################################

$InitContent = Get-Content $InitFile -Raw
$MappingsContent = Get-Content $MappingsFile -Raw


###############################################################################
# Extract <Shortcuts> contents
###############################################################################

$MappingsXml = [xml]$MappingsContent

$ShortcutsNode = $MappingsXml.SelectSingleNode("/Shortcuts")

if ($null -eq $ShortcutsNode) {
    throw "mappings.xml does not contain a <Shortcuts> root element."
}

$PersonalMappings = $ShortcutsNode.InnerXml.Trim()


###############################################################################
# Find marker
###############################################################################

if (-not $InitContent.Contains($Marker)) {
    throw "Marker '$Marker' was not found in init.vssettings."
}


###############################################################################
# Insert personal mappings
###############################################################################

$GeneratedContent = $InitContent.Replace(
    $Marker,
    "$Marker`r`n$PersonalMappings"
)


###############################################################################
# Write generated settings
###############################################################################

$OutputFile = Join-Path $ScriptRoot "generated.vssettings"

if (Test-Path $OutputFile) {
    Remove-Item $OutputFile
}

$XmlDocument = [System.Xml.XmlDocument]::new()
$XmlDocument.LoadXml($GeneratedContent)

$XmlSettings = [System.Xml.XmlWriterSettings]::new()
$XmlSettings.Indent = $true
$XmlSettings.IndentChars = "    "
$XmlSettings.NewLineChars = "`r`n"

$XmlWriter = [System.Xml.XmlWriter]::Create(
    $OutputFile,
    $XmlSettings
)

$XmlDocument.Save($XmlWriter)
$XmlWriter.Dispose()

# TODO: Remove once gum resolves this
$env:CLICOLOR_FORCE = 1
Write-Host "Generated $(gum style --foreground 212 "Visual Studio settings") successfully."

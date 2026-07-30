# ~/bin/vf.ps1

# Path to vifm
$vifmExe = (Get-Command vifm.exe).Source

# Run vifm and capture the chosen directory
$dir = & $vifmExe --choose-dir - @args

# If a directory was returned, cd into it
if ($dir) {
    $dir = $dir.Trim() # Clean any extra spaces/newlines
    if (Test-Path $dir) {
        Set-Location $dir
    } else {
        Write-Host "Invalid directory path returned: $dir"
    }
}

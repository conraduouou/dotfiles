# path.ps1

$Env:Path = "$HOME\.local\bin;" + $Env:Path

# TODO: temporary until Chocolatey has vifm v0.14
$Env:Path = "$HOME\Tools\vifm;" + $Env:Path

# TODO: temporary until Chocolatey has gum v2.0.0
$Env:Path = "$HOME\Tools\gum;" + $Env:Path

# for msedge
$Env:Path = "C:\Program Files (x86)\Microsoft\Edge\Application;" + $Env:Path

# for devenv, Visual Studio
$Env:Path = "C:\Program Files\Microsoft Visual Studio\18\Enterprise\Common7\IDE"

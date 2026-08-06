# path.ps1

$Env:Path = "$HOME\.local\bin;" + $Env:Path
$Env:Path = "$HOME\Tools\vifm;" + $Env:Path # temporary until Chocolatey has vifm v0.14
$Env:Path = "C:\Program Files (x86)\Microsoft\Edge\Application;" + $Env:Path # for msedge

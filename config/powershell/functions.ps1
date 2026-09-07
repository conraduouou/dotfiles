# functions.ps1

# Lock the session
function lock {
    rundll32.exe user32.dll,LockWorkStation
}

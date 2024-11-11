param (
    [string]$DriveLetter,      # Drive letter to lock (e.g., "E:")
    [bool]$ForceDismount = $false  # Force dismount option
)

# Function to display usage information
function Show-Usage {
    Write-Host "Usage: .\LockBitLockerDrive.ps1 -DriveLetter '<DriveLetter>' [-ForceDismount <1|0>]"
    Write-Host ""
    Write-Host "Parameters:"
    Write-Host "  -DriveLetter      The letter of the BitLocker encrypted drive to lock (e.g., 'E:')."
    Write-Host "  -ForceDismount   Optional. Set to '1' to force dismount the drive if it is in use."
    Write-Host ""
    Write-Host "Example:"
    Write-Host "  .\LockBitLockerDrive.ps1 -DriveLetter 'E:' -ForceDismount 1"
}

# Validate the drive letter input
if (-not $DriveLetter) {
    Write-Host "Error: Missing required parameter -DriveLetter."
    Show-Usage
    exit 1
}

# Check if the specified drive exists
if (-not (Test-Path $DriveLetter)) {
    Write-Host "Error: The specified drive '$DriveLetter' does not exist."
    Show-Usage
    exit 1
}

# Lock the BitLocker drive with the specified options
try {
    if ($ForceDismount) {
        Lock-BitLocker -MountPoint $DriveLetter -ForceDismount
        Write-Host "The BitLocker drive $DriveLetter has been locked and forced to dismount."
    } else {
        Lock-BitLocker -MountPoint $DriveLetter
        Write-Host "The BitLocker drive $DriveLetter has been locked."
    }
} catch {
    Write-Host "Error: Failed to lock the BitLocker drive. $_"
}


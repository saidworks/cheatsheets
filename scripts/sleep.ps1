# Get the wake-up time from user input
$wakeUpTime = Read-Host "Enter the wake-up time in 24-hour format (e.g. 08:00)"

# Validate time format
try {
    $wakeUpDateTime = Get-Date $wakeUpTime
    # Ensure wake-up time is in the future
    if ($wakeUpDateTime -lt (Get-Date)) {
        $wakeUpDateTime = $wakeUpDateTime.AddHours(12)
        Write-Host "Wake-up time set for tomorrow at $($wakeUpDateTime.ToString('HH:mm'))"
    }
} catch {
    Write-Host "Invalid time format. Please use HH:MM format (24-hour)."
    exit
}

# Register a wake-up task
try {
    $action = New-ScheduledTaskAction -Execute "powershell" -Argument '-WindowStyle Hidden -Command "$shell = New-Object -ComObject WScript.Shell; $shell.SendKeys(\" \")"'
    $trigger = New-ScheduledTaskTrigger -Once -At $wakeUpDateTime
    $settings = New-ScheduledTaskSettingsSet -WakeToRun
    Register-ScheduledTask -TaskName "WakeUpTask" -Action $action -Trigger $trigger -Settings $settings -User "SYSTEM" -ErrorAction Stop
    Write-Host "Wake-up scheduled for $($wakeUpDateTime.ToString('HH:mm'))"

    # Put device to sleep
    Add-Type -AssemblyName System.Windows.Forms
    Write-Host "Putting computer to sleep now..."
    [System.Windows.Forms.Application]::SetSuspendState('Suspend', $false, $false)

    # Task will be auto-deleted when computer wakes up by creating a startup script
    $cleanupScript = @"
    # Wait a bit to ensure system is fully awake
    Start-Sleep -Seconds 30
    # Delete the wake-up task
    Unregister-ScheduledTask -TaskName "WakeUpTask" -Confirm:$false
"@
    $cleanupPath = "$env:TEMP\WakeUpTaskCleanup.ps1"
    $cleanupScript | Out-File -FilePath $cleanupPath

    # Create a one-time startup task to clean up
    $cleanupAction = New-ScheduledTaskAction -Execute "powershell" -Argument "-ExecutionPolicy Bypass -File `"$cleanupPath`""
    $cleanupTrigger = New-ScheduledTaskTrigger -AtLogOn
    Register-ScheduledTask -TaskName "WakeUpTaskCleanup" -Action $cleanupAction -Trigger $cleanupTrigger -User $env:USERNAME
} catch {
    Write-Host "Error: $_"
    exit
}

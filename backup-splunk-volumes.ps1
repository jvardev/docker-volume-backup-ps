# This script make backups for multiple Splunk containers using Docker volumes.
# by deafult backup whole /opt/splunk directory, you can change it to backup only specific directories if needed.
# Configuration
$volumes = @{
    "splunk_lm" = "splunk_splunk_lm-data"
    "splunk_mc" = "splunk_splunk_mc-data"
    "splunk_sh_1" = "splunk_splunk_sh_1-data"
    "splunk_sh_2" = "splunk_splunk_sh_2-data"
    "splunk_idx_1" = "splunk_splunk_idx_1-data"
    "splunk_idx_2" = "splunk_splunk_idx_2-data"    
}
$backupPath = "<path-to-save>\splunk_backups" # Change this to your desired backup path
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Ensure backup path exists
if (!(Test-Path $backupPath)) {
    New-Item -ItemType Directory -Path $backupPath
}

foreach ($container in $volumes.Keys) {
    $volume = $volumes[$container]
    $backupFile = "${volume}_backup_$timestamp.tar.gz"

    $dockerBackupPath = "/" + ($backupPath -replace ":", "") -replace "\\", "/"


    Write-Output "`n>>> Pausing container: $container"
    docker pause $container

    docker run --rm `
        -v "${volume}:/opt/splunk:ro" `
        -v "${dockerBackupPath}:/backup" `
        alpine sh -c "tar czf /backup/${volume}_backup_$timestamp.tar.gz -C /opt/splunk ."        

    Write-Output ">>> Unpausing container: $container"
    docker unpause $container

    Write-Output "Backup complete: $backupPath\$backupFile"
}

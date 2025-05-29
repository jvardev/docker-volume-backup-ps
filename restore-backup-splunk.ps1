# this script restores backups for multiple Splunk containers using Docker volumes.
# by deafult restore whole /opt/splunk directory, you can change it to restore only specific directories if needed.
# Define containers and their corresponding volumes and backup timestamps

$containers = @{
    "splunk_container_1" = "splunk_volume_1" # Replace with actual container names and volumes
    "splunk_container_2" = "splunk_volume_2" # Replace with actual container names and volumes
    "splunk_container_3" = "splunk_volume_3" # Replace with actual container names and volumes
    "splunk_container_4" = "splunk_volume_4" # Replace with actual container names and volumes
    "splunk_container_5" = "splunk_volume_5" # Replace with actual container names and volumes
    "splunk_container_6" = "splunk_volume_6" # Replace with actual container names and volumes
}

# Path to backups
$backupPath = "<path-to-backups>/splunk_backups" # Change this with you backup path

# Iterate over each container and restore its backup
foreach ($container in $containers.Keys) {
    $volume = $containers[$container]
    $timestamp = "YYYYMMDD_HHMMSS"  # Replace with the actual timestamp or modify to match each container
    $dockerBackupPath = "/" + ($backupPath -replace ":", "") -replace "\\", "/"

    # Pause the container to avoid conflicts during restore
    Write-Output "`n>>> Pausing container: $container"
    docker pause $container

    # Run the restore
    Write-Output "Restoring backup for volume: $volume"
    docker run --rm `
        -v $volume:/opt/splunk `
        -v "$dockerBackupPath:/backup" `
        alpine sh -c "tar xzf /backup/${volume}_backup_$timestamp.tar.gz -C /opt/splunk"

    # Unpause the container to resume normal operation
    Write-Output "Unpausing container: $container"
    docker unpause $container

    Write-Output "Restore complete for volume: $volume"
}

Write-Output "`n>>> All backups restored successfully!"

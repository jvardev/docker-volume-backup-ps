# this can bw used to backup any docker volume only replacing containers and volume names

backup-splunk-volumes.ps1:

```
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
...
        -v "${volume}:/opt/splunk:ro" ` # Path to the volume in read-only mode
```
restore-backup-splunk.ps1

```
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
```

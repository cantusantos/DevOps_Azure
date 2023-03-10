
Initialize-Disk -Number 2 -PartitionStyle GPT -confirm:$false
New-Partition -DiskNumber 2 -UseMaximumSize -DriveLetter F
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel DriveF

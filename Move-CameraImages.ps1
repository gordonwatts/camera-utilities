# Move camera images into default final directories
Function Move-CameraImages {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false,
            HelpMessage="Directory to get files from.")]
            [System.IO.DirectoryInfo]$Source
    )

    $pictures_folder = [environment]::getfolderpath("mypictures") 

    $source_folder = [System.IO.DirectoryInfo] "D:\DCIM"
    if ($Source) {
        $source_folder = $Source
    }

    $picture_move_info = Get-ChildItem $source_folder -Recurse -File `
                         | Get-DesiredPicturePath -destination $pictures_folder `
                         | ForEach-Object {
                             if (-not (Test-Path $_.DestinationPath.Directory)) {
                                New-Item -Path $_.DestinationPath.Directory -type directory
                             }
                             Write-Host $_.DestinationPath.FullName
                             Move-Item -Path $_.OriginalPath.FullName -Destination $_.DestinationPath
                         }
    $picture_move_info
}

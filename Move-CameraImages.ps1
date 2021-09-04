# Move camera images into default final directories
Function Move-CameraImages {
    [CmdletBinding()]

    $pictures_folder = [environment]::getfolderpath("mypictures") 

    $picture_move_info = Get-ChildItem d:\DCIM -Recurse -File `
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

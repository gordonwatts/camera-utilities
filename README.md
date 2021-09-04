# camera-utilities
 Some utilities to help with cameras and images

After doing `. setup.ps1` you can use:

* `Move-CameraImages`. Currently tuned only for Nikon file layout! There aren't a lot of options on this command, but it ties everything else together.
* `Get-DesiredPicturePath` returns the `OriginalPath` and `DestinationPath` for each image it is given. The destination path is determined by the date in the images `Date taken` metadata.
* `Get-FileMetaData` returns all (or a specific) bit of file metadata. Not very fast, but works!

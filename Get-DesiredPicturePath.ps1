# Uses picture meta-data to determine the output location
Function Get-DesiredPicturePath {
    [CmdletBinding()]
    param (    
        [Parameter(Mandatory = $false,
            HelpMessage = "Directory where to place items. Defaults to current directory.")]
        [System.IO.DirectoryInfo]$destination,
        [Parameter(Mandatory = $true,
            HelpMessage = "Path to the image file to be placed in the output directory.",
            ValueFromPipeline=$true)]
        [System.IO.FileInfo]$path
    )
    BEGIN { 
#        [ValidateScript({Test-Path $_})]

# Get the output directory set.
        if ($destination) {
            $output_directory = $destination
        } else {
            $output_directory = Get-Location
        }
    }
    PROCESS {
        # Determine the date of the file
        $datetime_str = Get-FileMetaData $path -metaDataName "Date taken"
        $date_str = $datetime_str.Substring(0, $datetime_str.IndexOf(" "))
        $date = [DateTime]$date_str

        # Next determine the destination path
        $destination_path = $output_directory.FullName + "\" + $date.ToString("yyyy-MM-dd") + "\" + $path.Name

        # Finally, write out the pair of data here for downstream to do the work
        # (whatever the work might be).
        $r = [PSCustomObject]@{
            OriginalPath = $path
            DestinationPath = [System.IO.FileInfo]$destination_path
        }
        Write-Output $r
    }        
    END {     
    }
}

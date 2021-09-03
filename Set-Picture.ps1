# Places input images in a data ordered way in an output directory
Function Set-Picture {
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
    }
    PROCESS {
        # Determine the date of the file
        $datetime_str = Get-FileMetaData $path -metaDataName "Date taken"
        $date_str = $datetime_str.Substring(0, $datetime_str.IndexOf(" "))
        $date = [DateTime]$date_str
        Write-Host $date.ToShortDateString()
    }        
    END {     
    }
}

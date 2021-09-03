Function Get-FileMetaData {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true,
            ValueFromPipeline=$true,
            HelpMessage="The path to the file to get meta data from.")]
            [System.IO.FileInfo]$file,
        [Parameter(Mandatory=$false,
            HelpMessage="Name of the metadata to return")]
            [string]$metaDataName
    )
    BEGIN {
        $objShell = New-Object -ComObject Shell.Application
    }
    PROCESS {
        $FileMetaData = @{}
        $objFolder = $objShell.namespace($file.DirectoryName)
        $item = $objFolder.ParseName($file.Name)
        for ($a ; $a -le 400; $a++) {
            $name = $objFolder.GetDetailsOf($file, $a)
            $r = $objFolder.getDetailsOf($item, $a)
            if ($r -and $name) {
                $FileMetaData[$name] =$r.Replace([string][char]8206, '')
            }
        }
        if ($metaDataName) {
            if (-not $FileMetaData.Contains($metaDataName)) {
                Write-Error "Metadata name $metaDataName not found."
            }
            Write-Output $FileMetaData[$metaDataName]
        } else {
            Write-Output $FileMetaData
        }
    }
} #end Get-FileMetaData

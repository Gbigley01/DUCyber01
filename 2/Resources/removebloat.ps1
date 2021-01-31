$csv = Import-Csv -Path .\microsoftbloat.csv
foreach ($line in $csv) {
    Get-AppxPackage -Name $line.appxpkg | Remove-AppxPackage
    Write-Host Windows bloat, $line.name removed!
}

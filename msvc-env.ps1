param ($arch = $(throw 'arch parameter is required'))

$oldenv = Get-ChildItem env:

$vspath = (& 'C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe' -property installationPath).Trim()
& "$vspath\Common7\Tools\Launch-VsDevShell.ps1" -Arch $arch -SkipAutomaticLocation

$newenv = Get-ChildItem env: | Where-Object { $oldenv -NotContains $_ }

Write-Output 'New environment variables:'
foreach ($i in $newenv) {
    Tee-Object -InputObject "$($i.Name)=$($i.Value)" -FilePath $env:GITHUB_ENV -Append
}

param([string]$Destination = (Join-Path $PSScriptRoot '产品文件'))
$ErrorActionPreference = 'Stop'
$rows = Import-Csv -LiteralPath (Join-Path $PSScriptRoot 'download-manifest.csv') -Encoding UTF8
$partDir = Join-Path $Destination '_分片'
New-Item -ItemType Directory -Path $partDir -Force | Out-Null
foreach ($row in $rows) {
    $path = Join-Path $partDir $row.Part
    if ((Test-Path -LiteralPath $path) -and ((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash -eq $row.PartSHA256)) { continue }
    Write-Host ('下载 ' + $row.Part)
    Invoke-WebRequest -Uri $row.URL -OutFile ($path + '.part') -UseBasicParsing
    if ((Get-FileHash -LiteralPath ($path + '.part') -Algorithm SHA256).Hash -ne $row.PartSHA256) { throw ('校验失败: ' + $row.Part) }
    Move-Item -LiteralPath ($path + '.part') -Destination $path -Force
}
foreach ($group in ($rows | Group-Object Archive)) {
    $archivePath = Join-Path $Destination $group.Name
    $stream = [IO.File]::Create($archivePath)
    try {
        foreach ($row in ($group.Group | Sort-Object { [int]$_.Sequence })) {
            $inputStream = [IO.File]::OpenRead((Join-Path $partDir $row.Part))
            try { $inputStream.CopyTo($stream) } finally { $inputStream.Dispose() }
        }
    } finally { $stream.Dispose() }
    if ((Get-FileHash -LiteralPath $archivePath -Algorithm SHA256).Hash -ne $group.Group[0].ArchiveSHA256) { throw ('压缩包校验失败: ' + $group.Name) }
    Write-Host ('合并完成: ' + $group.Name)
}
Write-Host ('文件保存在 ' + $Destination + '，将 ZIP 解压到同一目录即可。')

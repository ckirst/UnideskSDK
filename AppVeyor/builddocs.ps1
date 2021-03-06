Import-Module -Name "$env:APPVEYOR_BUILD_FOLDER\ctxal-sdk" -Force -Verbose
$verbs = (Get-Command -Module ctxal-sdk).Verb | Select-Object -Unique
 
foreach ($verb in $verbs)
{
  $data = @()  
  $data += "$verb Commands"
  $data += '========================='
  $data += ''
  $data += "This page contains details on **$verb** commands."
  $data += ''
  foreach ($help in (Get-Command -Module ctxal-sdk| Where-Object -FilterScript {
        $_.name -like "$verb-*"
  }))
  {
    $data += $help.Name
    $data += '-------------------------'
    $data += ''
    $data += Get-Help -Name $help.name -Detailed
    $data += ''
  }

  $data | Out-File -FilePath "$env:APPVEYOR_BUILD_FOLDER\docs\cmd_$($verb.ToLower()).rst" -Encoding utf8
  Write-Output "   cmd_$($verb.ToLower())"
}
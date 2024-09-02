# Base64.psm1

function ConvertTo-Base64 {
  param (
    [Parameter(Mandatory = $true)]
    [string]$InputString
  )

  try {
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($InputString)
    $base64String = [System.Convert]::ToBase64String($bytes)
    return $base64String
  }
  catch {
    Write-Error "Failed to convert string to Base64: $_"
  }
}

Export-ModuleMember -Function ConvertTo-Base64
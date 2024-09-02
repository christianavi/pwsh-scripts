function Toggle-ClipboardHistory {
  param (
      [Parameter(Mandatory = $false)]
      [ValidateSet("On", "Off")]
      [string]$State
  )

  $clipboardHistoryRegistryPath = "HKCU:\Software\Microsoft\Clipboard"
  
  # Check if the registry key exists
  if (-not (Test-Path $clipboardHistoryRegistryPath)) {
      New-Item -Path $clipboardHistoryRegistryPath -Force
  }

  # Check if the property exists, if not, initialize it
  try {
      $currentState = Get-ItemPropertyValue -Path $clipboardHistoryRegistryPath -Name "EnableClipboardHistory" -ErrorAction Stop
  } catch {
      # Initialize the property if it does not exist
      Set-ItemProperty -Path $clipboardHistoryRegistryPath -Name "EnableClipboardHistory" -Value 0
      $currentState = 0
  }

  if (-not $State) {
      # Toggle state if no parameter is provided
      if ($currentState -eq 1) {
          $State = "Off"
      } else {
          $State = "On"
      }
  }

  # Set the state based on the provided or toggled value
  if ($State -eq "On") {
      Set-ItemProperty -Path $clipboardHistoryRegistryPath -Name "EnableClipboardHistory" -Value 1
      Write-Host "Clipboard History has been turned on."
  } else {
      Set-ItemProperty -Path $clipboardHistoryRegistryPath -Name "EnableClipboardHistory" -Value 0
      Write-Host "Clipboard History has been turned off."
  }
}
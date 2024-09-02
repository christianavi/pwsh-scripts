function Set-TaskbarAlignment {
  param (
      [Parameter(Mandatory = $false)]
      [ValidateSet("Left", "Center")]
      [string]$Alignment
  )

  $taskbarRegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
  $alignmentValue = Get-ItemPropertyValue -Path $taskbarRegistryPath -Name "TaskbarAl"

  if (-not $Alignment) {
      # Toggle alignment if no parameter is provided
      if ($alignmentValue -eq 0) {
          $Alignment = "Center"
      } else {
          $Alignment = "Left"
      }
  }

  # Set the alignment based on the provided or toggled value
  if ($Alignment -eq "Left") {
      Set-ItemProperty -Path $taskbarRegistryPath -Name "TaskbarAl" -Value 0
  } else {
      Set-ItemProperty -Path $taskbarRegistryPath -Name "TaskbarAl" -Value 1
  }

  try {
      Restart-Explorer
  } catch {
      "Restart-Explorer function was not found. Please restart Explorer manually if changes have not taken effect."
  }
}

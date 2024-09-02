function Toggle-TaskView {
  [CmdletBinding()]
  param (
    [switch]$ShowTaskView
  )

  $taskViewRegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
  
  # Check if the property exists
  $propertyExists = Get-ItemProperty -Path $taskViewRegistryPath -Name "ShowTaskViewButton" -ErrorAction SilentlyContinue

  if ($null -eq $propertyExists) {
    # If the property does not exist, assume it is shown (default to 1)
    $showTaskViewButton = 1
  } else {
    $showTaskViewButton = Get-ItemPropertyValue -Path $taskViewRegistryPath -Name "ShowTaskViewButton"
  }

  if ($ShowTaskView -or (!$ShowTaskView -and $showTaskViewButton -eq 0)) {
    Set-ItemProperty -Path $taskViewRegistryPath -Name "ShowTaskViewButton" -Value 1
  }
  else {
    Set-ItemProperty -Path $taskViewRegistryPath -Name "ShowTaskViewButton" -Value 0
  }

  Restart-Explorer
}
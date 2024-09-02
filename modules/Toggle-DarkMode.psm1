function Toggle-DarkMode {
  [CmdletBinding()]
  param (
    [switch]$DarkMode
  )

  $themeRegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
  $appsUseLightTheme = Get-ItemPropertyValue -Path $themeRegistryPath -Name "AppsUseLightTheme" -ErrorAction SilentlyContinue
  $systemUsesLightTheme = Get-ItemPropertyValue -Path $themeRegistryPath -Name "SystemUsesLightTheme" -ErrorAction SilentlyContinue

  if ($DarkMode -or (!$DarkMode -and $appsUseLightTheme -eq 1 -and $systemUsesLightTheme -eq 1)) {
    Set-ItemProperty -Path $themeRegistryPath -Name "AppsUseLightTheme" -Value 0
    Set-ItemProperty -Path $themeRegistryPath -Name "SystemUsesLightTheme" -Value 0
  }
  else {
    Set-ItemProperty -Path $themeRegistryPath -Name "AppsUseLightTheme" -Value 1
    Set-ItemProperty -Path $themeRegistryPath -Name "SystemUsesLightTheme" -Value 1
  }

  # Restart Explorer to apply changes
  Restart-Explorer
}
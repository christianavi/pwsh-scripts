$scripts = @(
  # "Base64",
  "Restart-Explorer",
  "Set-SearchBar",
  "Set-TaskbarAlignment"
  "Set-TaskView",
  "Set-Wallpaper",
  "Toggle-ClipboardHistory",
  "Toggle-DarkMode"
)

foreach ($script in $scripts) {
  try {
    $url = "https://raw.githubusercontent.com/christianavi/pwsh-scripts/master/modules/$script.psm1"
    Invoke-WebRequest -UseBasicParsing $url | Invoke-Expression
    Write-Host "Downloaded and imported $script"
  } catch {
    Write-Host "Error occurred while downloading ${script}: $_"
  }
}
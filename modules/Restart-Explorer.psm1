function Restart-Explorer {
  $explorerProcess = Get-Process -Name explorer -ErrorAction SilentlyContinue

  if ($explorerProcess) {
    $explorerProcess | Stop-Process -Force
    Start-Process explorer.exe
  } else {
    Write-Warning "Explorer process not found."
  }
}
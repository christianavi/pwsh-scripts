function Set-Wallpaper {
  param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Url
  )

  # Download the image from the URL
  $tempPath = Join-Path -Path $env:TEMP -ChildPath "wallpaper.jpg"
  Write-Output "Downloading image from $Url to $tempPath"
  Invoke-WebRequest -Uri $Url -OutFile $tempPath

  if (-Not (Test-Path -Path $tempPath)) {
    throw "Failed to download image."
  }

  Write-Output "Image downloaded successfully."

  # Set the downloaded image as the wallpaper
  $SPI_SETDESKWALLPAPER = 0x0014
  $SPIF_UPDATEINIFILE = 0x01
  $SPIF_SENDCHANGE = 0x02
  $user32 = Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
      [DllImport("user32.dll", CharSet = CharSet.Auto)]
      public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@ -PassThru
  $result = $user32::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $tempPath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)

  if ($result -eq 0) {
    throw "Failed to set wallpaper."
  }

  Write-Output "Wallpaper set successfully."

  # Clean up the temporary image file
  Remove-Item -Path $tempPath -Force
  Write-Output "Temporary image file removed."
}
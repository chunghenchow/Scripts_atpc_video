. $PSScriptRoot\set_window.ps1

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public static class Win32 {
  [DllImport("User32.dll", EntryPoint="SetWindowText")]
  public static extern int SetWindowText(IntPtr hWnd, string strTitle);
}
"@

function ContinueOrExit {
    param (
        $prompt
    )
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Description."
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No","Description."
    $option = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

    $response = $Host.UI.PromptForChoice("Please select", $prompt, $option, 1)
    if ($response -eq 1) {
        exit
    }
}

function WaitTitle {
    param (
        [string]$ProcessName,
		[string]$Title,
        [int]$Count = 0
    )

    # wait for the window to appear 
	$tix = 0
	$found = $null
    while ($true) { 
		$found = Get-Process -Name $ProcessName -ea SilentlyContinue | Where-object MainWindowTitle -like $Title
		if ($found -ne $null) {
			break
		} 
		start-sleep -MilliSeconds 100
		$tix = $tix + 1
		if ($tix -gt $count) {
			break
		}
	}
	$found
}

$xair = WaitTitle -ProcessName "X-AIR*" -Title "X AIR*"
if (!$xair) {
    powershell.exe -Command {
        Start-Process -FilePath "C:\Users\Root\Desktop\X-AIR-Edit.exe"
    }

    start-sleep -Seconds 2
    Select-UIElement -Name "X AIR*" | Send-UIKeys "~"
    start-sleep -Seconds 1
    Select-UIElement -Name "X AIR*" | Send-UIKeys "~"
    # set position at the end
}
else {
    ContinueOrExit $xair + " already started! Continue script? [Y/N]"
}

$atpcpost = WaitTitle -ProcessName "listener" -Title "ATPCPostServer"
if (!$atpcpost) {
    Start-Process -FilePath "C:\Users\Root\Desktop\listener" -WindowStyle Minimized
    # set position at the end
}
else {
    ContinueOrExit $atpcpost + " already started! Continue script? [Y/N]"
}

$meet = WaitTitle -ProcessName "chrome" -Title "Meet*"
if (!$meet) {
    Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList '--profile-directory="Profile 2"',https://meet.google.com/nwx-bxcs-ehb 
}
else {
    ContinueOrExit $meet + " already started! Continue script? [Y/N]"
}

$live = WaitTitle -ProcessName "chrome" -Title "Live*"
if (!$live) {
    Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList '--profile-directory="Profile 1"','https://studio.youtube.com/channel/UC_-UujZCgRNRIWhShAtWYbA/livestreaming'
    # Start-Sleep -Seconds 1
	# WaitTitle -ProcessName "chrome" -Title "Live*" -Count 20 | Set-Window -X 1280 -Y 80 -Width 1280 -Height 720
}
else {
    ContinueOrExit $meet + " already started! Continue script? [Y/N]"
}

$vlc = WaitTitle -ProcessName "vlc" -Title "VLC *"
if (!$vlc) {
    Start-Process -FilePath "C:\Program Files\VideoLAN\VLC\vlc.exe"
	# WaitTitle -ProcessName "vlc" -Title "VLC *" -Count 20 | Set-Window -X 0 -Y 1000
}
else {
    ContinueOrExit $vlc + " already started! Continue script? [Y/N]"
}

$obs = WaitTitle -ProcessName "obs64" -Title "OBS *"
if (!$obs) {
    Start-Process -FilePath "C:\Program Files\obs-studio\bin\64bit\obs64.exe" -WorkingDirectory "C:\Program Files\obs-studio\bin\64bit"
	# WaitTitle -ProcessName "obs64" -Title "OBS *" -Count 20 | Set-Window -X 1600 -Y 1000 -Width 1280 -Height 600
}
else {
    ContinueOrExit $obs + " already started! Continue script? [Y/N]"
}

$vmt = WaitTitle -ProcessName "Voice*" -Title "Voice*"
if (!$vmt) {
    Start-Process -FilePath "C:\Program Files (x86)\VB\Voicemeeter\voicemeeterpro.exe"
}
else {
    ContinueOrExit $vmt + " already started! Continue script? [Y/N]"
}

# WaitTitle -ProcessName "listener" -Title "ATPC*" -Count 100 | Set-Window -X 0 -Y 800 -Width 1280 -Height 300
# start-sleep -Seconds 14
# WaitTitle -ProcessName "X-AIR*" -Title "X AIR*" -Count 200 | Set-Window -X 2300 -Y 1175 -Width 780 -Height 480

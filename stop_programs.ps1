
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

Select-UIElement -Name "Voice*" | Send-UIKeys "%{f4}y"
start-sleep -Seconds 1
Select-UIElement -Name "ATPCPost*" | Send-UIKeys "%{f4}y"
start-sleep -Seconds 1
Select-UIElement -Name "Meet*" | Send-UIKeys "%{f4}"
start-sleep -Seconds 1
Select-UIElement -Name "Live*" | Send-UIKeys "%{f4}"
start-sleep -Seconds 1
Select-UIElement -Name "VLC media player*" | Send-UIKeys "%{f4}"
start-sleep -Seconds 1
Select-UIElement -Name "OBS*" | Send-UIKeys "%{f4}"
start-sleep -Seconds 1
# Select-UIElement -Name "X AIR*" | Send-UIKeys "%{f4}"
get-process "X-AIR*" | stop-process

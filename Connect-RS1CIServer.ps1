# See https://udhyantimilsina.com/2015/01/26/how-to-resolve-your-system-administrator-does-not-allow-the-use-of-saved-credentials-to-log-on-the-remote-computer/
# Needed to avoid the prompt about saved credentials.
if ($env:JENKINS_PASSWORD.length -eq 0) {
	Read-Host -Prompt "Oops. Set JENKINS_PASSWORD in the environment"
	exit -1
}
$nodeID = Read-Host -Prompt 'Server node ID (eg 99 for jenkins-rs1-99)'
$vmName="jenkins-rs1-$nodeID"
$vm = Get-AzureVM $vmName
$ep = Get-AzureEndpoint -vm $vm | Where-Object { $_.Name -eq 'RemoteDesktop' }
cmdkey /generic:$vmName.cloudapp.net /user:jenkins /pass:$env:JENKINS_PASSWORD
$connect="$vmName.cloudapp.net:"+$ep.Port
reg add "HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client" /v "AuthenticationLevelOverride" /t "REG_DWORD" /d 0 /f
mstsc /v:$connect
start-sleep 20
cmdkey /delete:$vmName.cloudapp.net

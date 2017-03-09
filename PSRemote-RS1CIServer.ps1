$nodeID = Read-Host -Prompt 'Server node ID (eg 99 for jenkins-rs1-99)'
$vmName="jenkins-rs1-$nodeID"
$vm = Get-AzureVM $vmName
$ep = Get-AzureEndpoint -vm $vm | Where-Object { $_.Name -eq 'Powershell' }
$dest="`'@{TrustedHosts=`"$($ep.vip)`"}`'"

#http://stackoverflow.com/questions/22233702/how-to-download-the-ssl-certificate-from-a-website-using-powershell
$url="https://$vmName.cloudapp.net:$($ep.Port)"
$webRequest = [Net.WebRequest]::Create($url)
try { $webRequest.GetResponse() } catch {}
$cert = $webRequest.ServicePoint.Certificate
$bytes = $cert.Export([Security.Cryptography.X509Certificates.X509ContentType]::Cert)
set-content -value $bytes -encoding byte -path "$pwd\$vmName.cer"

$secPass=ConvertTo-SecureString $env:JENKINS_PASSWORD -AsPlainText -Force
$cred=New-Object System.Management.Automation.PSCredential("jenkins", $secPass)

#winrm s winrm/config/client $dest
#new-pssession -ComputerName $($ep.vip) -UseSSL -Port $($ep.Port) -Credential $cred


winrm s winrm/config/client '@{TrustedHosts="jenkins-rs1-1.cloudapp.net"}'
Enter-pssession -ComputerName "$vmName.cloudapp.net" -UseSSL -Port $($ep.Port) -Credential $cred







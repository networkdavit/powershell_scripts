# Define the output file for the report
$reportFile = "C:\SimpleSecurityReport.txt"

# Function to write to the report file
function Write-Report {
    param (
        [string]$message
    )
    Add-Content -Path $reportFile -Value $message
}

# Start the report
Write-Report "Simple Security Report"
Write-Report "======================"
Write-Report ""
Write-Report "Date: $(Get-Date)"
Write-Report ""

# Check for Firewall Status
Write-Report "Firewall Status:"
$firewallStatus = Get-NetFirewallProfile | Select-Object -Property Name, Enabled
$firewallStatus | ForEach-Object { Write-Report "$($_.Name): $($_.Enabled)" }
Write-Report ""

# Check for Running Processes
Write-Report "Running Processes:"
$runningProcesses = Get-Process | Select-Object -Property Name, Id
$runningProcesses | ForEach-Object { Write-Report "$($_.Name) - $($_.Id)" }
Write-Report ""

# Check for Open Network Connections
Write-Report "Open Network Connections:"
$openConnections = Get-NetTCPConnection | Where-Object { $_.State -eq "Listen" } | Select-Object -Property LocalAddress, LocalPort
$openConnections | ForEach-Object { Write-Report "$($_.LocalAddress):$($_.LocalPort)" }
Write-Report ""

# Notify the user
Write-Output "Security report generated at $reportFile"

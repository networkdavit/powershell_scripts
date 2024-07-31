# Here you have to put the url of the python file to download, and destination of where to save it
$url = "http://127.0.0.1:8000/downloadedfile.py"
$destination = "C:\Users\user\Desktop\downloadedfile.py"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $destination

# Check if the file was downloaded successfully
if (Test-Path $destination) {
    Write-Output "File downloaded successfully."

    # Run the downloaded file with Python
    & "python" $destination
} else {
    Write-Output "Failed to download the file."
}

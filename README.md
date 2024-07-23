# powershell_scripts

### If you get an error running powershell scripts, it could be due to the fact that there is an execution policy
### try this for a temporary fix
```
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```
### or this for a permanent fix
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

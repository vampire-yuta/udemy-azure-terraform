Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-WebRequest -Uri https://aka.ms/ssmsfullsetup -OutFile ./SSMS-Setup.exe
./SSMS-Setup.exe /install /quiet /log installlog.tx

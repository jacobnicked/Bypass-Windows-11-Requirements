reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig\ /v BypassTPMCheck /t REG_DWORD /d 1 /f

reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig\ /v BypassRAMCheck /t REG_DWORD /d 1 /f

reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig\ /v BypassSecureBootCheck /t REG_DWORD /d 1 /f

reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig\ /v BypassCPUCheck /t REG_DWORD /d 1 /f

reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup\MoSetup\ /v AllowUpgradesWithUnsupportedTPMOrCPU /t REG_DWORD /d 1 /f
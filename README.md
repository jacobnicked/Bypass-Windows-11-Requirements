# Bypass Windows 11 System Requirements

A guide for installing Windows 11 on unsupported hardware, with registry tweaks

## Table of contents

1. [Overview](#overview)
2. [Why bypass the requirements?](#why-bypass-the-requirements)
3. [Requirements](#requirements)
4. [Methods](#methods)
   - [Method 1: Registry tweak (manual)](#method-1-registry-tweak-manual)
   - [Method 2: Automated batch script](#method-2-automated-batch-script)
   - [Method 3: Rufus (USB install)](#method-3-rufus-usb-install)
5. [Post-installation notes](#post-installation-notes)
6. [Disclaimer](#disclaimer)


## Overview

Microsoft's Windows 11 enforces several hardware requirements that prevent installation on older but otherwise capable machines. These include:

| Requirement | Minimum Spec |
|---|---|
| CPU | 8th Gen Intel / Ryzen 2000+ (officially) |
| TPM | TPM 2.0 |
| Secure Boot | Required |
| RAM | 4 GB |
| Storage | 64 GB |
| Display | 720p, 9" or larger |

This tutorial covers how to bypass the **TPM 2.0**, **Secure Boot**, and **CPU compatibility** checks during installation or upgrade.


## Why Bypass the Requirements?

- Your hardware is fully capable of running Windows 11 but fails Microsoft's arbitrary checks.
- You want to test Windows 11 in a virtual machine or lab environment.
- You are preserving or repurposing older enterprise hardware.


## Requirements

Before starting, make sure you have:

- A Windows 10 PC (or a Windows 11 ISO)
- Administrator privileges
- A USB drive (8 GB+) if doing a clean install
- [Rufus](https://rufus.ie) (optional, for USB method)

## Methods

### Method 1: Registry tweak (manual)

This method bypasses the TPM 2.0 and CPU checks during an **in-place upgrade** from Windows 10.

#### Steps

1. Press `Win + R`, type `regedit`, and press **Enter**.

2. Navigate to:
   ```
   HKEY_LOCAL_MACHINE\SYSTEM\Setup\MoSetup
   ```
   > If the `MoSetup` key does not exist, right-click `Setup` → **New** → **Key** and name it `MoSetup`.

3. Inside `MoSetup`, create a new **DWORD (32-bit) Value**:
   - **Name:** `AllowUpgradesWithUnsupportedTPMOrCPU`
   - **Value:** `1`

4. Close the Registry Editor.

5. Run the Windows 11 installer (`setup.exe` from the ISO or Windows Update) — it will now skip the TPM/CPU check.


### Method 2: Automated Batch Script

To save time, a ready-made `.bat` file is available in the companion Git repository that automates the registry changes above.

#### Download

The batch file is available in the repository.

#### What the script does

```bat
@echo off
:: Windows 11 Requirements Bypass Script
:: Adds registry keys to skip TPM 2.0, Secure Boot, and CPU checks

echo Applying Windows 11 bypass registry keys...

reg add "HKLM\SYSTEM\Setup\MoSetup" /v AllowUpgradesWithUnsupportedTPMOrCPU /t REG_DWORD /d 1 /f

reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassTPMCheck /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassSecureBootCheck /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassRAMCheck /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassStorageCheck /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassCPUCheck /t REG_DWORD /d 1 /f

echo Done! You can now run the Windows 11 installer.
pause
```

#### How to run it

1. **Right-click** `bypass_win11_requirements.bat`
2. Select **"Run as administrator"**
3. Wait for the `Done!` message
4. Launch your Windows 11 installer

> **Note:** The `LabConfig` keys are specifically read by the Windows 11 setup process (`setup.exe`) when run from within an existing Windows session. They are ignored during out-of-box-experience (OOBE).


### Method 3: Rufus (USB Install)

For a **clean install** bypassing all checks at the ISO level:

1. Download [Rufus 3.19+](https://rufus.ie).
2. Insert your USB drive and open Rufus.
3. Under **Boot selection**, choose your Windows 11 ISO.
4. Click **Start** — Rufus will prompt:

   ```
   Customize Windows installation
   ☑ Remove requirement for 4GB+ RAM, Secure Boot and TPM 2.0
   ☑ Remove requirement for an online Microsoft account
   ☑ Create a local account with username: [your name]
   ```

5. Check the desired options and proceed.

This embeds the bypass directly into the installation media — no registry editing required.


## Post-installation notes

- **Windows Updates:** Microsoft may still deliver updates to bypassed installs, but this is not guaranteed long-term.
- **Watermark:** Some older builds displayed a watermark on unsupported hardware; recent builds do not.
- **Support:** Microsoft officially does not support Windows 11 on hardware that fails the requirements. Proceed with that understanding.
- **Reverting:** To undo the registry changes, delete the keys added under `HKLM\SYSTEM\Setup\LabConfig` and `MoSetup`.


## Disclaimer

This guide is provided for educational and legitimate personal use (e.g., repurposing older hardware, lab testing). Always ensure you hold a valid Windows license. The author of the batch script and this guide is not responsible for any system instability, data loss, or licensing issues that may result.

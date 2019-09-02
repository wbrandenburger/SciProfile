# [SciProfile](https://github.com/wbrandenburger/SciProfile)

## Table of Contents

- [SciProfile](#sciprofile)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Installation](#installation)
  - [Dependencies](#dependencies)
  - [Settings](#settings)
  - [Available Commands](#available-commands)
  - [Examples](#examples)
  - [Authors/Contributors](#authorscontributors)
    - [Author](#author)

## Description

PowerShell Profile for scientific work with Python and C++.

## Installation

SciProfile is published to the Powershell Gallery and can be installed as follows:

```powershell
Install-Module SciProfile -AllowClobber
```

Because of potentially overriding existing command system:`prompt`, parameter `-AllowClobber` has to be used.

## Dependencies

The following PowerShell module will be automatically installed:

- [PSIni](https://github.com/lipkau/PsIni)

## Settings

SciProfile creates automatically a configuration file in folder `%USERPRFOFILE%\sciprofile`. Additionally, SciProfile search for configuration directories in environment variable `%XDG_CONFIG_HOME%` and `XDG_CONFIG_DIRS`. In configuration file the working directory and user defined folders for scripts can be specified.

```ini
[settings]

; default path where user's sciprofile settings are located
work-dir="A:\.config\SciProfile"

; default path for user's configuration files
config-dir="A:\.config\SciProfile\config"

; default path for user's sciprofile configuration files
project-dir="A:\.config\SciProfile\project"

; default path where user's sciprofile scripts are located
scripts-dir="A:\.config\SciProfile\scripts"

; default path for temporary files
local-dir="A:\.config\SciProfile\.temp"

[sciprofile]
; path where local powershell modules are located
module-dir="A:\Documents\PowerShell\Modules"

```

## Available Commands

| Command                    | Alias | Description                                                     |
|----------------------------|-------|-----------------------------------------------------------------|
| `Get-ProjectLocation`      |       | Returns a list with the location of specified project property. |
| `Get-WebLocation`          |       | Returns a list with the location of specified project property. |
| `Get-ProjectChildItem`     | `lsx` | List all existing projects in predefined directory.             |
| `Set-ProjectLocation`      | `cdx` |                                                                 |
| `Open-ProjectWorkspace`    | `vsx` |                                                                 |
| `Open-ProjectFileExplorer` | `exx` |                                                                 |
| `Open-ProjectBrowser`      | `fox` |                                                                 |
| `New-ConfigurationFile`   |       |                                                                 |

## Examples

## Authors/Contributors

### Author

- [Wolfgang Brandenburger](https://github.com/wbrandenburger)

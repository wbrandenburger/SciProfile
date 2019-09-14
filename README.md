# [SciProfile](https://github.com/wbrandenburger/SciProfile)

## Table of Contents

- [SciProfile](#sciprofile)
  - [Table of Contents](#table-of-contents)
  - [General](#general)
  - [Description](#description)
  - [Installation](#installation)
  - [Dependencies](#dependencies)
  - [Settings](#settings)
  - [Available Commands](#available-commands)
  - [Examples](#examples)
  - [Authors/Contributors](#authorscontributors)
    - [Author](#author)

## General

The module SciProfile is in an experimental status and will be developed to achieve a stable version as fast as possible. The documentation of several functions has to be customized, due to the last changes.

## Description

Extension to local profile of PowerShell, especially for scientific work with literature and writing with LaTeX as well as the development of packages with PowerShell, Python, C#, C++ in Visual Studio Code

## Installation

SciProfile is published to the Powershell Gallery and can be installed as follows:

```powershell
Install-Module SciProfile -AllowClobber
```

Because of overriding powershell's built-in function `prompt`, the additional parameter `-AllowClobber` has to be used.

## Dependencies

The following PowerShell modules will be automatically installed:

- [PSIni](https://github.com/lipkau/PsIni)
- [PSVirtualEnv](https://github.com/wbrandenburger/PSVirtualEnv)

## Settings

SciProfile creates automatically a configuration file in folder `%USERPRFOFILE%\.config\sciprofile`. Moreover, SciProfile searches for configuration directories in environment variable `%XDG_CONFIG_HOME%` and `%XDG_CONFIG_DIRS%`. It is recommended to use a predefined configuration folder  across several projects.

```ini
[settings]

; default path where user's sciprofile settings are located
work-dir = %(XDG_CONFIG_HOME%)s\SciProfile

[sciprofile]

; path where local powershell modules are located
module-dir = A:\Documents\PowerShell\Modules
```

An module specific extension of `PSIni` enables the exploitation of a reference fields `reference-field` inside a section, which can be applied via `%(reference-field)s`. This pattern will be replaced with the value defined in `reference-field`. If the defined reference field exists not in section, system's environment variables will be evaluated and, if any, used for replacing the pattern.

## Available Commands

| Command                  | Alias         | Description                                                                                 |
|--------------------------|---------------|---------------------------------------------------------------------------------------------|

## Examples

## Authors/Contributors

### Author

- [Wolfgang Brandenburger](https://github.com/wbrandenburger)

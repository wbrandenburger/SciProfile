# Change Log

## [0.3.4](https://github.com/wbrandenburger/SCiProfile/tree/0.3.4) (2019-09-16)

- Added function `Test-Administrator`.
- Added profile `Admin` to function `Import-PSMModule` and `Remove-PSMModule`

## [0.3.3](https://github.com/wbrandenburger/SCiProfile/tree/0.3.3) (2019-09-15)

- Added fields `default-editor` and `editor-arguments` in section `user` for opening configuration files in defined editor.
- Added function `Edit-SciProfileConfig`.
- All configuration files can be opened by `Edit-SciProfileConfig` using autocompletion.

## [0.3.2](https://github.com/wbrandenburger/SCiProfile/tree/0.3.2) (2019-09-15)

**Implemented enhancements:**

- Added function `Get-EnvVariable` with alias `ls-env`.
- Added function `Set-EnvVariable` with alias `s-env`.
- Added function `Test-EnvPath` with alias `t-env`.

## [0.3.1](https://github.com/wbrandenburger/SCiProfile/tree/0.3.1) (2019-09-15)

**Implemented enhancements:**

- Added function `Set-ProfileProjectList`.
- Added fields `config-lib` and `virtual-env` in section `pocs` for the creation of project lists for the purpose of autocompletion.
- Referenced fields in configuration files with a reference to another fields can be evaluated.

## [0.3.0](https://github.com/wbrandenburger/SCiProfile/tree/0.3.0) (2019-09-12)

**Implemented enhancements:**

- Added use of module PSVirtualEnv and PSPocs.

**Fixed bugs:**

- Activation of autocompletion.
- Refactoring of core functionality.

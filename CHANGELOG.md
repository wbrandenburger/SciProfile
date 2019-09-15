# Change Log

## [0.3.2](https://github.com/wbrandenburger/SCiProfile/tree/0.3.2) (2019-09-15)

**Implemented enhancements:**

- Added function `Get-EnvironmentVariable` with alias `ls-env`
- Added function `Set-EnvironmentVariable` with alias `s-env`
- Added function `Test-EnvironmentPath` with alias `t-env`

## [0.3.1](https://github.com/wbrandenburger/SCiProfile/tree/0.3.1) (2019-09-15)

**Implemented enhancements:**

- Added function `Set-ProfileProjectList`
- Added fields `config-lib` and `virtual-env` in section `pocs` for the creation of project lists for the purpose of autocompletion
- Referenced fields in configuration files with a reference to another fields can be evaluated

## [0.3.0](https://github.com/wbrandenburger/SCiProfile/tree/0.3.0) (2019-09-12)

**Implemented enhancements:**

- Added use of module PSVirtualEnv and PSPocs

**Fixed bugs:**

- Activation of autocompletion
- Refactoring of core functionality
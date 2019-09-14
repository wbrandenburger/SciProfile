# ===========================================================================
#   ModuleValidation.ps1 ----------------------------------------------------
# ===========================================================================

#   import ------------------------------------------------------------------
# ---------------------------------------------------------------------------
using namespace System.Management.Automation

#   validation ---------------------------------------------------------------
# ----------------------------------------------------------------------------
Class ValidatePapisProject: IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [String[]] (ValidateSciProfileProjectType -Type "Papis")
    }
}

#   validation ---------------------------------------------------------------
# ----------------------------------------------------------------------------
Class ValidatePSModuleProject: IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [String[]] (ValidateSciProfileProjectType -Type "PSModule")
    }
}

#   validation ---------------------------------------------------------------
# ----------------------------------------------------------------------------
Class ValidateProjectAlias: System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [String[]] ((ValidateSciProfileProjectType) + "")
    }
}
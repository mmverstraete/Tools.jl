"""
    misr_version = set_misr_version(misr_prdct)

# Purpose(s):
* Return the default version label of the specified MISR product acronym.

# Positional argument(s):
* `misr_prdct::AbstractString`: The MISR product acronym.

# Keyword argument(s): None.

# Return value(s):
* `misr_version::AbstractString`: The current version label of the specified MISR product acronym.

# Algorithm:
* This function reports the default version label of the specified MISR product acronym.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* The default version labels provided below must be updated when new MISR products are generated or existing products are updated at NASA ASDC.

# Example 1:
```julia
julia> using Tools

julia> misr_version = set_misr_version("L1RTGM")
"F03_0024"
```

# Example 2:
```julia
julia> using Tools

julia> misr_version = set_misr_version("ABcd")
ERROR: set_misr_version: misr_prdct = ABcd not recognized or implemented yet.
```
"""
function set_misr_version(
    misr_prdct::AbstractString
    )::AbstractString

    if misr_prdct == "AGP"
        misr_version = "F01_24"
    elseif misr_prdct == "L1BROW"
        misr_version = "F03_0024"
    elseif misr_prdct == "L1GMP"
        misr_version = "F03_0013"
    elseif misr_prdct == "L1REGM"
        misr_version = "F03_0024"
    elseif misr_prdct == "L1RELM"
        misr_version = "F03_0024"
    elseif misr_prdct == "L1RTGM"
        misr_version = "F03_0024"
    elseif misr_prdct == "L1RTLM"
        misr_version = "F03_0024"
    elseif misr_prdct == "L1RCCM"
        misr_version = "F04_0025"
    elseif misr_prdct == "L2CLAL"
        misr_version = "F05_0011"
    elseif misr_prdct == "L2CLCL"
        misr_version = "F07_0012"
    elseif misr_prdct == "L2CLST"
        misr_version = "F08_0017"
    elseif misr_prdct == "L2CLOU"
        misr_version = "F01_0001"
    elseif misr_prdct == "L2AERO"
        misr_version = "F13_0023"
    elseif misr_prdct == "L2LAND"
        misr_version = "F08_0023"
    else
        error("set_misr_version: misr_prdct = " * string(misr_prdct) *
            " not recognized or implemented yet.")
    end

    return misr_version
end

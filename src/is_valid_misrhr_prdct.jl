"""
    bool, prdct_full_name = is_valid_misrhr_prdct(misrhr_prdct)

# Purpose(s):
* Determine whether the specified `misrhr_prdct` is a valid MISR-HR product acronym.

# Positional argument(s):
* `misrhr_prdct::AbstractString`: The MISR-HR product acronym.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misrhr_prdct` is valid or not.
* `prdct_full_name::AbstractString`: The full name of the MISR-HR product.

# Algorithm:
* This function verifies that the positional argument `misrhr_prdct` is a valid MISRHR product acronym and returns the full product name.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s): None.

# Example 1:
```julia
julia> using Tools

julia> bool, prdct_full_name = is_valid_misrhr_prdct("L1RCCMMVR")
(true, "Radiometric Camera-by-Camera Cloud Mask, Missing Values Replaced")
```

# Example 2:
```julia
julia> using Tools

julia> bool, prdct_full_name = is_valid_misrhr_prdct("TIP")
(true, "Two-stream Inversion Package")
```

# Example 3:
```julia
julia> using Tools

julia> bool, prdct_full_name = is_valid_misrhr_prdct("l1B3")
(false, "")
```
"""
function is_valid_misrhr_prdct(
    misrhr_prdct::AbstractString
    )::Tuple{Bool, AbstractString}

    if misrhr_prdct == "L1RCCMmvr"
        bool = true
        prdct_full_name = "Radiometric Camera-by-Camera Cloud Mask, Missing Values Replaced"

    elseif misrhr_prdct == "L1RTGMmvr"
        bool = true
        prdct_full_name = "Terrain Projected Radiance Global Mode Product, Missing Values Replaced"

    elseif misrhr_prdct == "L1B3"
        bool = true
        prdct_full_name = "Terrain Projected Radiance Global Mode Product at Native Spatial Resolution"

    elseif misrhr_prdct == "BRF"
        bool = true
        prdct_full_name = "Bidirectional Reflectance Factor at Native Resolution"

    elseif misrhr_prdct == "RPV"
        bool = true
        prdct_full_name = "Rahman-Pinty-Verstraete Model Parameters"

    elseif misrhr_prdct == "TIP"
        bool = true
        prdct_full_name = "Two-stream Inversion Package"

    else
        bool = false
        prdct_full_name = ""
    end

    return bool, prdct_full_name

end

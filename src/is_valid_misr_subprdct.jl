"""
    bool, subprdct_name = is_valid_misr_subprdct(misr_prdct, misr_subprdct)

# Purpose(s):
* Determine whether the specified `misr_subprdct` is a valid subproduct of `misr_prdct`, and return the full subproduct name.

# Positional argument(s):
* `misr_prdct::AbstractString`: The MISR product acronym.
* `misr_subprdct::AbstractString`: The MISR subproduct acronym.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_subprdct` acronym is a valid subproduct of `misr_prdct` or not.
* `subprdct_name::AbstractString`: The full name of the MISR subproduct.

# Algorithm:
* This function verifies that the positional argument `misr_subprdct` is a valid MISR subproduct acronym of `misr_prdct` and also returns the full name of this subproduct.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Notes:
* This function currently recognizes only the MISR product and subproduct acronyms defined below; additional acronyms can be added as needed.

# Example 1:
```julia
julia> using Tools

julia> is_valid_misr_subprdct("AGP", "land")
(true, "Land")
```

# Example 2:
```julia
julia> using Tools

julia> is_valid_misr_subprdct("L1RCCM", "cldm")
(true, "Cloud Mask")
```

# Example 3:
```julia
julia> using Tools

julia> is_valid_misr_subprdct("L1RTGM", "brf")
(false, "")
```
"""
function is_valid_misr_subprdct(
    misr_prdct::AbstractString,
    misr_subprdct::AbstractString
    )::Tuple{Bool, AbstractString}

    if misr_prdct == "AGP"
        valid_misr_subprdcts = [
            "shaloc" "Shallow Ocean";
            "land" "Land";
            "coast" "Coastline";
            "shalin" "Shallow Inland Water";
            "ephem" "Ephemeral Water";
            "deepin" "Deep Inland Water";
            "deepoc" "Deep Ocean"]
        sub_acronyms = valid_misr_subprdcts[:, 1]
        if misr_subprdct in sub_acronyms
            idx = findfirst(x -> x == misr_subprdct, sub_acronyms)
            bool = true
            subprdct_name = valid_misr_subprdcts[idx, 2]
        else
            bool = false
            subprdct_name = ""
        end

    elseif misr_prdct == "L1BROW"
        if misr_subprdct == "browse"
            bool = true
            subprdct_name = "Browse"
        else
            bool = false
            subprdct_name = ""
        end

    elseif misr_prdct == "L1GMP"
        if misr_subprdct == "geom"
            bool = true
            subprdct_name = "Geometric Parameter"
        else
            bool = false
            subprdct_name = ""
        end

    elseif (misr_prdct == "L1REGM") | (misr_prdct == "L1RELM") |
        (misr_prdct == "L1RTGM") | (misr_prdct == "L1RTLM")
        valid_misr_subprdcts = [
            "radrd" "Radiance with RDQI";
            "rad" "Radiance";
            "refl" "Reflectance";
            "rdqi" "RDQI";
            "scalf" "Scaling Factor";
            "convf" "Conversion Factor";
            "bhr" "BiHemispherical Reflectance";
            "dhr" "Directional Hemispherical Reflectance";
            "aniso" "Anisotropy"]
        sub_acronyms = valid_misr_subprdcts[:, 1]
        if misr_subprdct in sub_acronyms
            idx = findfirst(x -> x == misr_subprdct, sub_acronyms)
            bool = true
            subprdct_name = valid_misr_subprdcts[idx, 2]
        else
            bool = false
            subprdct_name = ""
        end

    elseif misr_prdct == "L1RCCM"
        valid_misr_subprdcts = [
            "cldm" "Cloud Mask";
            "cldfrac" "Cloud fraction";
            "clrfrac" "Clear Fraction";
            "rccm1" "RCCM1";
            "rccm2" "RCCM2";
            "rccm3" "RCCM3";
            "rccm4" "RCCM4"]
        sub_acronyms = valid_misr_subprdcts[:, 1]
        if misr_subprdct in sub_acronyms
            idx = findfirst(x -> x == misr_subprdct, sub_acronyms)
            bool = true
            subprdct_name = valid_misr_subprdcts[idx, 2]
        else
            bool = false
            subprdct_name = ""
        end

    elseif misr_prdct == "L2TALBEDO"
        error("is_valid_misr_subprdct: Subproducts of L2TALBEDO not implemented yet.")

    elseif misr_prdct == "L2TCLASS"
        error("is_valid_misr_subprdct: Subproducts of L2TCLASS not implemented yet.")

    elseif misr_prdct == "L2TCLOUD"
        error("is_valid_misr_subprdct: Subproducts of L2TCLOUD not implemented yet.")

    elseif misr_prdct == "L2TSTEREO"
        error("is_valid_misr_subprdct: Subproducts of L2TSTEREO not implemented yet.")

    elseif misr_prdct == "L2AERO"
        error("is_valid_misr_subprdct: Subproducts of L2AERO not implemented yet.")

    elseif misr_prdct == "L2LAND"
        valid_misr_subprdcts = [
            "Band_Dim" "MISR band number";
            "Bi-Hemispherical_Reflectance" "Bi-Hemispherical_Reflectance";
            "Bi-Hemispherical_Reflectance_Relative_Uncertainty" "Square root of the BHR variance";
            "Bidirectional_Reflectance_Factor" "Bidirectional_Reflectance_Factor";
            "Biome_Best_Estimate" "Best estimate of biome type";
            "Biome_Type_Dim" "Vegetated biome types";
            "Block_Number" "MISR Block number";
            "Block_Start_X_Index" "Along-track offset of first line on SOM x-axis";
            "Block_Start_Y_Index" "Across-track offset of first sample on SOM y-axis";
            "Camera_Dim" "Camera dimension";
            "Directional_Hemispherical_ Reflectance" "Directional_Hemispherical_ Reflectance";
            "Fractional_Absorbed_Photosynthetically_Active_Radiation_Best_Estimate" "Fractional_Absorbed_Photosynthetically_Active_Radiation_Best_Estimate";
            "Hemispherical_Directional_ Reflectance_Factor" "Hemispherical_Directional_ Reflectance_Factor";
            "Hemispherical_Directional_ Reflectance_Factor_Uncertainty" "Hemispherical_Directional_ Reflectance_Factor_Uncertainty";
            "Latitude" "Geodetic latitude";
            "Leaf_Area_Index_Best_Estimate" "Leaf_Area_Index_Best_Estimate";
            "Leaf_Area_Index_Best_Estimate_ QA" "Leaf_Area_Index_Best_Estimate_ QA";
            "Leaf_Area_Index_QA" "Leaf_Area_Index_QA";
            "Longitude" "Geodetic longitude";
            "Normalized_Difference_Vegetation_ Index" "Normalized_Difference_Vegetation_ Index";
            "Photosynthetically_Active_ Radiation_Integrated_Bi- Hemispherical_Reflectance" "Photosynthetically_Active_ Radiation_Integrated_Bi- Hemispherical_Reflectance";
            "Photosynthetically_Active_ Radiation_Integrated_Directional_ Hemispherical_Reflectance" "Photosynthetically_Active_ Radiation_Integrated_Directional_ Hemispherical_Reflectance";
            "Time" "Nadir view acquisition time";
            "X_Dim" "SOM projection X axis (along-track)";
            "Y_Dim" "SOM projection Y axis (across-track)"]
        sub_acronyms = valid_misr_subprdcts[:, 1]
        if misr_subprdct in sub_acronyms
            idx = findfirst(x -> x == misr_subprdct, sub_acronyms)
            bool = true
            subprdct_name = valid_misr_subprdcts[idx, 2]
        else
            bool = false
            subprdct_name = ""
        end
    else
        bool = false
        subprdct_name = ""
    end

    return bool, subprdct_name

end

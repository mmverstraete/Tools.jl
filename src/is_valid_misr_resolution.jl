"""
    bool, misr_resolution_string = is_valid_misr_resolution(misr_resolution;
        misr_prdct = misr_prdct, misr_camera = misr_camera, misr_band = misr_band)

# Purpose(s):
* Determine whether the given `misr_resolution` is a valid MISR spatial resolution for the specified product.

# Positional argument(s):
* `misr_resolution::Integer`: The spatial resolution of the specified product.

# Keyword argument(s):
* `misr_prdct::Union{AbstractString, Nothing} = nothing`: The MISR product acronym.
* `misr_camera::Union{AbstractString, Nothing} = nothing`: The MISR camera name.
* `misr_band::Union{AbstractString, Nothing} = nothing`: The MISR spectral band name.

# Return value(s):
* `bool::Bool`: Whether `misr_resolution` is valid or not.
* `misr_resolution_string::AbstractString`: The string version of the MISR spatial resolution.

# Algorithm:
* This function checks whether the stated spatial resolution is valid for the indicated product, camera and spectral band.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* MISR spatial resolutions can be tested generically by calling this function with the single positional argument only. However, if the keyword argument `misr_prdct` is specified, then the other keyword arguments that may be needed to assess the spatial resolution must also be provided. See Example 3 below.
* The validity of keyword arguments is verified only if required: unnecessary keywords are ignored.

# Example 1:
```julia
julia> using Tools

julia> bool, misr_resolution_string = is_valid_misr_resolution(1100)
(true, "R1100")
```

# Example 2:
```julia
julia> using Tools

julia> bool, misr_resolution_string = is_valid_misr_resolution(1100; misr_prdct = "L1RCCM")
(true, "R1100")
```

# Example 3:
```julia
julia> using Tools

julia> bool, misr_resolution_string = is_valid_misr_resolution(1100; misr_prdct = "L1RTGM")
(false, "")
```

# Example 4:
```julia
julia> using Tools

julia> bool, misr_resolution_string = is_valid_misr_resolution(1100; misr_prdct = "L1RTGM", misr_camera = "DF", misr_band = "Blue")
(true, "R1100")
```

# Example 5:
```julia
julia> using Tools

julia> bool, misr_resolution_string = is_valid_misr_resolution(1100; misr_prdct = "L1RTGM", misr_camera = "AA", misr_band = "Red")
(false, "")
```

# Example 6:
```julia
julia> using Tools

julia> bool, misr_resolution_string = is_valid_misr_resolution(275; misr_prdct = "L1RTGM", misr_camera = "AA", misr_band = "Red")
(true, "R275")
```
"""
function is_valid_misr_resolution(
    misr_resolution::Integer;
    misr_prdct::Union{AbstractString, Nothing} = nothing,
    misr_camera::Union{AbstractString, Nothing} = nothing,
    misr_band::Union{AbstractString, Nothing} = nothing
    )::Tuple{Bool, AbstractString}

    # Set the list of valid camera names:
    valid_misr_resolutions = [
        275,
        1100,
        2200,
        4400,
        17600]

    if misr_prdct === nothing
        bool = misr_resolution in valid_misr_resolutions
        misr_resolution_string = "R" * string(misr_resolution)

    elseif misr_prdct === "AGP"
        if misr_resolution == 1100
            bool = true
            misr_resolution_string = "R" * string(misr_resolution)
        else
            bool = false
            misr_resolution_string = ""
        end

    elseif misr_prdct === "L1BROW"
        if misr_resolution == 2200
            bool = true
            misr_resolution_string = "R" * string(misr_resolution)
        else
            bool = false
            misr_resolution_string = ""
        end

    elseif misr_prdct === "L1GMP"
        if misr_resolution == 17600
            bool = true
            misr_resolution_string = "R" * string(misr_resolution)
        else
            bool = false
            misr_resolution_string = ""
        end

    elseif (misr_prdct === "L1REGM") | (misr_prdct === "L1RTGM")
        if (misr_camera === nothing) | (misr_band === nothing)
            bool = false
            misr_resolution_string = ""
        else
            bool1 = is_valid_misr_camera(misr_camera)
            bool2 = is_valid_misr_band(misr_band)
            if (bool1 != true) | (bool2 != true)
                bool = false
                misr_resolution_string = ""
            else
                if ((misr_camera === "AN") | (misr_band === "Red")) &
                    (misr_resolution == 275)
                    bool = true
                    misr_resolution_string = "R" * string(misr_resolution)
                elseif (misr_camera !== "AN") & (misr_band !== "Red") &
                    (misr_resolution == 1100)
                    bool = true
                    misr_resolution_string = "R" * string(misr_resolution)
                else
                    bool = false
                    misr_resolution_string = ""
                end
            end
        end

    elseif (misr_prdct === "L1RELM") | (misr_prdct === "L1RTLM")
        if misr_resolution == 275
            bool = true
            misr_resolution_string = "R" * string(misr_resolution)
        else
            bool = false
            misr_resolution_string = ""
        end

    elseif (misr_prdct === "L1RCCM") | (misr_prdct === "L1RCCMMVR")
        if misr_resolution == 1100
            bool = true
            misr_resolution_string = "R" * string(misr_resolution)
        else
            bool = false
            misr_resolution_string = ""
        end

    elseif misr_prdct === "L2AERO"
        if misr_resolution == 4400
            bool = true
            misr_resolution_string = "R" * string(misr_resolution)
        else
            bool = false
            misr_resolution_string = ""
        end

    elseif misr_prdct === "L2LAND"
        if misr_resolution == 1100
            bool = true
            misr_resolution_string = "R" * string(misr_resolution)
        else
            bool = false
            misr_resolution_string = ""
        end

    else
        bool = false
        misr_resolution_string = ""
    end

    return bool, misr_resolution_string

end

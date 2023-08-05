"""
    bool, resolution_string = is_valid_resolution(resolution;
        prdct = prdct, misr_camera = misr_camera, misr_band = misr_band)

# Purpose(s):
* Determine whether the given `resolution` is a valid spatial resolution for the specified MISR or MISRHR product.

# Positional argument(s):
* `resolution::Integer`: The spatial resolution of the optionally specified product.

# Keyword argument(s):
* `prdct::Union{AbstractString, Nothing} = nothing`: The MISR or MISRHR product acronym.
* `misr_camera::Union{AbstractString, Nothing} = nothing`: The MISR camera name.
* `misr_band::Union{AbstractString, Nothing} = nothing`: The MISR spectral band name.

# Return value(s):
* `bool::Bool`: Whether the specified `resolution` is valid or not.
* `resolution_string::AbstractString`: The string version of the MISR or MISRHR spatial resolution.

# Algorithm:
* This function checks whether the stated spatial resolution is valid for the optionally indicated product, camera and spectral band.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* Spatial resolutions can be tested generically by calling this function with the single positional argument only. However, if the keyword argument `prdct` is specified, then the other keyword arguments that may be needed to assess the spatial resolution should also be provided.
* The validity of keyword arguments is verified only if required: unnecessary keywords are ignored.

# Example 1:
```julia
julia> using Tools

julia> bool, resolution_string = is_valid_resolution(275)
(true, "R275")
```

# Example 2:
```julia
julia> using Tools

julia> bool, resolution_string = is_valid_resolution(1100; prdct = "L1RCCM")
(true, "R1100")
```

# Example 3:
```julia
julia> using Tools

julia> bool, resolution_string = is_valid_resolution(1375; prdct = "L1RTGM")
(true, "R1375")
```

# Example 4:
```julia
julia> using Tools

julia> bool, resolution_string = is_valid_resolution(1100; prdct = "L1RTGM", misr_camera = "DF", misr_band = "Blue")
(true, "R1100")
```

# Example 5:
```julia
julia> using Tools

julia> bool, resolution_string = is_valid_resolution(1100; prdct = "L1RTGM", misr_camera = "AA", misr_band = "Red")
(false, "")
```

# Example 6:
```julia
julia> using Tools

julia> bool, resolution_string = is_valid_resolution(275; prdct = "L1RTGM", misr_camera = "AA", misr_band = "Red")
(true, "R275")
```
"""
function is_valid_resolution(
    resolution::Integer;
    prdct::Union{AbstractString, Nothing} = nothing,
    misr_camera::Union{AbstractString, Nothing} = nothing,
    misr_band::Union{AbstractString, Nothing} = nothing
    )::Tuple{Bool, AbstractString}

    # Set the list of valid camera names:
    valid_resolutions = [
        275,
        1100,
        1375,
        2200,
        4400,
        17600]

    # Initialize the output values:
    bool = false
    resolution_string = ""

    if prdct === nothing
        bool = resolution in valid_resolutions
        if bool
            resolution_string = "R" * string(resolution)
        end

    elseif (prdct == "AGP") & (resolution == 1100)
        bool = true
        resolution_string = "R1100"

    elseif (prdct === "L1BROW") & (resolution == 2200)
        bool = true
        resolution_string = "R2200"

    elseif (prdct === "L1GMP") & (resolution == 17600)
        bool = true
        resolution_string = "R17600"

    elseif (prdct == "L1REGM") | (prdct == "L1RTGM") | (prdct == "L1RTGMmvr")
        if (misr_camera === nothing) & (resolution == 1375)
            bool = true
            resolution_string = "R1375"
        elseif (misr_camera == "AN") & (resolution == 275)
            bool = true
            resolution_string = "R275"
        elseif misr_camera != "AN"
            if (misr_band === nothing) & (resolution == 1375)
                bool = true
                resolution_string = "R1375"
            elseif (misr_band == "Red") & (resolution == 275)
                bool = true
                resolution_string = "R275"
            elseif (misr_band != "Red") & (resolution == 1100)
                bool = true
                resolution_string = "R1100"
            end
        end

    elseif ((prdct == "L1RELM") | (prdct == "L1RTLM")) & (resolution == 275)
        bool = true
        resolution_string = "R275"

    elseif ((prdct == "L1RCCM") | (prdct == "L1RCCMmvr")) & (resolution == 1100)
        bool = true
        resolution_string = "R1100"

    elseif (prdct == "L2AERO") & (resolution == 4400)
        bool = true
        resolution_string = "R4400"

    elseif (prdct == "L2LAND") & (resolution == 1100)
        bool = true
        resolution_string = "R1100"

    elseif (prdct == "L1B3") | (prdct == "BRF") |
        (prdct == "RPV") | (prdct == "TIP") & (resolution == 275)
        bool = true
        resolution_string = "R275"
    end

    return bool, resolution_string

end

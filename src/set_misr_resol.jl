"""
    misr_resolution = set_misr_resol(misr_prdct;
        misr_camera = misr_camera, misr_band = misr_band)

# Purpose(s):
Set the default spatial resolution `misr_resol` of the MISR or MISR-HR data product specified by the arguments.

# Positional argument(s):
* `misr_prdct::AbstractString = ""`: The MISR product acronym.

# Keyword argument(s):
* `misr_camera::AbstractString = nothing`: The MISR Camera name.
* `misr_band::AbstractString = nothing`: The MISR spectral Band name.

# Return value(s):
* `misr_resolution::Integer`: The spatial resolution of the product specified by the arguments.

# Algorithm:
This function assigns the default spatial resolution to each MISR or MISR-HR data product recognized by this system.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* This function assigns a value to the output value `misr_resolution` of standard MISR or MISR-HR data products only: It cannot reliably guess the spatial resolution of other downstream products.
* This function assumes that a MISR Aerosol data product provided as input refers to the one delivered at the spatial resolution of 4.4 km. This data product was previously generated at the resolution of 17.6 km. To allow this function to correctly process those earlier files, set the spatial resolution value explicitly rather than relying on this function to set a default value.

# Example 1:
```julia
julia> using Tools

julia> misr_resolution = set_misr_resol("AGP")
1100
```

# Example 2:
```julia
julia> using Tools

julia> misr_resolution = set_misr_resol("L1BROW")
2200
```

# Example 3:
```julia
julia> using Tools

julia> misr_resolution = set_misr_resol("L1RTGM"; misr_camera = "AN")
275
```

# Example 4:
```julia
julia> using Tools

julia> misr_resolution = set_misr_resol("L1RTGM"; misr_camera = "DF", misr_band = "Blue")
1100
```

# Example 5:
```julia
julia> using Tools

julia> misr_resolution = set_misr_resol("L2AERO")
4400
```

# Example 6:
```julia
julia> using Tools

julia> misr_resolution = set_misr_resol("L2LAND")
1100
```

# Example 7:
```julia
julia> using Tools

julia> misr_resolution = set_misr_resol("L1RTGMmvr"; misr_camera = "BA", misr_band = "Green")
1100
```

# Example 8:
```julia
julia> using Tools

julia> misr_resolution = set_misr_resol("L1B3")
275
```
"""
function set_misr_resol(
    misr_prdct::AbstractString;
    misr_camera::Union{AbstractString, Nothing} = nothing,
    misr_band::Union{AbstractString, Nothing} = nothing
    )::Integer

    if misr_prdct == "AGP"
        misr_resolution = 1100
    elseif misr_prdct == "L1BROW"
        misr_resolution = 2200
    elseif misr_prdct == "L1GMP"
        misr_resolution = 17600
    elseif ((misr_prdct == "L1REGM") |
        (misr_prdct == "L1RTGM") |
        (misr_prdct == "L1RTGMmvr"))
        if misr_camera !== nothing
            bool = is_valid_misr_camera(misr_camera)
            if bool == false
                error("set_misr_resol: misr_camera = " * misr_camera * " is invalid.")
            end
            if misr_camera === "AN"
                misr_resolution = 275
            else
                if misr_band !== nothing
                    bool = is_valid_misr_band(misr_band)
                    if bool == false
                        error("set_misr_resol: misr_band = " * misr_band * " is invalid.")
                    end
                    if misr_band === "Red"
                        misr_resolution = 275
                    else
                        misr_resolution = 1100
                    end
                else
                    error("set_misr_resol: misr_band is missing.")
                end
            end
        else
            error("set_misr_resol: misr_camera is missing.")
        end
    elseif ((misr_prdct == "L1RELM") | (misr_prdct == "L1RTLM"))
        misr_resolution = 275
    elseif (misr_prdct == "L1RCCM") | (misr_prdct == "L1RCCMmvr")
        misr_resolution = 1100
    elseif misr_prdct == "L2AERO"
        misr_resolution = 4400
    elseif misr_prdct == "L2LAND"
        misr_resolution = 1100
    elseif ((misr_prdct == "L1B3") |
        (misr_prdct == "BRF") |
        (misr_prdct == "RPV") |
        (misr_prdct == "TIP"))
        misr_resolution = 275
    else
        error("set_misr_resol: Unrecognized misr_prdct.")
    end

    return misr_resolution

end

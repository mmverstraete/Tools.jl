"""
    resolution = set_resolution(prdct;
        misr_camera = misr_camera, misr_band = misr_band)

# Purpose(s):
Set the default spatial `resolution` of the MISR or MISRHR data product specified by the arguments.

# Positional argument(s):
* `prdct::AbstractString = ""`: The MISR or MISRHR product acronym.

# Keyword argument(s):
* `misr_camera::AbstractString = nothing`: The MISR Camera name.
* `misr_band::AbstractString = nothing`: The MISR spectral Band name.

# Return value(s):
* `resolution::Integer`: The spatial resolution of the MISR or MISRHR product specified by the arguments.

# Algorithm:
This function assigns the nominal spatial resolution of the specified MISR or MISRHR data product.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* This function determines the spatial `resolution` of standard MISR or MISRHR data products only: It cannot reliably guess the spatial resolution of other downstream products.
* The MISR products `L1REGM` and `L1RTGM`, as well as the MISRHR product `L1RTGMmvr`, exhibit a spatial resolution that depends on the camera and spectral band. If the latter are known and valid, this function assigns the correct resolution to the specified `prdct`. However, if the information on `misr_camera` and `misr_band` is insufficient to determine the spatial resolution of that data set, it is set to the nominal value of 1375 m, indicating that the 4 bands of the nadir camera and the red band of the 8 off-nadir cameras are available at 275 m, while the other 24 data channels are available at 1100 m.
* If the positional argument `prdct` refers to the MISR Aerosol data product `"L2AERO"`, the spatial resolution is set to 4.4 km. This data product was previously generated at a spatial resolution of 17.6 km. To correctly process those earlier files, set the spatial resolution value explicitly rather than relying on this function to set a default value.

# Example 1:
```julia
julia> using Tools

julia> resolution = set_resolution("AGP")
1100
```

# Example 2:
```julia
julia> using Tools

julia> resolution = set_resolution("L1BROW")
2200
```

# Example 3:
```julia
julia> using Tools

julia> resolution = set_resolution("L1RTGM"; misr_camera = "AN")
275
```

# Example 4:
```julia
julia> using Tools

julia> resolution = set_resolution("L1RTGM"; misr_camera = "DF", misr_band = "Blue")
1100
```

# Example 5:
```julia
julia> using Tools

julia> resolution = set_resolution("L1RTGM")
1375
```

# Example 6:
```julia
julia> using Tools

julia> resolution = set_resolution("L2AERO")
4400
```

# Example 7:
```julia
julia> using Tools

julia> resolution = set_resolution("L2LAND")
1100
```

# Example 8:
```julia
julia> using Tools

julia> resolution = set_resolution("L1RTGMmvr"; misr_camera = "BA", misr_band = "Green")
1100
```

# Example 9:
```julia
julia> using Tools

julia> resolution = set_resolution("L1B3")
275
```
"""
function set_resolution(
    prdct::AbstractString;
    misr_camera::Union{AbstractString, Nothing} = nothing,
    misr_band::Union{AbstractString, Nothing} = nothing
    )::Integer

    if prdct == "AGP"
        resolution = 1100
    elseif prdct == "L1BROW"
        resolution = 2200
    elseif prdct == "L1GMP"
        resolution = 17600
    elseif ((prdct == "L1REGM") | (prdct == "L1RTGM") | (prdct == "L1RTGMmvr"))
        if misr_camera === nothing
            resolution = 1375
        else
            bool = is_valid_misr_camera(misr_camera)
            if bool == false
                error("set_resolution: misr_camera = " * misr_camera * " is invalid.")
            end
            if misr_camera == "AN"
                resolution = 275
            else
                if misr_band === nothing
                    resolution = 1375
                else
                    bool = is_valid_misr_band(misr_band)
                    if bool == false
                        error("set_resolution: misr_band = " * misr_band * " is invalid.")
                    end
                    if misr_band === "Red"
                        resolution = 275
                    else
                        resolution = 1100
                    end
                end
            end
        end
    elseif ((prdct == "L1RELM") | (prdct == "L1RTLM"))
        resolution = 275
    elseif (prdct == "L1RCCM") | (prdct == "L1RCCMmvr")
        resolution = 1100
    elseif prdct == "L2AERO"
        resolution = 4400
    elseif prdct == "L2LAND"
        resolution = 1100
    elseif ((prdct == "L1B3") |
        (prdct == "BRF") |
        (prdct == "RPV") |
        (prdct == "TIP"))
        resolution = 275
    else
        error("set_resolution: Unrecognized prdct.")
    end

    return resolution

end

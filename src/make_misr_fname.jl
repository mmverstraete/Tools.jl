"""
    misr_fname = make_misr_fname(misr_prdct, misr_path;
        misr_orbit = misr_orbit, misr_camera = misr_camera,
        misr_site = misr_site, misr_version = misr_version, ext = ext)

# Purpose(s):
* Return a `Vector` of one or nine name(s) of MISR data file(s) corresponding to the arguments.

# Positional argument(s):
* `misr_prdct::AbstractString`: The MISR product acronym.
* `misr_path::Integer = 0`: The MISR Path number.

# Keyword argument(s):
* `misr_orbit::Union{Integer, Nothing} = nothing`: The MISR Orbit number.
* `misr_camera::Union{AbstractString, Nothing} = nothing`: The MISR Camera name.
* `misr_site::Union{AbstractString, Nothing} = nothing`: The MISR Local Mode site name.
* `misr_version::Union{AbstractString, Nothing} = nothing`: The MISR product version identifier.
* `ext::Union{AbstractString, Nothing} = nothing`: The file extension.

# Return value(s):
* `misr_fname::Vector{AbstractString}`: The name(s) of the one or nine MISR data file(s) corresponding to the arguments.

# Algorithm:
* This function assembles the filename of the MISR data set corresponding to the arguments as follows:
- The positional arguments `misr_prdct` and `misr_path` are used to initialize the output vector `misr_fname`, which is then completed as specified by the keyword arguments as needed.
- If the keyword argument `misr_orbit` is expected but not provided, an error condition is raised.
- If the keyword argument `misr_camera` is expected but not provided, an error condition is raised.
- If the keyword argument `misr_site` is expected but not provided, an error condition is raised.
- If the keyword argument `misr_version` is not provided, a default value is given by the function `set_current_prdct_version.jl`.
- If the keyword argument `ext` is not provided, a default value is set depending on the positional argument `misr_prdct`.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* This function improves on the MISR Toolkit function `MtkMakeFilename.c` (or `jMtkMakeFilename.jl`) because (1) it only requires the arguments actually needed (i.e., it ignores unnecessary inputs), (2) it generates a meaningful error if a necessary input is missing or invalid, and (3) it provides default values to `misr_version` and `ext`.
* This function accepts "*" as a valid `misr_camera` specification, in which case the output value `misr_fname` is a `Vector` of 9 values, one for each camera.
* This function verifies the validity of all arguments except `misr_version`, and does not check the existence or validity of the output value. See Example 2 below.
* This function always returns a `Vector` of either 1 or 9 file name(s).

# Example 1:
```julia
julia> using Tools

julia> misr_fname = make_misr_fname("AGP", 168)
1-element Vector{AbstractString}:
 "MISR_AM1_AGP_P168_F01_24.hdf"
```

# Example 2:
```julia
julia> using Tools

julia> misr_fname = make_misr_fname("AGP", 168; misr_orbit = 12345, misr_camera = "xy",
        misr_site = nothing, misr_version = "")
1-element Vector{AbstractString}:
 "MISR_AM1_AGP_P168_F01_24.hdf"
```

# Example 3:
```julia
julia> using Tools

julia> misr_fname = make_misr_fname("L1GMP", 168; misr_orbit = 68050)
1-element Vector{AbstractString}:
 "MISR_AM1_GP_GMP_P168_O068050_F03_0013.hdf"
```

# Example 4:
```julia
julia> using Tools

julia> misr_fname = make_misr_fname("L1RCCM", 168; misr_orbit = 68050, misr_camera = "CF")
1-element Vector{AbstractString}:
 "MISR_AM1_GRP_RCCM_GM_P168_O068050_CF_F04_0025.hdf"
```

# Example 5:
```julia
julia> using Tools

julia> misr_fname = make_misr_fname("L1RCCM", 168; misr_orbit = 68050)
ERROR: make_misr_fname: MISR Camera is missing.
```

# Example 6:
```julia
julia> using Tools

julia> misr_fname = make_misr_fname("L1RTGM", 168; misr_orbit = 68500, misr_camera = "*")
9-element Vector{AbstractString}:
 "MISR_AM1_GRP_TERRAIN_GM_P168_O068500_DF_F03_0024.hdf"
 "MISR_AM1_GRP_TERRAIN_GM_P168_O068500_CF_F03_0024.hdf"
 "MISR_AM1_GRP_TERRAIN_GM_P168_O068500_BF_F03_0024.hdf"
 "MISR_AM1_GRP_TERRAIN_GM_P168_O068500_AF_F03_0024.hdf"
 "MISR_AM1_GRP_TERRAIN_GM_P168_O068500_AN_F03_0024.hdf"
 "MISR_AM1_GRP_TERRAIN_GM_P168_O068500_AA_F03_0024.hdf"
 "MISR_AM1_GRP_TERRAIN_GM_P168_O068500_BA_F03_0024.hdf"
 "MISR_AM1_GRP_TERRAIN_GM_P168_O068500_CA_F03_0024.hdf"
 "MISR_AM1_GRP_TERRAIN_GM_P168_O068500_DA_F03_0024.hdf"
```

# Example 7:
```julia
julia> using Tools

julia> misr_fname = make_misr_fname("L1GMP", 168; misr_orbit = 680500)
ERROR: make_misr_fname: Invalid MISR Orbit.
```
"""
function make_misr_fname(
    misr_prdct::AbstractString = "",
    misr_path::Integer = 0;
    misr_orbit::Union{Integer, Nothing} = nothing,
    misr_camera::Union{AbstractString, Nothing} = nothing,
    misr_site::Union{AbstractString, Nothing} = nothing,
    misr_version::Union{AbstractString, Nothing} = nothing,
    ext::Union{AbstractString, Nothing} = nothing
    )::Vector{AbstractString}

    # Check the positional argument(s):
    # All MISR files include a product name:
    if (misr_prdct !== nothing) & (misr_prdct != "")
        bool, prdct_name, prdct_ful_name, prdct_esdt = is_valid_misr_prdct(misr_prdct)
        if bool == false
            error("make_misr_fname: Invalid MISR product acronym.")
        end
    else
        error("make_misr_fname: MISR product acronym is missing.")
    end

    # All MISR files include a Path number:
    if misr_path != 0
        bool, misr_path_string = is_valid_misr_path(misr_path)
        if bool == false
            error("make_misr_fname: Invalid MISR Path.")
        end
    else
        error("make_misr_fname: MISR Path is missing.")
    end

    # Check the keyword arguments(s):
    # All MISR files except AGP files require an Orbit number:
    if misr_prdct != "AGP"
        if misr_orbit !== nothing
            bool, misr_orbit_string = is_valid_misr_orbit(misr_orbit)
            if bool == false
                error("make_misr_fname: Invalid MISR Orbit.")
            end
        else
            error("make_misr_fname: MISR Orbit is missing.")
        end
    end

    # Only some L1 files require MISR Camera names:
    if (misr_prdct == "L1BROW") |
        (misr_prdct == "L1REGM") |
        (misr_prdct == "L1RTGM") |
        (misr_prdct == "L1RELM") |
        (misr_prdct == "L1RTLM") |
        (misr_prdct == "L1RCCM")
        if misr_camera !== nothing
            bool = is_valid_misr_camera(misr_camera) | (misr_camera === "*")
            if bool == false
                error("make_misr_fname: Invalid MISR Camera.")
            end
        else
            error("make_misr_fname: MISR Camera is missing.")
        end
    end

    # Only Local Mode files include a Site name:
    if (misr_prdct == "L1RELM") |
        (misr_prdct == "L1RTLM")
        if misr_site !== nothing
            bool, misr_site_label = is_valid_misr_site(misr_site;
                cap = "TXT", sep = "_", sit = true, strict = true)
            if bool == false
                error("make_misr_fname: Invalid MISR Local Site.")
            end
        else
            error("make_misr_fname: MISR Local Site is missing.")
        end
    end

    # All MISR files include a Version identifier:
    if (misr_version === nothing) | (misr_version == "")
        misr_version = set_misr_version(misr_prdct)
    end

    # All MISR files include a file extension:
    if (ext === nothing) | (ext == "")
        if (misr_prdct != "L2AERO") & (misr_prdct != "L2LAND")
            ext = ".hdf"
        else
            ext = ".nc"
        end
    end

    # Get the technical specifications of the MISR instrument:
    misr_specs = set_misr_specs()

    # Set the filename of an AGP file:
    if misr_prdct == "AGP"
        misr_fname = ["MISR_AM1" * "_" *
            prdct_name * "_" *
            misr_path_string * "_" *
            misr_version *
            ext]

    # Set the filename of an L1BROW file:
    elseif misr_prdct == "L1BROW"
        if misr_camera != "*"
            misr_fname = Vector{AbstractString}(undef, 1)
            misr_fname[1] = "MISR_AM1" * "_" *
                prdct_name * "_" *
                misr_path_string * "_" *
                misr_orbit_string * "_" *
                misr_camera * "_" *
                misr_version *
                ext
        else
            misr_fname = Vector{AbstractString}(undef, misr_specs.ncameras)
            for i = 1:misr_specs.ncameras
                misr_fname[i] = "MISR_AM1" * "_" *
                    prdct_name * "_" *
                    misr_path_string * "_" *
                    misr_orbit_string * "_" *
                    misr_specs.camera_names[i] * "_" *
                    misr_version *
                    ext
            end
        end

    # Set the filename of an L1GMP file:
    elseif misr_prdct == "L1GMP"
        misr_fname = ["MISR_AM1" * "_" *
        prdct_name * "_" *
        misr_path_string * "_" *
        misr_orbit_string * "_" *
        misr_version *
        ext]

    # Set the filename of one or more L1REGM or L1RTGM (Global Mode) file(s):
    elseif (misr_prdct == "L1REGM") | (misr_prdct == "L1RTGM")
        if misr_camera != "*"
            misr_fname = Vector{AbstractString}(undef, 1)
            misr_fname[1] = "MISR_AM1" * "_" *
                prdct_name * "_" *
                misr_path_string * "_" *
                misr_orbit_string * "_" *
                misr_camera * "_" *
                misr_version *
                ext
        else
            misr_fname = Vector{AbstractString}(undef, misr_specs.ncameras)
            for i = 1:misr_specs.ncameras
                misr_fname[i] = "MISR_AM1" * "_" *
                    prdct_name * "_" *
                    misr_path_string * "_" *
                    misr_orbit_string * "_" *
                    misr_specs.camera_names[i] * "_" *
                    misr_version *
                    ext
            end
        end

    # Set the filename of one or more L1RELM or L1RTLM (Local Mode) file(s):
    elseif (misr_prdct == "L1RELM") | (misr_prdct == "L1RTLM")
        if misr_camera != "*"
            misr_fname = Vector{AbstractString}(undef, 1)
            misr_fname[1] = "MISR_AM1" * "_" *
                prdct_name * "_" *
                misr_path_string * "_" *
                misr_orbit_string * "_" *
                misr_camera * "_" *
                misr_site_label * "_" *
                misr_version *
                ext
        else
            misr_fname = Vector{AbstractString}(undef, misr_specs.ncameras)
            for i = 1:misr_specs.ncameras
                misr_fname[i] = "MISR_AM1" * "_" *
                    prdct_name * "_" *
                    misr_path_string * "_" *
                    misr_orbit_string * "_" *
                    misr_specs.camera_names[i] * "_" *
                    misr_site_label * "_" *
                    misr_version *
                    ext
            end
        end

    # Set the filename of one or more L1RCCM file(s):
    elseif misr_prdct == "L1RCCM"
        if misr_camera != "*"
            misr_fname = Vector{AbstractString}(undef, 1)
            misr_fname[1] = "MISR_AM1" * "_" *
                prdct_name * "_" *
                misr_path_string * "_" *
                misr_orbit_string * "_" *
                misr_camera * "_" *
                misr_version *
                ext
        else
            misr_fname = Vector{AbstractString}(undef, misr_specs.ncameras)
            for i = 1:misr_specs.ncameras
                misr_fname[i] = "MISR_AM1" * "_" *
                    prdct_name * "_" *
                    misr_path_string * "_" *
                    misr_orbit_string * "_" *
                    misr_specs.camera_names[i] * "_" *
                    misr_version *
                    ext
            end
        end

    # Set the filename of an L2AERO or L2LAND file:
    elseif (misr_prdct == "L2AERO") | (misr_prdct == "L2LAND")
        misr_fname = ["MISR_AM1" * "_" *
            prdct_name * "_" *
            misr_path_string * "_" *
            misr_orbit_string * "_" *
            misr_version *
            ext]

        else
        error("make_misr_fname: misr_prdct = " * misr_prdct * " not implemented yet.")
    end

    return misr_fname

end

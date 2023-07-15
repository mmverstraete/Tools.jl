"""
    misrhr_fname = make_misrhr_fname(ftype, prdct, subprdct;
        qualifier = qualifier, resolution = resolution,
        misr_camera = misr_camera, misr_band = misr_band,
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_block2 = misr_block2,
        misr_site = misr_site, strdate1 = strdate1, strdate2 = strdate2,
        misr_version = misr_version, misrhr_version = misrhr_version, ext = ext)

# Purpose(s):
* Generate and return the name of the MISRHR file corresponding to the metadata specified in the arguments.

# Positional argument(s):
* `ftype::AbstractString`: The file type.
* `prdct::AbstractString`: The main product acronym.
* `subprdct::AbstractString`: The subproduct acronym.

# Keyword argument(s):
* `qualifier::Union{AbstractString, Nothing} = nothing`: The qualifier of the subproduct or of the processing applied.
* `resolution::Union{Integer, Nothing} = 0`: The spatial resolution of the product (in m).
* `misr_camera::Union{AbstractString, Nothing} = nothing`: The MISR Camera name.
* `misr_band::Union{AbstractString, Nothing} = nothing`: The MISR spectral band name.
* `misr_path1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Path number.
* `misr_path2::Union{Integer, Nothing} = nothing`: The last MISR Path number.
* `misr_orbit1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Orbit number.
* `misr_orbit2::Union{Integer, Nothing} = nothing`: The last MISR Orbit number.
* `misr_block1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Block number.
* `misr_block2::Union{Integer, Nothing} = nothing`: The last MISR Block number.
* `misr_site::Union{AbstractString, Nothing} = nothing`: The MISR Local Mode Site name.
* `strdate1::Union{AbstractString, Nothing} = nothing`: The string representation of the starting date of the period of interest, formatted as "yyyy-mm-dd".
* `strdate2::Union{AbstractString, Nothing} = nothing`: The string representation of the ending date of the period of interest, formatted as "yyyy-mm-dd".
* `misr_version::Union{AbstractString, Nothing} = nothing`: The version label for the main MISR data product.
* `misrhr_version::Union{AbstractString, Nothing} = nothing`: The version label for the MISRHR processing system.
* `ext::Union{AbstractString, Nothing} = nothing`: The file extension.

# Return value(s):
* `misrhr_fname::AbstractString`: The name of the MISRHR output file.

# Algorithm:
* This function relies on functions `make_location.jl`, `make_dates.jl` and `make_versions.jl` to provide the values of the filename elements `location`, `dates`, and `versions`, respectively, and generates the filename composed of 8 elements, separated by underscore characters, and formatted as

`ftype_prdct_subprdct_qualifier_resolution_location_dates_versions.ext`

# Reference(s):
* The MISRHR Processing System Manual.
    
# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* The MISRHR processing system assumes that all product filenames contain 8 elements (aside from the file extension) separated by an underscore (`_`), so that character should not be part of any one of the filename elements. For instance, since MISR Local Site names are formatted as `SITE_NAME`, function `make_location.jl` replaces it by a dash (`-`). Similarly, function `make_versions.jl` replaces underscores by dashes in MISR version labels.
* The positional arguments `ftype`, `prdct`, and `subprdct` are mandatory and must take on recognized values (validated by the functions `is_valid_misrhr_ftype`, `is_valid_misr_prdct` or `is_valid_misrhr_prdct`, `is_valid_misr_subprdct` or `is_valid_misrhr_subprdct`).
* The keyword argument `qualifier` can take on any value. However, if set to a null string, its value is reset to `main`.
* The keyword argument `resolution` must be set to a recognized value within the MISRHR processing system. However, if unspecified, its value is derived from the the positional argument `prdct`, and optionally from the keyword arguments `misr_camera` and `misr_band`.
* The keyword arguments `misr_camera` and `misr_band` do not contribute directly to the filename but are required to set the default spatial resolution of the MISR data products `L1REGM` and `L1RTGM`. In those latter cases, if either or both of those keywords are missing, the spatial resolution is set to the value 1375. In all other cases, these keywords can be ignored.
* Commented template to setup this function:
```
ftype =                 [mandatory]
prdct =                 [mandatory]
subprdct =              [mandatory]
qualifier =             [optional, if "" => "main"]
resolution =            [optional, if 0 => defaults to resolution of prdct]
misr_camera =           [optional, if nothing => ignored]
misr_band =             [optional, if nothing => ignored]
misr_path1 =            [mandatory]
misr_path2 =            [optional, if nothing => ignored]
misr_orbit1 =           [mandatory if strdate1 is not provided]
misr_orbit2 =           [optional, if nothing => ignored]
misr_block1 =           [mandatory for some prdct, otherwise ignored]
misr_block2 =           [optional, if nothing => ignored]
misr_site =             [optional, if nothing => ignored]
misr_band =             [optional, if nothing => ignored]
strdate1 =              [optional if misr_orbit1 is specified]
strdate2 =              [optional]
misr_version =          [optional if prdct is specified]
misrhr_version =        [optional, if nothing => defaults to current value]
ext =                   [optional, if nothing => defaults to ext of ftype]
```

# Example 1:
```julia
julia> using Tools

julia> ftype = "Data"
"Data"

julia> prdct = "L1RCCMmvr"
"L1RCCMmvr"

julia> subprdct = "cldm"
"cldm"

julia> misr_path1 = 168
168

julia> misr_orbit1 = 68050
68050

julia> misr_block1 = 110
110

julia> misrhr_fname = make_misrhr_fname(ftype, prdct, subprdct;
        misr_path1 = misr_path1,
        misr_orbit1 = misr_orbit1,
        misr_block1 = misr_block1)
"Data_L1RCCMmvr_cldm_main_R1100_P168+O068050+B110_2012-10-03+2012-10-03+2023-07-13_F04-0025+v3.0.0.nc"
```

# Example 2:
```
julia> using Tools

julia> ftype = "Map"
"Map"

julia> prdct = "L1RTLM"
"L1RTLM"

julia> subprdct = "refl"
"refl"

julia> qualifier = "test"
"test"

julia> misr_path1 = 168
168

julia> misr_orbit1 = 60000
60000

julia> misr_orbit2 = 70000
70000

julia> misr_block1 = 110
110

julia> misr_site = "skukuza"
"skukuza"

julia> misrhr_fname = make_misrhr_fname(ftype, prdct, subprdct;
        qualifier = qualifier, misr_path1 = misr_path1,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_site = misr_site)
"Map_L1RTLM_refl_test_R275_P168+O060000-O070000+B110+SITE-SKUKUZA_2011-03-30+2013-02-14+2023-07-14_F03-0024+v3.0.0.png"
```

# Example 3:
```
julia> using Tools

julia> ftype = "Stats"
"Stats"

julia> prdct = "L1GMP"
"L1GMP"

julia> subprdct = "geom"
"geom"

julia> misrhr_fname = make_misrhr_fname(ftype, prdct, subprdct)
ERROR: make_dates: Missing information for the first date.

julia> misr_orbit1 = 68050
68050

julia> misrhr_fname = make_misrhr_fname(ftype, prdct, subprdct,misr_orbit1 = misr_orbit1)
ERROR: make_location: If a MISR Orbit or Block number is specified, a first Path number must also be specified.

julia> misr_path1 = 168
168

julia> misrhr_fname = make_misrhr_fname(ftype, prdct, subprdct; misr_path1 = 168, misr_orbit1 = misr_orbit1)
"Stats_L1GMP_geom_main_R17600_P168+O068050_2012-10-03+2012-10-03+2023-07-13_F03-0013+v3.0.0"
```
"""
function make_misrhr_fname(
    ftype::AbstractString,
    prdct::AbstractString,
    subprdct::AbstractString;
    qualifier::Union{AbstractString, Nothing} = nothing,
    resolution::Union{Integer, Nothing} = 0,
    misr_camera::Union{AbstractString, Nothing} = nothing,
    misr_band::Union{AbstractString, Nothing} = nothing,
    misr_path1::Union{Integer, Nothing} = nothing,
    misr_path2::Union{Integer, Nothing} = nothing,
    misr_orbit1::Union{Integer, Nothing} = nothing,
    misr_orbit2::Union{Integer, Nothing} = nothing,
    misr_block1::Union{Integer, Nothing} = nothing,
    misr_block2::Union{Integer, Nothing} = nothing,
    misr_site::Union{AbstractString, Nothing} = nothing,
    strdate1::Union{AbstractString, Nothing} = nothing,
    strdate2::Union{AbstractString, Nothing} = nothing,
    misr_version::Union{AbstractString, Nothing} = nothing,
    misrhr_version::Union{AbstractString, Nothing} = nothing,
    ext::Union{AbstractString, Nothing} = nothing
    )::AbstractString

    # Initialize the return value `misrhr_fname` with the file type:
    if ftype !== nothing
        bool = is_valid_misrhr_ftype(ftype)
        if bool == true
            misrhr_fname = ftype
        else
            error("make_misrhr_fname: Positional argument `ftype` is unrecognized.")
        end
    else
        error("make_misrhr_fname: Positional argument `ftype` is required.")
    end

    # Add the MISR or MISR-HR product name:
    if prdct !== nothing
        bool1, prdct_name, prdct_full_name, prdct_esdt = is_valid_misr_prdct(prdct)
        if bool1 == true
            misrhr_fname = misrhr_fname * '_' * prdct
            misr_prdct = prdct
            is_misr_prdct = true
        else
            bool2, prdct_full_name = is_valid_misrhr_prdct(prdct)
            if bool2 == true
                misrhr_fname = misrhr_fname * '_' * prdct
                if prdct == "L1RCCMmvr"
                    misr_prdct = "L1RCCM"
                else 
                    misr_prdct = "L1RTGM"
                end
                is_misr_prdct = false
            else
                error("make_misrhr_fname: Positional argument `prdct` is unrecognized.")
            end
        end
    else
        error("make_misrhr_fname: Positional argument `prdct` is required.")
    end

    # Add the MISR or MISR-HR subproduct name:
    if subprdct !== nothing
        bool1, subprdct_name = is_valid_misr_subprdct(prdct, subprdct)
        if bool1 == true
            misrhr_fname = misrhr_fname * '_' * subprdct
        else
            bool2, subprdct_name = is_valid_misrhr_subprdct(prdct, subprdct)
            if bool2 == true
                misrhr_fname = misrhr_fname * '_' * subprdct
            else
                error("make_misrhr_fname: Positional argument `subprdct` is unrecognized.")
            end
        end
    else
        error("make_misrhr_fname: Positional argument `subprdct` is required.")
    end

    # Add the subproduct qualifier:
    if qualifier !== nothing
        qual = replace(qualifier, "_" => "-")
        misrhr_fname = misrhr_fname * '_' * qual
    else
        misrhr_fname = misrhr_fname * '_' * "main"
    end

    # Add the product spatial resolution:
    if resolution != 0
        if (misr_prdct == "L1REGM") | (misr_prdct == "L1RTGM")
            if (misr_camera !== nothing) & (misr_band !== nothing)
                bool3, misr_resolution_string = is_valid_misr_resolution(misr_resolution; misr_prdct = misr_prdct, misr_camera = misr_camera, misr_band = misr_band)
            else
                misr_resolution_string = 1375
            end
        else
            bool3, misr_resolution_string = is_valid_misr_resolution(misr_resolution; misr_prdct = misr_prdct)
            if bool3 == false
                error("make_misrhr_fname: Positional argument `resolution` is invalid for a MISR product.")
            end
        end
    else
        if (misr_prdct == "L1REGM") | (misr_prdct == "L1RTGM")
            if (misr_camera !== nothing) & (misr_band !== nothing)
                misr_resolution = set_misr_resol(misr_prdct;
                    misr_camera = misr_camera, misr_band = misr_band)
                bool3, misr_resolution_string = is_valid_misr_resolution(misr_resolution; misr_prdct = misr_prdct, misr_camera = misr_camera, misr_band = misr_band)
            else
                misr_resolution_string = 1375
            end
        else
            misr_resolution = set_misr_resol(misr_prdct)
            bool3, misr_resolution_string = is_valid_misr_resolution(misr_resolution)
        end
    end
    misrhr_fname = misrhr_fname * '_' * misr_resolution_string

    # Add the location information:
    location = make_location(;
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_block2 = misr_block2,
        misr_site = misr_site)
    misrhr_fname = misrhr_fname * '_' * location

    # Add the date information:
    if strdate1 === nothing
        strdate1 = ""
    end
    if strdate2 === nothing
        strdate2 = ""
    end
    dates, date1, date2, date3 = make_dates(strdate1, strdate2; misr_orbit1, misr_orbit2)
    misrhr_fname = misrhr_fname * '_' * dates

    # Add the versioning information:
    if misr_version === nothing
        misr_version = ""
    end
    if misrhr_version === nothing
        misrhr_version = ""
    end
    versions = make_versions(misr_version, misrhr_version; misr_prdct = misr_prdct)
    misrhr_fname = misrhr_fname * '_' * versions

    # Add the file extension:
    if ext !== nothing
        misrhr_fname = misrhr_fname * ext
    else
        if ((ftype == "Caption") |
            (ftype == "Log"))
            misrhr_fname = misrhr_fname * ".txt"
        elseif (ftype == "Doc")
            misrhr_fname = misrhr_fname * ".pdf"
        elseif ftype == "Data"
            misrhr_fname = misrhr_fname * ".nc"
        elseif ((ftype == "Contour") |
            (ftype == "Map") |
            (ftype == "Plot") |
            (ftype == "Scatt") |
            (ftype == "Ts"))
            misrhr_fname = misrhr_fname * ".png"
        end
    end

    return misrhr_fname

end

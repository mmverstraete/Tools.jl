"""
    misrhr_fname = make_misrhr_fname(ftype, prdct, subprdct;
        qualifier = qualifier, resolution = resolution,
        misr_camera = misr_camera, misr_band = misr_band,
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_block2 = misr_block2,
        misr_site = misr_site, from = from, until = until,
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
* `from::Union{AbstractString, Nothing} = nothing`: The string representation of the starting date of the period of interest, formatted as "yyyy-mm-dd".
* `until::Union{AbstractString, Nothing} = nothing`: The string representation of the ending date of the period of interest, formatted as "yyyy-mm-dd".
* `misr_version::Union{AbstractString, Nothing} = nothing`: The version label for the main MISR data product.
* `misrhr_version::Union{AbstractString, Nothing} = nothing`: The version label for the MISRHR processing system.
* `ext::Union{AbstractString, Nothing} = nothing`: The file extension.

# Return value(s):
* `misrhr_fname::AbstractString`: The name of the MISRHR output file.

# Algorithm:
* This function relies on functions `make_location.jl`, `make_dates.jl` and `make_versions.jl` to provide the values of the filename elements `location`, `dates`, and `versions`, respectively, and generates the filename composed of 8 elements, separated by underscore characters, plus a file extension, and formatted as

`ftype_prdct_subprdct_qualifier_resolution_location_dates_versions.ext`

# Reference(s):
* The MISRHR Processing System Manual.
    
# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* This function generates and returns a filename but does not actually create or save a file by that name.
* The MISRHR processing system assumes that all product filenames contain 8 elements (aside from the file extension) separated by an underscore (`_`), so that character should not be part of any one of the filename elements. For instance, since MISR Local Site names are formatted as `SITE_NAME`, function `make_location.jl` replaces it by a dash (`-`) in MISRHR filenames. Similarly, function `make_versions.jl` replaces underscores in MISR version labels by dashes in MISRHR filenames. This convention does NOT apply to `misrhr_fpath`.
* The positional arguments `ftype`, `prdct`, and `subprdct` are mandatory and must take on recognized values (validated by the functions `is_valid_misrhr_ftype`, either `is_valid_misr_prdct` or `is_valid_misrhr_prdct`, and either `is_valid_misr_subprdct` or `is_valid_misrhr_subprdct`), respectively.
* The keyword argument `qualifier` can take on any string value. However, if absent or set to a null string, its value is reset to `main`.
* The keyword argument `resolution` must be set to a recognized value within the MISRHR processing system. However, if unspecified, its value is derived from the positional argument `prdct`, and optionally from the keyword arguments `misr_camera` and `misr_band`. See the function `set_resolution.jl` for further details.
* The keyword arguments `misr_camera` and `misr_band` do not contribute directly to the filename but are required to set the default spatial resolution of the MISR data products `L1REGM` and `L1RTGM` or of the MISRHR product `L1RTGMmvr`. In those latter cases, if either or both of those keywords are missing, the spatial resolution is set to the value 1375. In all other cases, these two keywords can be ignored.
* Commented template to setup this function:

```
ftype =             [mandatory]
prdct =             [mandatory]
subprdct =          [mandatory]
qualifier =         [optional, if nothing or "" => "main"]
resolution =        [optional, if nothing or 0 => resolution of prdct]
misr_camera =       [only for `L1REGM`, `L1RTGM` and `L1RTGMmvr`, otherwise ignored]
misr_band =         [only for `L1REGM`, `L1RTGM` and `L1RTGMmvr`, otherwise ignored]
misr_path1 =        [mandatory if `misr_orbit1` or `misr_block1` is specified]
misr_path2 =        [optional, if nothing => ignored]
misr_orbit1 =       [mandatory if `from` is not specified]
misr_orbit2 =       [optional, if nothing or 0 => ignored]
misr_block1 =       [optional, if nothing or 0 => ignored]
misr_block2 =       [optional, if nothing or 0 => ignored]
misr_site =         [optional, if nothing or "" => ignored]
from =              [mandatory if `misr_orbit1` is not specified]
until =             [optional, if nothing or "" => `from`]
misr_version =      [optional, if nothing or "" => version of main `misr_prdct`]
misrhr_version =    [optional, if nothing or "" => version of `misrhr_prdct`]
ext =               [optional, if nothing or "" => extension of `ftype`]
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
        misr_path1 = misr_path1, misr_orbit1 = misr_orbit1, misr_block1 = misr_block1)
"Data_L1RCCMmvr_cldm_main_R1100_P168+O068050+B110_2012-10-03+2012-10-03+2023-08-03_F04-0025+v3.0.0.nc"
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
"Map_L1RTLM_refl_test_R275_P168+O060000-O070000+B110+SITE-SKUKUZA_2011-03-30+2013-02-14+2023-08-03_F03-0024+v3.0.0.png"
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
ERROR: make_dates: Missing information for the `from` date.

julia> misr_orbit1 = 68050
68050

julia> misrhr_fname = make_misrhr_fname(ftype, prdct, subprdct, misr_orbit1 = misr_orbit1)
ERROR: make_location: If a MISR Orbit or Block number is specified, a first Path number must also be specified.

julia> misr_path1 = 168
168

julia> misrhr_fname = make_misrhr_fname(ftype, prdct, subprdct; misr_path1 = 168, misr_orbit1 = misr_orbit1)
"Stats_L1GMP_geom_main_R17600_P168+O068050_2012-10-03+2012-10-03+2023-08-03_F03-0013+v3.0.0"
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
    from::Union{AbstractString, Nothing} = nothing,
    until::Union{AbstractString, Nothing} = nothing,
    misr_version::Union{AbstractString, Nothing} = nothing,
    misrhr_version::Union{AbstractString, Nothing} = nothing,
    ext::Union{AbstractString, Nothing} = nothing
    )::AbstractString

    # Initialize the return value `misrhr_fname` with the file type:
    if (ftype === nothing) | (ftype == "")
        error("make_misrhr_fname: Positional argument `ftype` is required.")
    else
        bool = is_valid_misrhr_ftype(ftype)
        if bool == true
            misrhr_fname = ftype
        else
            error("make_misrhr_fname: Positional argument `ftype` is unrecognized.")
        end
    end

    # Ensure the positional argument `prdct` is valid and add it to `misrhr_fname`, ensuring that it does not contain underscore characters:
    if (prdct === nothing) | (prdct == "")
        error("make_misrhr_fname: Positional argument `prdct` is required.")
    else
        is_misr_p, prdct_name, prdct_full_name, prdct_esdt = is_valid_misr_prdct(prdct)
        is_misrhr_p, prdct_full_name = is_valid_misrhr_prdct(prdct)
        if (is_misr_p == false) & (is_misrhr_p == false)
            error("make_misrhr_fname: Positional argument `prdct` is unrecognized.")
        end
    end
    prod = replace(prdct, "_" => "-")
    misrhr_fname = misrhr_fname * '_' * prod

    # Ensure the positional argument `subprdct` is valid and add it to `misrhr_fname`, ensuring that it does not contain underscore characters:
    if (subprdct === nothing) | (subprdct == "")
        error("make_misrhr_fname: Positional argument `subprdct` is required.")
    else
        is_misr_sp, subprdct_name = is_valid_misr_subprdct(prdct, subprdct)
        is_misrhr_sp, subprdct_name = is_valid_misrhr_subprdct(prdct, subprdct)
        if (is_misr_sp == false) & (is_misrhr_sp == false)
            error("make_misrhr_fname: Positional argument `subprdct` is unrecognized.")
        end
    end
    subp = replace(subprdct, "_" => "-")
    misrhr_fname = misrhr_fname * '_' * subp

    # Ensure the keyword argument `qualifier` is valid and add it to `misrhr_fname`, ensuring that it does not contain underscore characters:
    if (qualifier === nothing) | (qualifier == "")
        misrhr_fname = misrhr_fname * '_' * "main"
    else
        qual = replace(qualifier, "_" => "-")
        misrhr_fname = misrhr_fname * '_' * qual
    end

    # Set the primary MISR product on which the MISRHR product depends:
    if is_misr_p
        misr_prdct = prdct
    else
        if prdct == "L1RCCMmvr"
            misr_prdct = "L1RCCM"
        else 
            misr_prdct = "L1RTGM"
        end
    end

    # Ensure the keyword argument `resolution` is valid and add it to `misrhr_fname`:
    if (resolution === nothing) | (resolution == 0)
        resolution = set_resolution(prdct;
            misr_camera = misr_camera, misr_band = misr_band)
        bool, resolution_string = is_valid_resolution(resolution; prdct = prdct, misr_camera = misr_camera, misr_band = misr_band)
    else
        bool, resolution_string = is_valid_resolution(resolution; prdct = prdct, misr_camera = misr_camera, misr_band = misr_band)
    end
    misrhr_fname = misrhr_fname * '_' * resolution_string

    # Add the location information:
    location = make_location(;
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_block2 = misr_block2,
        misr_site = misr_site)
    misrhr_fname = misrhr_fname * '_' * location

    # Add the date information:
    from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates(from, until; misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2)
    misrhr_fname = misrhr_fname * '_' * dates_str

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
        if (ftype == "Caption") |
            (ftype == "Log") |
            (ftype == "Stats")
            misrhr_fname = misrhr_fname * ".txt"
        elseif (ftype == "Doc")
            misrhr_fname = misrhr_fname * ".pdf"
        elseif (ftype == "Data") |
            (ftype == "Save")
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

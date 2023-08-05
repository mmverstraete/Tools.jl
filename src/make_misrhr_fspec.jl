"""
    misrhr_fspec = make_misrhr_fspec(ftype, prdct, subprdct;
        user = user, project = project,
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_block2 = misr_block2,
        misr_site = misr_site, call_f = call_f, out_folder = out_folder,
        qualifier = qualifier, resolution = resolution,
        misr_camera = misr_camera, misr_band = misr_band,
        from = from, until = until,
        misr_version = misr_version, misrhr_version = misrhr_version, ext = ext)

# Purpose(s):
Return the specification (path and name) of the output file corresponding to the specified arguments.

# Positional argument(s):
* `ftype::AbstractString`: The file type.
* `prdct::AbstractString`: The main product acronym.
* `subprdct::AbstractString`: The subproduct acronym.

# Keyword argument(s):
* `user::Union{AbstractString, Nothing} = "Dev"`: The user name.
* `project::Union{AbstractString, Nothing} = "Test"`: The project name.
* `misr_path1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Path number.
* `misr_path2::Union{Integer, Nothing} = nothing`: The last MISR Path number.
* `misr_orbit1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Orbit number.
* `misr_orbit2::Union{Integer, Nothing} = nothing`: The last MISR Orbit number.
* `misr_block1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Block number.
* `misr_block2::Union{Integer, Nothing} = nothing`: The last MISR Block number.
* `misr_site::Union{AbstractString, Nothing} = nothing`: The MISR Local Mode Site name.
* `call_f::Union{AbstractString, Nothing} = nothing`: The name of the highest-level function requesting the use or creation of this directory; default value: "make_misrhr_fpath".
* `out_folder::Union{AbstractString, Nothing} = nothing`: The user-imposed output folder.
* `qualifier::Union{AbstractString, Nothing} = nothing`: The qualifier of the subproduct or of the processing applied.
* `resolution::Union{Integer, Nothing} = 0`: The spatial resolution of the product (in m).
* `misr_camera::Union{AbstractString, Nothing} = nothing`: The MISR Camera name.
* `misr_band::Union{AbstractString, Nothing} = nothing`: The MISR spectral band name.
* `from::Union{AbstractString, Nothing} = nothing`: The string representation of the starting date of the period of interest, formatted as "yyyy-mm-dd".
* `until::Union{AbstractString, Nothing} = nothing`: The string representation of the ending date of the period of interest, formatted as "yyyy-mm-dd".
* `misr_version::Union{AbstractString, Nothing} = nothing`: The version label for the main MISR data product.
* `misrhr_version::Union{AbstractString, Nothing} = nothing`: The version label for the MISRHR processing system.
* `ext::Union{AbstractString, Nothing} = nothing`: The file extension.

# Return value(s):
* `misrhr_fspec::AbstractString`: The specification of the MISRHR output file.

# Algorithm:
This function relies on function `make_misrhr_fpath.jl` to set the directory to contain the output file, if it is not specified in the keyword argument `out_folder`, and on function `make_misrhr_fname.jl` to set the name of the file matching the arguments.

# Reference(s):
* The MISR-HR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* This function assumes that MISRHR file(s) are organized as described in the MISRHR Processing System User Manual.
* This function verifies the validity of all arguments except `misr_version` and `misrhr_version`.
* This function does not verify that the path name `misrhr_fpath` component of the output value `misrhr_fspec` exists, nor does it create (or overwrite) it.
* This function does not verify that the file name `misrhr_fname` component of the output value `misrhr_fspec` exists, nor does it create (or overwrite) it.
* Function `set_mroots.jl` should be called prior to this function to temporarily define the `"MROOT_SCRAP"` and/or the `"MROOT_MISRHR"` root directories. To make those definitions permanent, add them to the configuration file `.zshenv` (or equivalent).
* Commented template to setup this function:

```
ftype =             [mandatory]
prdct =             [mandatory]
subprdct =          [mandatory]
user =              [optional, if nothing or "" => "Dev"]
project =           [optional, if nothing or "" => "Test"]
misr_path1 =        [mandatory if `misr_orbit1` or `misr_block1` is specified]
misr_path2 =        [optional, if nothing => ignored]
misr_orbit1 =       [mandatory if `from` is not specified]
misr_orbit2 =       [optional, if nothing or 0 => ignored]
misr_block1 =       [optional, if nothing or 0 => ignored]
misr_block2 =       [optional, if nothing or 0 => ignored]
misr_site =         [optional, if nothing or "" => ignored]
call_f =            [optional, if nothing or "" => "make_misrhr_fpath"]
out_folder =        [optional, supersedes default value]
qualifier =         [optional, if nothing or "" => "main"]
resolution =        [optional, if nothing or 0 => resolution of prdct]
misr_camera =       [only for `L1REGM`, `L1RTGM` and `L1RTGMmvr`, otherwise ignored]
misr_band =         [only for `L1REGM`, `L1RTGM` and `L1RTGMmvr`, otherwise ignored]
from =              [mandatory if `misr_orbit1` is not specified]
until =             [optional, if nothing or "" => `from`]
misr_version =      [optional, if nothing or "" => version of main `misr_prdct`]
misrhr_version =    [optional, if nothing or "" => version of `misrhr_prdct`]
ext =               [optional, if nothing or "" => extension of `ftype`]
```

# Example 1:
```julia
julia> using Tools

julia> set_mroots("Unset");

julia> ftype = "Map"
"Map"

julia> prdct = "L1RTGM"
"L1RTGM"

julia> subprdct = "radrd"
"radrd"

julia> user = "MMV"
"MMV"

julia> project = "Explore"
"Explore"

julia> misr_path1 = 168
168

julia> misr_path2 = 170
170

julia> misr_orbit1 = 68000
68000

julia> misr_orbit2 = 70000
70000

julia> misr_block1 = 100
100

julia> misr_block2 = 110
110

julia> call_f = "make_misrhr_fspec"
"make_misrhr_fspec"

julia> misrhr_fspec = make_misrhr_fspec(ftype, prdct, subprdct;
        user = user, project = project,
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_block2 = misr_block2,
        call_f = call_f)
"~/MMV/Explore/P168-P170+O068000-O070000+B100-B110/make_misrhr_fspec/L1RTGM/Map/Map_L1RTGM_radrd_main_R1375_P168-P170+O068000-O070000+B100-B110_2012-09-29+2013-02-14+2023-08-03_F03-0024+v3.0.0.png"
```

# Example 2:
```julia
julia> using Tools

julia> set_mroots("Reset");

julia> ftype = "Map"
"Map"

julia> prdct = "L2LAND"
"L2LAND"

julia> subprdct = "Bidirectional_Reflectance_Factor"
"Bidirectional_Reflectance_Factor"

julia> user = "MMV"
"MMV"

julia> project = "Explore"
"Explore"

julia> misr_path1 = 192
192

julia> misr_path2 = 194
194

julia> misr_orbit1 = 80000
80000

julia> misr_orbit2 = 82000
82000

julia> misr_block1 = 56
56

julia> misr_block2 = 58
58

julia> make_misrhr_fspec(ftype, prdct, subprdct;
        user = user, project = project,
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_block2 = misr_block2)
"/Users/michel/Projects/MISR/Scrap/MMV/Explore/P192-P194+O080000-O082000+B056-B058/make_misrhr_fpath/L2LAND/Map/Map_L2LAND_Bidirectional_Reflectance_Factor_main_R1100_P192-P194+O080000-O082000+B056-B058_2015-01-01+2015-05-19+2023-08-03_F08-0023+v3.0.0.png"
```

# Example 3:
```julia
julia> using Tools

julia> set_mroots("Reset");

julia> ftype = "Stats"
"Stats"

julia> prdct = "RPV"
"RPV"

julia> subprdct = "rho"
"rho"

julia> user = "Joe"
"Joe"

julia> project = "Demo"
"Demo"

julia> misr_path1 = 168
168

julia> misr_orbit1 = 68050
68050

julia> misr_block1 = 110
110

julia> out_folder = "my_dir"
"my_dir"

julia> misrhr_fspec = make_misrhr_fspec(ftype, prdct, subprdct;
        user = user, project = project,
        misr_path1 = misr_path1, misr_orbit1 = misr_orbit1,
        misr_block1 = misr_block1, out_folder = out_folder)
"my_dir/Stats_RPV_rho_main_R275_P168+O068050+B110_2012-10-03+2012-10-03+2023-08-03_F03-0024+v3.0.0.txt"
```
"""
function make_misrhr_fspec(
    ftype::AbstractString,
    prdct::AbstractString,
    subprdct::AbstractString;
    user::Union{AbstractString, Nothing} = nothing,
    project::Union{AbstractString, Nothing} = nothing,
    misr_path1::Union{Integer, Nothing} = nothing,
    misr_path2::Union{Integer, Nothing} = nothing,
    misr_orbit1::Union{Integer, Nothing} = nothing,
    misr_orbit2::Union{Integer, Nothing} = nothing,
    misr_block1::Union{Integer, Nothing} = nothing,
    misr_block2::Union{Integer, Nothing} = nothing,
    misr_site::Union{AbstractString, Nothing} = nothing,
    call_f::Union{AbstractString, Nothing} = nothing,
    out_folder::Union{AbstractString, Nothing} = nothing,
    qualifier::Union{AbstractString, Nothing} = nothing,
    resolution::Union{Integer, Nothing} = nothing,
    misr_camera::Union{AbstractString, Nothing} = nothing,
    misr_band::Union{AbstractString, Nothing} = nothing,
    from::Union{AbstractString, Nothing} = nothing,
    until::Union{AbstractString, Nothing} = nothing,
    misr_version::Union{AbstractString, Nothing} = nothing,
    misrhr_version::Union{AbstractString, Nothing} = nothing,
    ext::Union{AbstractString, Nothing} = nothing
    )::AbstractString

    # Define the path separator appropriate for the underlying operating system:
    path_sep = Base.Filesystem.path_separator

    # Set the output path:
    if (out_folder === nothing) | (out_folder === "")
        misrhr_fpath = make_misrhr_fpath(; user = user, project = project,
            misr_path1 = misr_path1, misr_path2 = misr_path2,
            misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
            misr_block1 = misr_block1, misr_block2 = misr_block2,
            misr_site = misr_site, call_f = call_f, prdct = prdct, ftype = ftype)
    else
        misrhr_fpath = out_folder
        if string(misrhr_fpath[lastindex(misrhr_fpath)]) != path_sep
            misrhr_fpath = misrhr_fpath * path_sep
        end    
    end

    # Set the filename:
    misrhr_fname = make_misrhr_fname(ftype, prdct, subprdct;
        qualifier = qualifier, resolution = resolution,
        misr_camera = misr_camera, misr_band = misr_band,
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_block2 = misr_block2,
        misr_site = misr_site, from = from, until = until,
        misr_version = misr_version, misrhr_version = misrhr_version, ext = ext)

    # Assemble the file specification:
    misrhr_fspec = misrhr_fpath * misrhr_fname

    return misrhr_fspec

end

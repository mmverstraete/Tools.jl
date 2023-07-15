"""
    misr_fpath = make_misr_fpath(misr_prdct, misr_path)

# Purpose(s):
* Generate the full name `misr_fpath` of the directory containing the MISR data file(s) for the `misr_prdct` acronym along MISR Path number `misr_path`.

# Positional argument(s):
* `misr_prdct::AbstractString`: The MISR product acronym.
* `misr_path::Integer`: The MISR Path number.

# Keyword argument(s): None.

# Return value(s):
* `misr_fpath::AbstractString`: The full name of the directory containing MISR data file(s) for the specified product acronym and Path number.

# Algorithm:
* This function generates the full path name of the directory containing the MISR products `misr_prdct` for Path `misr_path` by concatenating the MISR root directory specified in environment variable `MROOT_MISR` (as set by function `set_mroots.jl`) and the appropriate relative directory.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* This function assumes that MISR data file(s) are organized as described in the MISR-HR Processing System User Manual.
* This function does not verify that the output path name `misr_fpath` exists.
* Function `set_mroots.jl` should be called prior to this function to temporarily define the MISR root directory. To make those definitions permanent, add them to the configuration file `.zshenv` (or equivalent).
* The directory name suggested by this function can be overridden by specifying an alternate value in function `make_misr_fspec.jl`.

# Example 1:
```julia
julia> using Tools

julia> set_mroots("Unset");

julia> misr_fpath = make_misr_fpath("L1RTGM", 168)
"~/P168/L1RTGM/"
```

# Example 2:
```
julia> using Tools

julia> set_mroots("Reset");

julia> misr_fpath = make_misr_fpath("L1RTGM", 168)
"/Volumes/MISR_Data0/P168/L1RTGM/"
```
"""
function make_misr_fpath(
    misr_prdct::AbstractString,
    misr_path::Integer
    )::AbstractString

    # Check the validity of the positional arguments and set the string version of the MISR Path number:
    bool, prdct_name, prdct_ful_name, prdct_esdt = is_valid_misr_prdct(misr_prdct)
    if bool == false
        error("make_misr_fpath: Invalid MISR product acronym.")
    end
    bool, misr_path_string = is_valid_misr_path(misr_path)
    if bool == false
        error("make_misr_fpath: Invalid MISR Path number.")
    end

    # Initialize the output value `misr_fpath` with the MISR root path (if it is defined) or with the user's home directory (otherwise):
    if misr_prdct == "AGP"
        if "MROOT_AGP" in keys(ENV)
            misr_fpath = ENV["MROOT_AGP"]
        elseif "MROOT_MISR" in keys(ENV)
            misr_fpath = ENV["MROOT_MISR"]
        else
            misr_fpath = "~" * '/'
        end
    else
        if "MROOT_MISR" in keys(ENV)
            misr_fpath = ENV["MROOT_MISR"]
        else
            misr_fpath = "~" * '/'
        end
    end

    if misr_fpath[lastindex(misr_fpath)] != '/'
        misr_fpath = misr_fpath * '/'
    end

    # Add the name of the folder containing the data file(s) for the specified MISR product acronym and Path:
    misr_fpath = misr_fpath * misr_path_string * '/' * misr_prdct * '/'

    return misr_fpath

end

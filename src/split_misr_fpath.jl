"""
    mroot_misr, misr_path, misr_prdct = split_misr_fpath(misr_fpath)

# Purpose(s):
* Split the filesystem path name `misr_fpath` of a directory containing MISR data file(s) and return the MISR root directory, the MISR Path number and the MISR product acronym.

# Positional argument(s):
* `misr_fpath::AbstractString`: The filesystem path name of a directory containing MISR data file(s).

# Keyword argument(s): None.

# Return value(s):
* `mroot_misr::AbstractString`: The root directory for MISR data files.
* `misr_path::Integer`: The MISR Path number.
* `misr_prdct::AbstractString`: The MISR product acronym.

# Algorithm:
* This function splits the absolute filesystem path name of a directory containing MISR data files and returns the MISR root directory `mroot_misr`, the MISR Path number, and the MISR product acronym.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* The filesystem path is a string containing the name of a directory; the MISR Path is a number indicating the geographical region being acquired by the instrument on a particular Orbit.
* This function assumes that MISR data file(s) are organized as described in the MISR-HR Processing System User Manual.
* This function does not verify that the input argument `misr_fpath` exists, or that the output values are valid, although an error condition may be raised if the syntax of `misr_fpath` cannot be interpreted.

# Example 1:
```julia
julia> using Tools

julia> misr_fpath = "/Volumes/MISR_Data0/P168/L1RTGM"
"/Volumes/MISR_Data0/P168/L1RTGM"

julia> mroot_misr, misr_path, misr_prdct = split_misr_fpath(misr_fpath)
("/Volumes/MISR_Data0/", 168, "L1RTGM")
```

# Example 2:
```julia
julia> using Tools

julia> misr_fpath = "P168/L1RCCM/"
"P168/L1RCCM/"

julia> mroot_misr, misr_path, misr_prdct = split_misr_fpath(misr_fpath)
("", 168, "L1RCCM")
```

# Example 3:
```julia
julia> using Tools

julia> misr_fpath = "invalid_misr_fpath"
"invalid_misr_fpath"

julia> mroot_misr, misr_path, misr_prdct = split_misr_fpath(misr_fpath)
ERROR: split_misr_fpath: The positional argument misr_fpath is not a properly formatted directory path for MISR data files: MISR Path missing.
```
"""
function split_misr_fpath(
    misr_fpath::AbstractString
    )::Tuple{AbstractString, Integer, AbstractString}

    # Initialize the output values to null values:
    mroot_misr = ""
    misr_path = 0
    misr_prdct = ""

    # Look for the pattern `"Pxxx"` where `xxx` is a MISR Path number as the start of the filesystem path (relative to the root path):
    regexp = r"P[0-9][0-9][0-9]"
    if occursin(regexp, misr_fpath)
        mregexp = match(regexp, misr_fpath)
        if mregexp.offset > 1
            mroot_misr = misr_fpath[1:mregexp.offset - 1]
            relpath_misr = misr_fpath[mregexp.offset:end]
        else
            mroot_misr = ""
            relpath_misr = misr_fpath
        end
        misr_path = tryparse(Int, relpath_misr[2:4]; base = 10)
        if last(relpath_misr, 1) == "/"
            relpath_misr = chop(relpath_misr, tail = 1)
        end
        misr_prdct = relpath_misr[6:end]
    else
        error("split_misr_fpath: The positional argument misr_fpath is not a properly formatted directory path for MISR data files: MISR Path missing.")
    end

    return mroot_misr, misr_path, misr_prdct

end

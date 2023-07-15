"""
    mroot_misrhr, misr_path, misr_block, misrhr_prdct, misrhr_subprdct =
        split_misrhr_fpath(misrhr_fpath)

# Purpose(s):
* Split the full filesystem path name `misrhr_fpath` of a directory containing MISR-HR product file(s) and return the MISR-HR root directory, the MISR Path number and the MISR-HR product acronym.

# Positional argument(s):
* `misrhr_fpath::AbstractString`: The filesystem path name of a directory containing MISR-HR product file(s).

# Keyword argument(s): None.

# Return value(s):
* `mroot_misrhr::AbstractString`: The root directory for MISR-HR product files.
* `misr_path::Integer`: The MISR Path number.
* `misr_block::Integer`: The MISR Block number.
* `misrhr_prdct::AbstractString`: The MISR-HR product acronym.
* `misrhr_subprdct::AbstractString`: The MISR-HR subproduct acronym (only for TIP products).

# Algorithm:
* This function splits the absolute filesystem path name of a directory containing MISR-HR product files and returns the MISR-HR root directory `mroot_misrhr`, the MISR Path number, the MISR-HR product acronym and the MISR-HR subproduct acronym.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* The filesystem path is a string containing the name of a directory; the MISR Path is a number indicating the geographical region being acquired by the instrument on a particular Orbit.
* This function assumes that MISR-HR product file(s) are organized as described in the MISR-HR Processing System User Manual.
* This function does not verify that the input argument `misrhr_fpath` exists, or that the output values are valid, although an error condition may be raised if the syntax of `misrhr_fpath` cannot be interpreted.

# Example 1:
```julia
julia> using Tools

julia> mroot_misrhr, misr_path, misr_block, misrhr_prdct, misrhr_subprdct =
           split_misrhr_fpath("/Volumes/MISR-HR/P168/B110/TIP/GRN/")
("/Volumes/MISR-HR/", 168, 110, "TIP", "GRN")
```

# Example 2:
```julia
julia> using Tools

julia> mroot_misrhr, misr_path, misr_block, misrhr_prdct, misrhr_subprdct =
            split_misrhr_fpath("/Volumes/MISR-HR/P168/B111/L1B3/")
("/Volumes/MISR-HR/", 168, 111, "L1B3", "")
```
"""
function split_misrhr_fpath(
    misrhr_fpath::AbstractString
    )::Tuple{AbstractString, Integer, Integer, AbstractString, AbstractString}

    # Initialize the output variables to null values:
    mroot_misrhr = ""
    misr_path = 0
    misr_block = 0
    misrhr_prdct = ""
    misrhr_subprdct = ""

    # Look for the pattern `"Pxxx"` where `xxx` is a MISR Path number as the start of the filesystem path (relative to the root path) and split the MISR-HR root directory:
    regexp = r"P[0-9][0-9][0-9]"
    if occursin(regexp, misrhr_fpath)
        mregexp = match(regexp, misrhr_fpath)
        if mregexp.offset > 1
            mroot_misrhr = misrhr_fpath[1:mregexp.offset - 1]
            relpath_misrhr = misrhr_fpath[mregexp.offset:end]
        else
            relpath_misrhr = misrhr_fpath
        end

    # Retrieve the MISR Path number:
        misr_path = tryparse(Int, relpath_misrhr[2:4]; base = 10)
        relpath_misrhr = relpath_misrhr[6:end]

    # Retrieve the MISR Block number:
        if (first(relpath_misrhr, 1) == "B") & (length(relpath_misrhr) >= 5)
            misr_block = tryparse(Int, relpath_misrhr[2:4]; base = 10)
            if misr_block === nothing
                error("split_misrhr_fpath: The input argument misrhr_fpath is not a properly formatted directory path for MISR-HR product files: MISR Block not formatted as Bxxx with xxx being an integer.")
            end
            relpath_misrhr = relpath_misrhr[6:end]

    # Retrieve the MISR-HR product acronym:
            idx = findfirst("/", relpath_misrhr)
            if idx === nothing
                misrhr_prdct = relpath_misrhr
                relpath_misrhr = ""
            else
                misrhr_prdct = relpath_misrhr[1:idx[1] - 1]
                relpath_misrhr = relpath_misrhr[idx[1] + 1:end]
            end

    # Retrieve an eventual product subdirectory for the MISR-HR TIP product:
            if (misrhr_prdct == "TIP") & (length(relpath_misrhr) >= 1)
                misrhr_subprdct = relpath_misrhr
                if last(misrhr_subprdct, 1) == "/"
                    misrhr_subprdct = chop(misrhr_subprdct, tail = 1)
                end
            end
        else
            error("split_misrhr_fpath: The input argument misrhr_fpath is not a properly formatted directory path for MISR-HR product files: MISR Block missing.")
        end
    else
        error("split_misrhr_fpath: The input argument misrhr_fpath is not a properly formatted directory path for MISR-HR product files: MISR Path missing.")
    end

    return mroot_misrhr, misr_path, misr_block, misrhr_prdct, misrhr_subprdct

end

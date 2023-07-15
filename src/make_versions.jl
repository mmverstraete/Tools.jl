"""
    versions = make_versions(misr_version, misrhr_version; misr_prdct = misr_prdct)

# Purpose(s):
* Set the versioning information string for MISRHR filenames.

# Positional argument(s):
* `misr_version::AbstractString`: The version label for the main MISR data product.
* `misrhr_version::AbstractString`: The version label for the MISRHR processing system.

# Keyword argument(s):
* `misr_prdct::Union{AbstractString, Nothing} = nothing`: The main MISR product acronym.

# Return value(s):
* `versions::AbstractString`: The versioning information.

# Algorithm:
* This function nominally concatenates the positional arguments `misr_version` and `misrhr_version` if both are available;
- if the positional argument `misr_version` is set to a null string, the function determines its value by inspecting the keyword argument `misr_prdct`;
- if the positional argument `misr_version` is set to a null string and the keyword argument `misr_prdct` is absent or also set to a null string, this first element is ignored and the versioning string contains only information about the MISRHR processing system.
- if the positional argument `misrhr_version` is absent or set to a null string, this function retrieves its default value MISRHR version from function `set_misrhr_version`.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* Since each of the 8 elements of a filename must not contain an underscore (`_`), this function replaces that character by a dash (`-`).

# Example 1:
```julia
julia> using Tools

julia> make_versions("F1_2", "v2.0.0")
"F1-2+v2.0.0"
```

# Example 2:
```julia
julia> using Tools

julia> make_versions(; misr_prdct = "L1RTGM")
"F03-0024+v3.0.0"
```

# Example 3:
```julia
julia> using Tools

julia> make_versions("", "v2.3.4"; misr_prdct = "L1RCCM")
"F04-0025+v2.3.4"
```

# Example 4:
```julia
julia> using Tools

julia> make_versions()
"v3.0.0"
```

# Example 5:
```julia
julia> using Tools

julia> make_versions("", ""; misr_prdct = "")
"v3.0.0"
```
"""
function make_versions(
    misr_version::AbstractString = "",
    misrhr_version::AbstractString = "";
    misr_prdct::Union{AbstractString, Nothing} = nothing
    )::AbstractString

    if misr_version != ""
        mv = replace(misr_version, "_" => "-")
        versions = mv * '+'
    elseif misr_prdct !== nothing
        if misr_prdct == ""
            versions = ""
        else
            misr_version = set_misr_version(misr_prdct)
            mv = replace(misr_version, "_" => "-")
            versions = mv * '+'
        end
    else
        versions = ""
    end

    if misrhr_version != ""
        regexp = r"v[0-9].[0-9].[0-9]"
        if occursin(regexp, misrhr_version)
            versions = versions * misrhr_version
        else
            error("make_versions: Positional argument misrhr_version is invalid.")
        end
    else
        misrhr_version = set_misrhr_version()
        versions = versions * misrhr_version
    end

    return versions

end

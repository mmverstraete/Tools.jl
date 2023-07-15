"""
    bool = is_valid_misr_band(misr_band)

# Purpose(s):
* Determine whether the specified `misr_band` is a valid MISR band name.

# Positional argument(s):
* `misr_band::AbstractString`: The MISR band name.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_band` is valid or not.

# Algorithm:
* This function checks that the value of the positional argument `misr_band` is valid.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* The spelling of MISR band names follows the "Camel case" convention (first character in upper case and the rest of the string in lower case).

# Example 1:
```julia
julia> using Tools

julia> bool = is_valid_misr_band("NIR")
true
```

# Example 2:
```julia
julia> using Tools

julia> bool = is_valid_misr_band("red")
false
```
"""
function is_valid_misr_band(
    misr_band::AbstractString
    )::Bool

    # Set the list of valid MISR band names:
    valid_misr_bands = [
        "Blue",
        "Green",
        "Red",
        "NIR"]

    bool = (misr_band in valid_misr_bands)

    return bool

end

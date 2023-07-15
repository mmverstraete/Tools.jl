"""
    bool = is_valid_ftype(ftype)

# Purpose(s):
* Determine whether the specified `ftype` is a valid file type for the purpose of assembling a MISRHR filename.

# Positional argument(s):
* `ftype::AbstractString`: The file type.

# Keyword argument(s): None.

# Return value(s):
* `bool::Boolean`: Whether the argument `ftype` is a recognized file type or not.

# Algorithm:
* This function verifies that the positional argument `ftype` is a valid file type.

# Reference(s):
* The MISR-HR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Notes:
* Additional types of files can be admitted by updating the variable `valid_ftypes` below.

# Example 1:
```julia
julia> using Tools

julia> bool = is_valid_ftype("Map")
true
```

# Example 2:
```julia
julia> using Tools

julia> bool = is_valid_ftype("map")
false
```

# Example 3:
```julia
julia> using Tools

julia> bool = is_valid_ftype("Stats")
true
```
"""
function is_valid_ftype(
    ftype::AbstractString
    )::Bool

    # Set the list of valid file types:
    valid_ftypes = [
        "Caption",
        "Contour",
        "Data",
        "Doc",
        "Log",
        "Map",
        "Plot",
        "Save",
        "Scatt",
        "Stats",
        "Ts"]

    bool = (ftype in valid_ftypes)

    return bool
end

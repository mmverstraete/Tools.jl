"""
    misrhr_version = set_misrhr_version()

# Purpose(s):
* Return the current version label of the MISRHR software.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `misrhr_version::AbstractString`: The current version label of the MISRHR software.

# Algorithm:
* This function sets the current version label of the MISRHR software.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* Update this function as needed.

# Example 1:
```julia
julia> using Tools


misrhr_version = set_misrhr_version()


```
"""
function set_misrhr_version(
    )::AbstractString

    misrhr_version = "v3.0.0"

    return misrhr_version

end

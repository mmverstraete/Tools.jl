"""
    bool, misr_orbit_string = is_valid_misr_orbit(misr_orbit)

# Purpose(s):
* Determine whether the specified `misr_orbit` is a valid MISR Orbit number, and return the string version of the MISR Orbit number prepended with the letter 'O'.

# Positional argument(s):
* `misr_orbit::Integer`: The MISR Orbit number.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_orbit` is a valid MISR Orbit number or not.
* `misr_orbit_string::AbstractString`: The string version of the MISR Orbit number, prepended with the letter `'O'`.

# Algorithm:
* This function checks that the value of the positional argument `misr_orbit` lies within the allowed range (995 to 200,000), and if so, also returns a string version of that value formatted as `"Oxxxxxx"` where `xxxxxx` is the `misr_orbit` number padded with `0` to make a 6-digit number.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* Orbit number 995 is the first one for which actual measurements are available.

# Example 1:
```julia
julia> using Tools

julia> bool, misr_orbit_string = is_valid_misr_orbit(68050)
(true, "O068050")
```

# Example 2:
```
juljulia> using Tools

ia> bool, misr_orbit_string = is_valid_misr_orbit(994)
(false, "")
```
"""
function is_valid_misr_orbit(
    misr_orbit::Integer
    )::Tuple{Bool, AbstractString}

    if (994 < misr_orbit) & (misr_orbit < 200000)
        bool = true
        misr_orbit_string = "O" * string(misr_orbit; base = 10, pad = 6)
    else
        bool = false
        misr_orbit_string = ""
    end

    return bool, misr_orbit_string

end

"""
    bool, misr_orbit_string = is_valid_misr_orbit_tst_068050()

# Purpose(s):
* Generate the output of `is_valid_misr_orbit.jl` for testing purposes. Test 068050: For the MISR Orbit number 68050.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_orbit` is a valid MISR Orbit number or not.
* `misr_orbit_string::AbstractString`: The string version of the MISR Orbit number, prepended with the letter `'O'`.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misr_orbit_tst_068050.jl")
is_valid_misr_orbit_tst_068050

julia> bool, misr_orbit_string = is_valid_misr_orbit_tst_068050();

julia> @test bool == true
Test Passed

julia> @test misr_orbit_string == "O068050"
Test Passed
```
"""
function is_valid_misr_orbit_tst_068050()
    misr_orbit = 68050
    bool, misr_orbit_string = is_valid_misr_orbit(misr_orbit)

    return bool, misr_orbit_string

end

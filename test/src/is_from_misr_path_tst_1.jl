"""
    bool = is_from_misr_path_tst_1()

# Purpose(s):
* Generate the output of `is_from_misr_path.jl` for testing purposes. Test 1: Valid combination of Path and Orbit.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether the given `misr_orbit` belongs to the specified `misr_path` (`true`) or not (`false`).

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_from_misr_path_tst_1.jl")
is_from_misr_path_tst_1

julia> bool = is_from_misr_path_tst_1();

julia> @test bool == true
Test Passed
```
"""
function is_from_misr_path_tst_1()
    misr_path = 168
    misr_orbit = 68050
    bool = is_from_misr_path(misr_path, misr_orbit)

    return bool

end

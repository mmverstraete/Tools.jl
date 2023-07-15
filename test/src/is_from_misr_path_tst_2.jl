"""
    bool = is_from_misr_path_tst_2()

# Purpose(s):
* Generate the output of `is_from_misr_path.jl` for testing purposes. Test 2: Invalid combination of Path and Orbit.

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

julia> include(Tools_test * "is_from_misr_path_tst_2.jl")
is_from_misr_path_tst_2

julia> bool = is_from_misr_path_tst_2();

julia> @test bool == false
Test Passed
```
"""
function is_from_misr_path_tst_2()
    misr_path = 169
    misr_orbit = 68051
    bool = is_from_misr_path(misr_path, misr_orbit)

    return bool

end

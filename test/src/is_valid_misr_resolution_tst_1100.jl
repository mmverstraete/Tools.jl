"""
    bool, misr_resolution_string = is_valid_misr_resolution_tst_1100()

# Purpose(s):
* Generate the output of `is_valid_misr_resolution.jl` for testing purposes. Test 1100: For the generic spatial resolution of 1100 m.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_resolution` is valid or not.
* `misr_resolution_string::AbstractString`: The string version of the MISR spatial resolution.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misr_resolution_tst_1100.jl")
is_valid_misr_resolution_tst_1100

julia> bool, misr_resolution_string = is_valid_misr_resolution_tst_1100();

julia> @test bool == true
Test Passed

julia> @test misr_resolution_string == "R1100"
Test Passed
```
"""
function is_valid_misr_resolution_tst_1100(
    )::Tuple{Bool, AbstractString}

    bool, misr_resolution_string = is_valid_misr_resolution(1100)

    return bool, misr_resolution_string

end

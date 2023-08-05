"""
    bool, resolution_string = is_valid_resolution_tst_1100()

# Purpose(s):
* Generate the output of `is_valid_resolution.jl` for testing purposes. Test 1100: For the generic spatial resolution of 1100 m.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `resolution` is valid or not.
* `resolution_string::AbstractString`: The string version of the MISR spatial resolution.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_resolution_tst_1100.jl")
is_valid_resolution_tst_1100

julia> bool, resolution_string = is_valid_resolution_tst_1100();

julia> @test bool == true
Test Passed

julia> @test resolution_string == "R1100"
Test Passed
```
"""
function is_valid_resolution_tst_1100(
    )::Tuple{Bool, AbstractString}

    bool, resolution_string = is_valid_resolution(1100)

    return bool, resolution_string

end

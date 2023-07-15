"""
    bool = is_valid_misr_band_tst_Blue()

# Purpose(s):
* Generate the output of `is_valid_misr_band.jl` for testing purposes. Test Blue: For the Blue band.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_band` is valid or not.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misr_band_tst_Blue.jl")
is_valid_misr_band_tst_Blue

julia> bool = is_valid_misr_band_tst_Blue();

julia> @test bool == true
Test Passed
```
"""
function is_valid_misr_band_tst_Blue(
    )::Bool

    bool = is_valid_misr_band("Blue")

    return bool

end

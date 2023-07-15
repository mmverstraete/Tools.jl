"""
    bool = is_valid_misr_band_tst_red()

# Purpose(s):
* Generate the output of `is_valid_misr_band.jl` for testing purposes. Test red: For the red band.

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

julia> include(Tools_test * "is_valid_misr_band_tst_red.jl")
is_valid_misr_band_tst_red

julia> bool = is_valid_misr_band_tst_red();

julia> @test bool == false
Test Passed
```
"""
function is_valid_misr_band_tst_red(
    )::Bool

    bool = is_valid_misr_band("red")

    return bool

end

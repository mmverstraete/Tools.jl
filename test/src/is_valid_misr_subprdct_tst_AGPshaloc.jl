"""
    bool, subprdct_name = is_valid_misr_subprdct_tst_AGPshaloc()

# Purpose(s):
* Generate the output of `is_valid_misr_subprdct.jl` for testing purposes. Test AGPshaloc: For the `shaloc` subproduct of the MISR AGP product.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_subprdct` acronym is a valid subproduct of `misr_prdct` or not.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misr_subprdct_tst_AGPshaloc.jl")
is_valid_misr_subprdct_tst_AGPshaloc

julia> bool, subprdct_name = is_valid_misr_subprdct_tst_AGPshaloc();

julia> @test bool == true
Test Passed

julia> @test subprdct_name == "Shallow Ocean"
Test Passed
```
"""
function is_valid_misr_subprdct_tst_AGPshaloc(
    )::Tuple{Bool, AbstractString}

    bool, subprdct_name = is_valid_misr_subprdct("AGP", "shaloc")

    return bool, subprdct_name

end

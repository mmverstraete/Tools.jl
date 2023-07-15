"""
    bool = is_valid_misrhr_prdct_tst_L1RCCMmvr()

# Purpose(s):
* Generate the output of `is_valid_misrhr_prdct.jl` for testing purposes. Test L1RCCMmvr: For the MISRHR L1RCCMmvr product.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misrhr_prdct` is valid or not.
* `prdct_full_name::AbstractString`: The full name of the MISRHR product.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misrhr_prdct_tst_L1RCCMmvr.jl")
is_valid_misrhr_prdct_tst_1

julia> bool, prdct_full_name = is_valid_misrhr_prdct_tst_L1RCCMmvr();

julia> @test bool == true
Test Passed

julia> @test prdct_full_name == "Radiometric Camera-by-Camera Cloud Mask, Missing Values Replaced"
Test Passed
```
"""
function is_valid_misrhr_prdct_tst_L1RCCMmvr()

    misrhr_prdct = "L1RCCMmvr"
    bool, prdct_full_name = is_valid_misrhr_prdct(misrhr_prdct)

    return bool, prdct_full_name

end

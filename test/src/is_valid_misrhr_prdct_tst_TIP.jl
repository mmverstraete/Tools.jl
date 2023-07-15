"""
    bool = is_valid_misrhr_prdct_tst_TIP()

# Purpose(s):
* Generate the output of `is_valid_misrhr_prdct.jl` for testing purposes. Test TIP: For the MISR-HR TIP product.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misrhr_prdct` is valid or not.
* `prdct_full_name::AbstractString`: The full name of the MISR-HR product.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misrhr_prdct_tst_TIP.jl")
is_valid_misrhr_prdct_tst_TIP

julia> bool, prdct_full_name = is_valid_misrhr_prdct_tst_TIP();

julia> @test bool == true
Test Passed

julia> @test prdct_full_name == "Two-stream Inversion Package"
Test Passed
```
"""
function is_valid_misrhr_prdct_tst_TIP()

    misrhr_prdct = "TIP"
    bool, prdct_full_name = is_valid_misrhr_prdct(misrhr_prdct)

    return bool, prdct_full_name

end

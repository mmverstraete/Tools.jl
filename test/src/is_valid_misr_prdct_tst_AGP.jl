"""
    bool, prdct_name, prdct_full_name, prdct_esdt = is_valid_misr_prdct_tst_AGP()

# Purpose(s):
* Generate the output of `is_valid_misr_prdct.jl` for testing purposes. Test AGP: For the MISR AGP product.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_prdct` acronym is valid or not.
* `prdct_name::AbstractString`: The MISR product label used in filenames.
* `prdct_full_name::AbstractString`: The full name of the MISR product.
* `prdct_esdt::AbstractString`: The Earth Science Data Type (ESDT) label of the MISR product.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misr_prdct_tst_AGP.jl")
is_valid_misr_prdct_tst_AGP

julia> bool, prdct_name, prdct_full_name, prdct_esdt = is_valid_misr_prdct_tst_AGP();

julia> @test bool == true
Test Passed

julia> @test prdct_name == "AGP"
Test Passed

julia> @test prdct_full_name == "Ancillary Geographic Product"
Test Passed

julia> @test prdct_esdt == "MIANCAGP"
Test Passed
```
"""
function is_valid_misr_prdct_tst_AGP()
    misr_prdct = "AGP"
    bool, prdct_name, prdct_full_name, prdct_esdt = is_valid_misr_prdct(misr_prdct)

    return bool, prdct_name, prdct_full_name, prdct_esdt

end

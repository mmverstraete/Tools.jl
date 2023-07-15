"""
    bool, prdct_name, prdct_full_name, prdct_esdt = is_valid_misr_prdct_tst_RCCM()

# Purpose(s):
* Generate the output of `is_valid_misr_prdct.jl` for testing purposes. Test RCCM: For the MISR L1RCCM product.

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

# Versioning:
* Mtk C Library: Version 1.5.
* Julia function: Version 0.1.0 (2023-05-15).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misr_prdct_tst_RCCM.jl")
is_valid_misr_prdct_tst_RCCM

julia> bool, prdct_name, prdct_full_name, prdct_esdt = is_valid_misr_prdct_tst_RCCM();

julia> @test bool == true
Test Passed

julia> @test prdct_name == "GRP_RCCM_GM"
Test Passed

julia> @test prdct_full_name == "Radiometric Camera-by-Camera Cloud Mask Product"
Test Passed

julia> @test prdct_esdt == "MIRCCM"
Test Passed
```
"""
function is_valid_misr_prdct_tst_RCCM()
    misr_prdct = "L1RCCM"
    bool, prdct_name, prdct_full_name, prdct_esdt = is_valid_misr_prdct(misr_prdct)

    return bool, prdct_name, prdct_full_name, prdct_esdt

end

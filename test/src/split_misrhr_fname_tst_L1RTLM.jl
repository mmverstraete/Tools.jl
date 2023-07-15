"""
ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id = split_misrhr_fname_tst_L1RTLM()

# Purpose(s):
Generate the output of `split_misrhr_fname.jl` for testing purposes. Test L1RTLM: For a MISRHR L1RTLM data product.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `ftype_id::AbstractString`: The file type.
* `prdct_id::AbstractString`: The main product acronym .
* `subprdct_id::AbstractString`: The subproduct acronym.
* `qualifier_id::AbstractString`: The qualifier of the subproduct or of the processing applied.
* `resolution_id::Integer`: The spatial resolution of the product (in m).
* `misr_path1_id::Integer`: The first (or only) MISR Path number.
* `misr_path2_id::Integer`: The last MISR Path number.
* `misr_orbit1_id::Integer`: The first (or only) MISR Orbit number.
* `misr_orbit2_id::Integer`: The last MISR Orbit number.
* `misr_block1_id::Integer`: The first (or only) MISR Block number.
* `misr_block2_id::Integer`: The last MISR Block number.
* `misr_site::AbstractString`: The MISR Local Mode Site name.
* `strdate1::AbstractString`: The string representation of the starting date of the period of interest, formatted as "yyyy-mm-dd".
* `strdate2::AbstractString`: The string representation of the ending date of the period of interest, formatted as "yyyy-mm-dd".
* `misr_version::AbstractString`: The version label for the main MISR data product.
* `misrhr_version::AbstractString`: The version label for the MISRHR processing system.
* `ext::AbstractString`: The file extension.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "split_misrhr_fname_tst_L1RTLM.jl")
split_misrhr_fname_tst_L1RTLM

julia> ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id = split_misrhr_fname_tst_L1RTLM();

julia> @test ftype_id == "Map"
Test Passed

julia> @test prdct_id == "L1RTLM"
Test Passed

julia> @test subprdct_id == "refl"
Test Passed

julia> @test qualifier_id == "test"
Test Passed

julia> @test resolution_id == 275
Test Passed

julia> @test misr_path1_id == 168
Test Passed

julia> @test misr_path2_id == 0
Test Passed

julia> @test misr_orbit1_id == 60000
Test Passed

julia> @test misr_orbit2_id == 70000
Test Passed

julia> @test misr_block1_id == 110
Test Passed

julia> @test misr_block2_id == 0
Test Passed

julia> @test misr_site_id == "SITE-SKUKUZA"
Test Passed

julia> @test strdate1_id == "2011-03-30"
Test Passed

julia> @test strdate2_id == "2013-02-14"
Test Passed

julia> @test proc_date_id == "2023-07-14"
Test Passed

julia> @test misr_version_id == "F03-0024"
Test Passed

julia> @test misrhr_version_id == "v3.0.0"
Test Passed

julia> @test ext_id == ".png"
Test Passed
```
"""
function split_misrhr_fname_tst_L1RTLM(
    )::Tuple{AbstractString,
        AbstractString,
        AbstractString,
        AbstractString,
        Integer,
        Integer,
        Integer,
        Integer,
        Integer,
        Integer,
        Integer,
        AbstractString,
        AbstractString,
        AbstractString,
        AbstractString,
        AbstractString,
        AbstractString,
        AbstractString}

    misrhr_fname = misrhr_fname = "Map_L1RTLM_refl_test_R275_P168+O060000-O070000+B110+SITE-SKUKUZA_2011-03-30+2013-02-14+2023-07-14_F03-0024+v3.0.0.png"
    ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id = split_misrhr_fname(misrhr_fname)

    return ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id

end

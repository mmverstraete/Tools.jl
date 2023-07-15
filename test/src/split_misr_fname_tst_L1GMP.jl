"""
    misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id = split_misr_fname_tst_L1GMP()

# Purpose(s):
* Generate the output of `split_misr_fname.jl` for testing purposes. Test L1GMP: For the MISR GP_GMP product.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `misr_product_id::AbstractString`: The full MISR data product name.
* `misr_prdct_id::AbstractString`: The MISR data product acronym.
* `misr_mode_id::AbstractString`: The MISR Mode.
* `misr_path_id::Integer`: The MISR Path number.
* `misr_orbit_id::Integer`: The MISR Orbit number.
* `misr_camera_id::AbstractString`: The MISR Camera name.
* `misr_site_id::AbstractString`: The MISR Local Mode site name.
* `misr_version_id::AbstractString`: The MISR Version identifier.
* `ext_id::AbstractString`: The file extension.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "split_misr_fname_tst_L1GMP.jl")
split_misr_fname_tst_L1GMP

julia> misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id = split_misr_fname_tst_L1GMP();

julia> @test misr_product_id == "GP_GMP"
Test Passed

julia> @test misr_prdct_id == "L1GMP"
Test Passed

julia> @test misr_mode_id == ""
Test Passed

julia> @test misr_path_id == 168
Test Passed

julia> @test misr_orbit_id == 68050
Test Passed

julia> @test misr_camera_id == ""
Test Passed

julia> @test misr_site_id == ""
Test Passed

julia> @test misr_version_id == "F03_0013"
Test Passed

julia> @test ext_id == ".hdf"
Test Passed
```
"""
function split_misr_fname_tst_L1GMP(
    )::Tuple{AbstractString, AbstractString, AbstractString, Integer, Integer, AbstractString, AbstractString, AbstractString, AbstractString}

    misr_fname = "/Users/michel/Projects/MISR/Data_P168_O068050/MISR_AM1_GP_GMP_P168_O068050_F03_0013.hdf"
    misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id = split_misr_fname(misr_fname)

    return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id

end

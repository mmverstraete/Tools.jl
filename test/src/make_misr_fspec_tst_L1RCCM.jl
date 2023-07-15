"""
    misr_fspec = make_misr_fspec_tst_L1RCCM()

# Purpose(s):
* Generate the output of `make_misr_fpath.jl` for testing purposes. Test L1RCCM: For a MISR L1RCCM file.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `misr_fspec::Vector{AbstractString}`: The specification(s) (path(s) and name(s)) of the MISR data file(s) correponding to the input arguments.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "make_misr_fspec_tst_L1RCCM.jl")
make_misr_fspec_tst_L1RCCM

julia> misr_fspec = make_misr_fspec_tst_L1RCCM();

julia> @test misr_fspec == [
    "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_DF_F04_0025.hdf",
    "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_CF_F04_0025.hdf",
    "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_BF_F04_0025.hdf",
    "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_AF_F04_0025.hdf",
    "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_AN_F04_0025.hdf",
    "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_AA_F04_0025.hdf",
    "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_BA_F04_0025.hdf",
    "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_CA_F04_0025.hdf",
    "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_DA_F04_0025.hdf"]
Test Passed
```
"""
function make_misr_fspec_tst_L1RCCM(
    )::Vector{AbstractString}

    set_mroots("Reset");
    misr_fspec = make_misr_fspec("L1RCCM", 168;
        misr_orbit = 68050, misr_camera = "*")

    return misr_fspec

end

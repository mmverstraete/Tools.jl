"""
    mroot_misr, misr_path, misr_prdct = split_misr_fpath_tst_L1RTGM()

# Purpose(s):
* Generate the output of `split_misr_fpath.jl` for testing purposes. Test L1RTGM: For a MISR L1RTGM file.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `mroot_misr::AbstractString`: The root directory for MISR data files.
* `misr_path::Integer`: The MISR Path number.
* `misr_prdct::AbstractString`: The MISR product acronym.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "split_misr_fpath_tst_L1RTGM.jl")
split_misr_fpath_tst_L1RTGM

julia> mroot_misr, misr_path, misr_prdct = split_misr_fpath_tst_L1RTGM();

julia> @test mroot_misr == "/Volumes/MISR_Data0/"
Test Passed

julia> @test misr_path == 168
Test Passed

julia> @test misr_prdct == "L1RTGM"
Test Passed
```
"""
function split_misr_fpath_tst_L1RTGM(
    )::Tuple{AbstractString, Integer, AbstractString}

    misr_fpath = "/Volumes/MISR_Data0/P168/L1RTGM"
    mroot_misr, misr_path, misr_prdct = split_misr_fpath(misr_fpath)

    return mroot_misr, misr_path, misr_prdct

end

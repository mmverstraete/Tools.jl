"""
    mroot_misr, misr_path, misr_prdct = split_misr_fpath_tst_L1RCCM()

# Purpose(s):
* Generate the output of `split_misr_fpath.jl` for testing purposes. Test L1RCCM: For a MISR L1RCCM file.

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

julia> include(Tools_test * "split_misr_fpath_tst_L1RCCM.jl")
split_misr_fpath_tst_L1RCCM

julia> mroot_misr, misr_path, misr_prdct = split_misr_fpath_tst_L1RCCM();

julia> @test mroot_misr == ""
Test Passed

julia> @test misr_path == 168
Test Passed

julia> @test misr_prdct == "L1RCCM"
Test Passed
```
"""
function split_misr_fpath_tst_L1RCCM(
    )::Tuple{AbstractString, Integer, AbstractString}

    misr_fpath = "P168/L1RCCM/"
    mroot_misr, misr_path, misr_prdct = split_misr_fpath(misr_fpath)

    return mroot_misr, misr_path, misr_prdct

end

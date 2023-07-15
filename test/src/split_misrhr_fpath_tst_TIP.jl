"""
    mroot_misrhr, misr_path, misr_block, misrhr_prdct, misrhr_subprdct = split_misrhr_fpath_tst_TIP()

# Purpose(s):
* Generate the output of `split_misrhr_fpath.jl` for testing purposes. Test TIP: For a TIP file.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `mroot_misrhr::AbstractString`: The root directory for MISRHR product files.
* `misr_path::Integer`: The MISR Path number.
* `misr_block::Integer`: The MISR Block number.
* `misrhr_prdct::AbstractString`: The MISRHR product acronym.
* `misrhr_subprdct::AbstractString`: The MISRHR subproduct acronym (only for TIP products).

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "split_misrhr_fpath_tst_TIP.jl")
split_misrhr_fpath_tst_TIP

julia> mroot_misrhr, misr_path, misr_block, misrhr_prdct, misrhr_subprdct = split_misrhr_fpath_tst_TIP();

julia> @test mroot_misrhr == "/Volumes/MISRHR/"
Test Passed

julia> @test misr_path == 168
Test Passed

julia> @test misr_block == 110
Test Passed

julia> @test misrhr_prdct == "TIP"
Test Passed

julia> @test misrhr_subprdct == "GRN"
Test Passed
```
"""
function split_misrhr_fpath_tst_TIP(
    )::Tuple{AbstractString, Integer, Integer, AbstractString, AbstractString}

    misrhr_fpath = "/Volumes/MISRHR/P168/B110/TIP/GRN/"
    mroot_misrhr, misr_path, misr_block, misrhr_prdct, misrhr_subprdct =
        split_misrhr_fpath(misrhr_fpath)

    return mroot_misrhr, misr_path, misr_block, misrhr_prdct, misrhr_subprdct

end

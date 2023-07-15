"""
    misrhr_fname = make_misrhr_fname_tst_L1RCCMmvr()

# Purpose(s):
* Generate the output of `make_misrhr_fname.jl` for testing purposes. Test L1RCCMmvr: For a MISRHR L1RCCMmvr file.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `misrhr_fname::AbstractString`: The name of the MISRHR output file.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "make_misrhr_fname_tst_L1RCCMmvr.jl")
make_misrhr_fname_tst_L1RCCMmvr

julia> misrhr_fname = make_misrhr_fname_tst_L1RCCMmvr();

julia> @test misrhr_fname == "Data_L1RCCMmvr_cldm_main_R1100_P168+O068050+B110_2012-10-03+2012-10-03+" * Dates.format(today(), "yyyy-mm-dd") * "_F04-0025+v3.0.0.nc"
Test Passed
```
"""
function make_misrhr_fname_tst_L1RCCMmvr(
    )::AbstractString

    misrhr_fname = make_misrhr_fname("Data", "L1RCCMmvr", "cldm";
        misr_path1 = 168, misr_orbit1 = 68050, misr_block1 = 110)

    return misrhr_fname

end

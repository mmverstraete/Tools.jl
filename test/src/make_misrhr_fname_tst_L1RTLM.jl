"""
    misrhr_fname = make_misrhr_fname_tst_L1RTLM()

# Purpose(s):
* Generate the output of `make_misrhr_fname.jl` for testing purposes. Test L1RTLM: For a MISR L1RTLM file.

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

julia> include(Tools_test * "make_misrhr_fname_tst_L1RTLM.jl")
make_misrhr_fname_tst_L1RTLM

julia> misrhr_fname = make_misrhr_fname_tst_L1RTLM();

julia> @test misrhr_fname == "Map_L1RTLM_refl_test_R275_P168+O060000-O070000+B110+SITE-SKUKUZA_2011-03-30+2013-02-14+2023-07-13_F03-0024+v3.0.0.png"
Test Passed
```
"""
function make_misrhr_fname_tst_L1RTLM(
    )::AbstractString

    misrhr_fname = make_misrhr_fname("Map", "L1RTLM", "refl";
        qualifier = "test", misr_path1 = 168,
        misr_orbit1 = 60000, misr_orbit2 = 70000,
        misr_block1 = 110, misr_site = "skukuza")

    return misrhr_fname

end

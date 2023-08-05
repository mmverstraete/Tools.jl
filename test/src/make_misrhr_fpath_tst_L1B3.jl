"""
    misrhr_fpath = make_misrhr_fpath_tst_L1B3()

# Purpose(s):
* Generate the output of `make_misrhr_fpath.jl` for testing purposes. Test L1B3: For a `L1B3` product.

# Positional argument(s): None.

# Keyword argument(s): None:

# Return value(s):
* `misrhr_fpath::AbstractString`: The full name of the directory containing the MISRHR file(s) for the specified arguments.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "make_misrhr_fpath_tst_L1B3.jl")
make_misrhr_fpath_tst_L1B3

julia> misrhr_fpath = make_misrhr_fpath_tst_L1B3();

julia> @test misrhr_fpath == "/Users/michel/Projects/MISR/Scrap/Dev/Test/P168+O068050+B110/make_misrhr_fpath/L1B3/Data/"
Test Passed
```
"""
function make_misrhr_fpath_tst_L1B3(
    )::AbstractString

    set_mroots("Reset")

    misr_path1 = 168
    misr_orbit1 = 68050
    misr_block1 = 110
    prdct = "L1B3"
    ftype = "Data"
    misrhr_fpath = make_misrhr_fpath(; misr_path1 = misr_path1,
        misr_orbit1 = misr_orbit1, misr_block1 = misr_block1,
        prdct = prdct, ftype = ftype)

    return misrhr_fpath

end

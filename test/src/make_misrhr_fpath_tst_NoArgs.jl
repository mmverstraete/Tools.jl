"""
    misrhr_fpath = make_misrhr_fpath_tst_NoArgs()

# Purpose(s):
* Generate the output of `make_misrhr_fpath.jl` for testing purposes. Test NoArgs: When the environment variables are not set and no arguments are provided.

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

julia> include(Tools_test * "make_misrhr_fpath_tst_NoArgs.jl")
make_misrhr_fpath_tst_NoArgs

julia> misrhr_fpath = make_misrhr_fpath_tst_NoArgs();

julia> @test misrhr_fpath == "~/Dev/Test/NOLOC/make_misrhr_fpath/all_prdcts/all_ftypes/"
Test Passed
```
"""
function make_misrhr_fpath_tst_NoArgs(
    )::AbstractString

    set_mroots("Unset")

    misrhr_fpath = make_misrhr_fpath()

    return misrhr_fpath

end

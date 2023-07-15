"""
    mroots = set_mroots_tst_1()

# Purpose(s):
* Generate the output of `set_mroots.jl` for testing purposes. Test 1: Set arbitrary values.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `mroots::Tuple{AbstractString, AbstractString, AbstractString, AbstractString, AbstractString}`: The set of 5 environmental variables (if set) or messages (if unset).

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "set_mroots_tst_1.jl")
set_mroots_tst_1

julia> mroots = set_mroots_tst_1();

julia> @test mroots[1] == "/dir/misr"
Test Passed

julia> @test mroots[2] == "/dir/misrhr"
Test Passed

julia> @test mroots[3] == "/dir/agp"
Test Passed

julia> @test mroots[4] == "/dir/scrap"
Test Passed
```
"""
function set_mroots_tst_1(
    )::Tuple{AbstractString, AbstractString, AbstractString, AbstractString}

    mroots = set_mroots("Set"; mroot_misr = "/dir/misr", mroot_misrhr = "/dir/misrhr", mroot_agp = "/dir/agp", mroot_scrap = "/dir/scrap")

    return mroots

end

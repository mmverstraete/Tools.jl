"""
    mroots = set_mroots_tst_2()

# Purpose(s):
* Generate the output of `set_mroots.jl` for testing purposes. Test 2: Update some of the environmental variables, after running `set_mroots_tst_1.jl`.

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

julia> include(Tools_test * "set_mroots_tst_2.jl")
set_mroots_tst_2

julia> mroots = set_mroots_tst_2();

julia> @test mroots[1] == "/Volumes/MISR_Data1"
Test Passed

julia> @test mroots[2] == "/dir/misrhr"
Test Passed

julia> @test mroots[3] == "/dir/agp"
Test Passed

julia> @test mroots[4] == "/dir/scrap"
Test Passed
```
"""
function set_mroots_tst_2(
    )::Tuple{AbstractString, AbstractString, AbstractString, AbstractString}

    mroots = set_mroots("Set"; mroot_misr = "/Volumes/MISR_Data1");

    return mroots

end

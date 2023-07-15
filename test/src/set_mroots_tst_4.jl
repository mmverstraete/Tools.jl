"""
    mroots = set_mroots_tst_4()

# Purpose(s):
* Generate the output of `set_mroots.jl` for testing purposes. Test 4: Reset the environmental variables to their default values.

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

julia> include(Tools_test * "set_mroots_tst_4.jl")
set_mroots_tst_4

julia> mroots = set_mroots_tst_4();

julia> @test mroots[1] == "/Volumes/MISR_Data0/"
Test Passed

julia> @test mroots[2] == "/Volumes/MISRHR/"
Test Passed

julia> @test mroots[3] == "/Users/michel/Projects/MISR/Data/AGP/"
Test Passed

julia> @test mroots[4] == "/Users/michel/Projects/MISR/Scrap/"
Test Passed
```
"""
function set_mroots_tst_4(
    )::Tuple{AbstractString, AbstractString, AbstractString, AbstractString}

    mroots = set_mroots("Reset")

    return mroots

end

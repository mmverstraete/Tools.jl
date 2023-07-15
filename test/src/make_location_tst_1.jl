"""
    location = make_location_tst_1()

# Purpose(s):
* Generate the output of `make_location.jl` for testing purposes. Test 1: No keyword arguments.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `location::AbstractString`: The string describing the geographical area covered by the MISRHR product.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "make_location_tst_1.jl")
make_location_tst_1

julia> location = make_location_tst_1();

julia> @test location == "NOLOC"
Test Passed
```
"""
function make_location_tst_1()

    location = make_location()

    return location

end

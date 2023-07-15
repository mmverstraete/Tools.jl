"""
    location = make_location_tst_2()

# Purpose(s):
* Generate the output of `make_location.jl` for testing purposes. Test 2: One keyword arguments.

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

julia> include(Tools_test * "make_location_tst_2.jl")
make_location_tst_2

julia> location = make_location_tst_2();

julia> @test location == "P168"
Test Passed
```
"""
function make_location_tst_2()

    location = make_location(misr_path1 = 168)

    return location

end

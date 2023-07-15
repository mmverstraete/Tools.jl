"""
    location = make_location_tst_4()

# Purpose(s):
* Generate the output of `make_location.jl` for testing purposes. Test 4: Multiple keyword arguments and ranges.

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

julia> include(Tools_test * "make_location_tst_4.jl")
make_location_tst_4

julia> location = make_location_tst_4();

julia> @test location == "P168-P170+O068050-O072000+SITE-SKUKUZA"
Test Passed
```
"""
function make_location_tst_4()

    location = make_location(; misr_path1 = 168, misr_path2 = 170,
           misr_orbit1 = 68050, misr_orbit2 = 72000,
           misr_site = "skukuza")

    return location

end

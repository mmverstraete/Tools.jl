"""
    misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site = split_location_tst_PPOOBBS()

# Purpose(s):
* Generate the output of `split_location.jl` for testing purposes. Test 1: `location == "P168-P170+O068050-O072000+B110-B115+SITE_SKUKUZA"`.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `misr_path1::Integer`: The first (or only) MISR Path number.
* `misr_path2::Integer`: The last MISR Path number.
* `misr_orbit1::Integer`: The first (or only) MISR Orbit number.
* `misr_orbit2::Integer`: The last MISR Orbit number.
* `misr_block1::Integer`: The first (or only) MISR Block number.
* `misr_block2::Integer`: The last MISR Block number.
* `misr_site::AbstractString`: The MISR Local Mode Site name.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "split_location_tst_PPOOBBS.jl")
split_location_tst_PPOOBBS

julia> misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site = split_location_tst_PPOOBBS();

julia> @test (misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site) == (168, 170, 68050, 72000, 110, 115, "SITE_SKUKUZA")
Test Passed
```
"""
function split_location_tst_PPOOBBS(
    )::Tuple{Integer, Integer, Integer, Integer, Integer, Integer, AbstractString}

    location = "P168-P170+O068050-O072000+B110-B115+SITE_SKUKUZA"

    misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site = split_location(location)

    return misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site

end

"""
    orbit_date, orbit_date_string = get_orbit_date_tst_Datapool()

# Purpose(s):
* Generate the output of `get_orbit_date.jl` for testing purposes. Test 2: Datapool format.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `orbit_date::Date`: The date of acquisition of the specified MISR Orbit.
* `orbit_date_string::Date`: The string representation of the date of acquisition of the specified MISR Orbit.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "get_orbit_date_tst_Datapool.jl")
get_orbit_date_tst_Datapool

julia> orbit_date, orbit_date_string = get_orbit_date_tst_Datapool();

julia> @test orbit_date == Date("2012-10-03")
Test Passed

julia> @test orbit_date_string == "2012.10.03"
Test Passed
```
"""
function get_orbit_date_tst_Datapool(
    )::Tuple{Dates.Date, AbstractString}

    orbit_date, orbit_date_string = get_orbit_date(68050; fmt = "Datapool")

    return orbit_date, orbit_date_string

end

"""
    dates, date1, date2, date3 = make_dates_tst_1100()

# Purpose(s):
* Generate the output of `make_dates.jl` for testing purposes. Test 1100: Using the two positional arguments.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `dates::AbstractString`: The string needed to generate a MISRHR filename.
* `date1::Dates`: The first date.
* `date2::Dates`: The second date.
* `date3::Dates`: The third date.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> include(Tools_test * "make_dates_tst_1100.jl")
make_dates_tst_1100

julia> dates, date1, date2, date3 = make_dates_tst_1100();

julia> @test dates == "2012-06-13+2014-06-28+" * Dates.format(today(), "yyyy-mm-dd")
Test Passed

julia> @test date1 == Date("2012-06-13")
Test Passed

julia> @test date2 == Date("2014-06-28")
Test Passed

julia> @test date3 == today()
Test Passed
```
"""
function make_dates_tst_1100(
    )::Tuple{AbstractString, Date, Date, Date}

    dates, date1, date2, date3 = make_dates("2012-06-13", "2014-06-28")

    return dates, date1, date2, date3

end

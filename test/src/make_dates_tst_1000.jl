"""
    from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates_tst_1000()

# Purpose(s):
* Generate the output of `make_dates.jl` for testing purposes. Test 1000: Using only the first positional argument.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `from_date::Dates`: The starting date of the period of interest.
* `until_date::Dates`: The ending date of the period of interest.
* `today_date::Dates`: The date of execution of this function.
* `from_str::AbstractString`: The starting date of the period of interest, formatted as `yyyy-mm-dd`.
* `until_str::AbstractString`: The ending date of the period of interest, formatted as `yyyy-mm-dd`.
* `today_str::AbstractString`: The date of execution of this function, formatted as `yyyy-mm-dd`.
* `dates_str::AbstractString`: The string containing all three dates required to generate a MISRHR filename.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> include(Tools_test * "make_dates_tst_1000.jl")
make_dates_tst_1000

julia> from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates_tst_1000();

julia> @test from_date == Date("2012-06-13")
Test Passed

julia> @test until_date == Date("2012-06-13")
Test Passed

julia> @test today_date == Dates.today()
Test Passed

julia> @test from_str == "2012-06-13"
Test Passed

julia> @test until_str == "2012-06-13"
Test Passed

julia> @test today_str == Dates.format(today_date, "yyyy-mm-dd")
Test Passed

julia> @test dates_str == from_str * '+' * until_str * '+' * today_str
Test Passed
```
"""
function make_dates_tst_1000(
    )::Tuple{Date, Date, Date, AbstractString, AbstractString, AbstractString, AbstractString}

    from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates("2012-06-13")

    return from_date, until_date, today_date, from_str, until_str, today_str, dates_str

end

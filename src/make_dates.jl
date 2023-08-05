"""
    from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates(from, until; misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2)

# Purpose(s):
* Generate the dating information used in MISRHR filenames.

# Positional argument(s):
* `from::AbstractString = ""`: Optional string representation of the starting date of the period of interest, formatted as "yyyy-mm-dd".
* `until::AbstractString = ""`: Optional string representation of the ending date of the period of interest, formatted as "yyyy-mm-dd".

# Keyword argument(s):
* `misr_orbit1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Orbit number.
* `misr_orbit2::Union{Integer, Nothing} = nothing`: The last MISR Orbit number.

# Return value(s):
* `from_date::Dates`: The starting date of the period of interest.
* `until_date::Dates`: The ending date of the period of interest.
* `today_date::Dates`: The date of execution of this function.
* `from_str::AbstractString`: The starting date of the period of interest, formatted as `yyyy-mm-dd`.
* `until_str::AbstractString`: The ending date of the period of interest, formatted as `yyyy-mm-dd`.
* `today_str::AbstractString`: The date of execution of this function, formatted as `yyyy-mm-dd`.
* `dates_str::AbstractString`: The string containing all three dates required to generate a MISRHR filename.

# Algorithm:
* This function takes as input one or two dates, provided either as Strings or as MISR Orbit numbers, as well as the current date provided by the operating system of the computer, converts those items into both `Date` and `String` data types, and concatenates all three dates (each formatted as `"yyyy-mm-dd"`) as a single `String` formatted as required by the MISRHR file naming convention, i.e., separated by the `+` character.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* The positional argument `from` is optional; if missing, it is assigned the value of a null string. In that case, the keyword argument `misr_orbit1` must be provided, and its value must be valid. If both of those arguments are missing, an error condition is raised. If both of those arguments are provided, the positional argument `from` takes precedence over the keyword argument `misr_orbit1`, which is ignored.
* The positional argument `until` is optional; if missing, it is assigned the value of a null string. In that case, the keyword argument `misr_orbit2` must be provided, and its value must be valid. If both of those arguments are missing, the output values of `until_date` and `until_str` are set to `from_date` and `from_str`, respectively. If both of those arguments are provided, the positional argument `until` takes precedence over the keyword argument `misr_orbit2`, which is ignored.
* An error condition is also raised if the `until` date occurs prior to the `from` date.

# Example 1:
```julia
julia> using Tools

julia> from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates("2012-06-13")
(Date("2012-06-13"), Date("2012-06-13"), Date("2023-08-01"), "2012-06-13", "2012-06-13", "2023-08-01", "2012-06-13+2012-06-13+2023-08-01")
```

# Example 2:
```julia
julia> using Tools

julia> from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates("2012-06-13", "2014-06-28")
(Date("2012-06-13"), Date("2014-06-28"), Date("2023-08-01"), "2012-06-13", "2014-06-28", "2023-08-01", "2012-06-13+2014-06-28+2023-08-01")
```

# Example 3:
```julia
julia> using Tools

julia> from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates(; misr_orbit1 = 68050)
(Date("2012-10-03"), Date("2012-10-03"), Date("2023-08-01"), "2012-10-03", "2012-10-03", "2023-08-01", "2012-10-03+2012-10-03+2023-08-01")
```

# Example 4:
```julia
julia> using Tools

julia> from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates(; misr_orbit1 = 68050, misr_orbit2 = 72000)
(Date("2012-10-03"), Date("2013-07-01"), Date("2023-08-01"), "2012-10-03", "2013-07-01", "2023-08-01", "2012-10-03+2013-07-01+2023-08-01")
```

# Example 5:
```julia
julia> using Tools

julia> from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates("2012-06-13"; misr_orbit2 = 72000)
(Date("2012-06-13"), Date("2013-07-01"), Date("2023-08-01"), "2012-06-13", "2013-07-01", "2023-08-01", "2012-06-13+2013-07-01+2023-08-01")
```

# Example 6:
```julia
julia> using Tools

julia> from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates("2012-06-13"; misr_orbit1 = 995, misr_orbit2 = 72000)
(Date("2012-06-13"), Date("2013-07-01"), Date("2023-08-01"), "2012-06-13", "2013-07-01", "2023-08-01", "2012-06-13+2013-07-01+2023-08-01")
```

# Example 7:
```julia
julia> using Tools

julia> from_date, until_date, today_date, from_str, until_str, today_str, dates_str = make_dates("2012-06-13", "2010-01-01")
ERROR: make_dates: The ending date must be equal to or more recent than the starting date.
```
"""
function make_dates(
    from::Union{AbstractString, Nothing} = nothing,
    until::Union{AbstractString, Nothing} = nothing;
    misr_orbit1::Union{Integer, Nothing} = nothing,
    misr_orbit2::Union{Integer, Nothing} = nothing
    )::Tuple{Date, Date, Date, AbstractString, AbstractString, AbstractString, AbstractString}

    # Set the first date:
    if (from === nothing) | (from == "")
        if (misr_orbit1 === nothing) | (misr_orbit1 == 0)
            error("make_dates: Missing information for the `from` date.")
        else
            bool, misr_orbit1_string = is_valid_misr_orbit(misr_orbit1)
            if bool == true
                from_date, from_str = get_orbit_date(misr_orbit1)
                dates_str = from_str
            else
                error("make_dates: The keyword argument misr_orbit1 is invalid.")
            end
        end
    else
        from_date = Date(from, dateformat"yyyy-mm-dd")
        from_str = from
        dates_str = from
    end

    # Set the second date (repeat the first if no second date is specified):
    if (until === nothing) | (until == "")
        if (misr_orbit2 === nothing) | (misr_orbit2 == 0)
            until_date = from_date
            until_str = from_str
            dates_str = dates_str * '+' * until_str
        else
            bool, misr_orbit2_string = is_valid_misr_orbit(misr_orbit2)
            if bool == true
                until_date, until_str = get_orbit_date(misr_orbit2)
                dates_str = dates_str * '+' * until_str
            else
                error("make_dates: The keyword argument misr_orbit2 is invalid.")
            end
        end
    else
        until_date = Date(until, dateformat"yyyy-mm-dd")
        until_str = until
        dates_str = dates_str * '+' * until_str
    end
        
    # Check that `from_date` precedes or is equal to `until_date`:
    if until_date < from_date
        error("make_dates: The ending date must be equal to or more recent than the starting date.")
    end

    # Set the third date:
    today_date = Dates.today()
    today_str = Dates.format(today_date, "yyyy-mm-dd")
    dates_str = dates_str * '+' * today_str

    return from_date, until_date, today_date, from_str, until_str, today_str, dates_str

end

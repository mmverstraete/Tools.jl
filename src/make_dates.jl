"""
    dates, date1, date2, date3 = make_dates(strdate1, strdate2; misr_orbit1, misr_orbit2)

# Purpose(s):
* Generate the string composed of three dates used in MISRHR filenames.

# Positional argument(s):
* `strdate1::AbstractString = ""`: The string representation of the starting date of the period of interest, formatted as "yyyy-mm-dd".
* `strdate2::AbstractString = ""`: The string representation of the ending date of the period of interest, formatted as "yyyy-mm-dd".

# Keyword argument(s):
* `misr_orbit1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Orbit number.
* `misr_orbit2::Union{Integer, Nothing} = nothing`: The second MISR Orbit number.

# Return value(s):
* `dates::AbstractString`: The string needed to generate a MISRHR filename.
* `date1::Dates`: The first date.
* `date2::Dates`: The second date.
* `date3::Dates`: The third date.

# Algorithm:
* This function assembles a string composed of three concatenated dates, each formatted as `yyyy-mm-dd` and separated by the character `+`, where
- the first date concerns the start of the period of interest,
- the second date concerns the end of the period of interest, and
- the third date indicates the date of execution of this function.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* The first positional argument `strdate1` is always required, though it can be set to a null string if the first keyword argument is provided instead.
* The second positional argument `strdate2` is optional: if it is absent, its value is set to `strdate1`.
* Input values must be provided explicitly as either positional or keyword arguments to generate the output values:
- If the positional argument `strdate1` is provided, the keyword argument `misr_orbit1` is ignored.
- If the positional argument `strdate2` is provided, the keyword argument `misr_orbit2` is ignored.
- If the positional argument `strdate1` is not provided, the date of acquisition of the MISR Orbit given in the keyword argument `misr_orbit1` is used.
- If the positional argument `strdate2` is not provided, the date of acquisition of the MISR Orbit given in the keyword argument `misr_orbit2` is used.
- The third date is set to the date of execution of this function.
* The validity of the arguments is verified as needed, but keyword arguments are ignored if positional arguments are provided.

# Example 1:
```julia
julia> using Tools

julia> make_dates("2012-06-13")
("2012-06-13+2012-06-13+2023-07-11", Date("2012-06-13"), Date("2012-06-13"), Date("2023-07-11"))
```

# Example 2:
```julia
julia> using Tools

julia> make_dates("2012-06-13", "2014-06-28")
("2012-06-13+2014-06-28+2023-07-11", Date("2012-06-13"), Date("2014-06-28"), Date("2023-07-11"))
```

# Example 3:
```julia
julia> using Tools

julia> make_dates(; misr_orbit1 = 68050)
("2012-10-03+2012-10-03+2023-07-11", Date("2012-10-03"), Date("2012-10-03"), Date("2023-07-11"))
```

# Example 4:
```julia
julia> using Tools

julia> make_dates(; misr_orbit1 = 68050, misr_orbit2 = 72000)
("2012-10-03+2013-07-01+2023-07-11", Date("2012-10-03"), Date("2013-07-01"), Date("2023-07-11"))
```

# Example 5:
```julia
julia> using Tools

julia> make_dates("2012-06-13"; misr_orbit2 = 72000)
("2012-06-13+2013-07-01+2023-07-12", Date("2012-06-13"), Date("2013-07-01"), Date("2023-07-12"))
```
"""
function make_dates(
    strdate1::AbstractString = "",
    strdate2::AbstractString = "";
    misr_orbit1::Union{Integer, Nothing} = nothing,
    misr_orbit2::Union{Integer, Nothing} = nothing
    )::Tuple{AbstractString, Date, Date, Date}

    # Set the first date:
    if strdate1 != ""
        regexp = r"[1,2][0-9][0-9][0-9]-[0,1][0-9]-[0-3][0-9]"
        if occursin(regexp, strdate1) == true
            dates = strdate1
            orbit_date_string1 = strdate1
            date1 = Date(strdate1, dateformat"yyyy-mm-dd")
        else
            error("make_dates: The positional argument strdate1 is not properly formatted.")
        end
    else
        if misr_orbit1 !== nothing
            bool, misr_orbit1_string = is_valid_misr_orbit(misr_orbit1)
            if bool == true
                orbit_date1, orbit_date_string1 = get_orbit_date(misr_orbit1)
                dates = orbit_date_string1
                date1 = orbit_date1
            else
                error("make_dates: The keyword argument misr_orbit1 is invalid.")
            end
        else
            error("make_dates: Missing information for the first date.")
        end
    end

    # Set the second date (repeat the first if no second date is specified):
    if strdate2 != ""
        regexp = r"[1,2][0-9][0-9][0-9]-[0,1][0-9]-[0-3][0-9]"
        if occursin(regexp, strdate2) == true
            dates = dates * '+' * strdate2
            date2 = Date(strdate2, dateformat"yyyy-mm-dd")
        else
            error("make_dates: The positional argument strdate2 is not properly formatted.")
        end
    else
        if misr_orbit2 !== nothing
            bool, misr_orbit1_string = is_valid_misr_orbit(misr_orbit2)
            if bool == true
                orbit_date2, orbit_date_string2 = get_orbit_date(misr_orbit2)
                dates = dates * '+' * orbit_date_string2
                date2 = orbit_date2
            else
                error("make_dates: The keyword argument misr_orbit2 is invalid.")
            end
        else
            dates = dates * '+' * orbit_date_string1
            date2 = date1
        end
    end

    # Set the third date:
    date3 = Dates.today()
    dates = dates * '+' * Dates.format(Dates.today(), "yyyy-mm-dd")

    return dates, date1, date2, date3

end

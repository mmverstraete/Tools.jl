"""
    orbit_date, orbit_date_string = get_orbit_date(misr_orbit; fmt = fmt)

# Purpose(s):
Retrieve the date of acquisition of the specified MISR Orbit.

# Positional argument(s):
* `misr_orbit::Integer`: The MISR Orbit number.

# Keyword argument(s):
* `fmt::Union{AbstractString, Nothing} = nothing`: The formatting rule to apply to the output value `orbit_date_string`.

# Return value(s):
* `orbit_date::Date`: The date of acquisition of the specified MISR Orbit.
* `orbit_date_string::Date`: The string representation of the date of acquisition of the specified MISR Orbit.

# Algorithm:
* This function relies on function `jMtkOrbitToTimeRange.jl` of the JMtk15 package to determine the date (and time) when MISR started to acquire the specified Orbit. The output value `orbit_date_string` can be formatted as follows:
- If `fmt == ""` or is not specified (default), the separator character between the year, month and day values is a dash ('-').
- If `fmt == "Datapool"`, the separator character between the year, month and day values is a dot ('.'). This option may be useful to access MISR data from the ASDC Datapool.
- If `fmt == "Julian"`, the output value `orbit_date_string` contains the Julian day number corresponding to `orbit_date`. This option may be useful when plotting time series data.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s): None.

# Example 1:
```julia
julia> using Tools

julia> orbit_date, orbit_date_string = get_orbit_date(68050)
(Date("2012-10-03"), "2012-10-03")
```

# Example 2:
```julia
julia> using Tools

julia> orbit_date, orbit_date_string = get_orbit_date(68050; fmt = "Datapool")
(Date("2012-10-03"), "2012.10.03")
```

# Example 3:
```julia
julia> using Tools

julia> orbit_date, orbit_date_string = get_orbit_date(68050; fmt = "Julian")
(Date("2012-10-03"), "2.4562037994444445e6")
```
"""
function get_orbit_date(
    misr_orbit::Integer;
    fmt::Union{AbstractString, Nothing} = nothing
    )::Tuple{Dates.Date, AbstractString}

    start_time, end_time = jMtkOrbitToTimeRange(misr_orbit)

    orbit_date_string = String(start_time)
    orbit_date = DateTime(orbit_date_string, "yyyy-mm-ddTHH:MM:SSZ")
    orbit_date_string = Dates.format(DateTime(orbit_date), "yyyy-mm-dd")
    if fmt === "Datapool"
        orbit_date_string = replace(orbit_date_string, '-' => '.')
    elseif fmt === "Julian"
        orbit_date_string = string(datetime2julian(DateTime(orbit_date)))
    end

    return orbit_date, orbit_date_string

end

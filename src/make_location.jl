"""
    location = make_location(target;
        misr_path1 = misr_path1, misr_path2 = misr_path2,
        misr_orbit1 = misr_orbit1, misr_orbit2 = misr_orbit2,
        misr_block1 = misr_block1, misr_block2 = misr_block2,
        misr_site = misr_site)

# Purpose(s):
* Return a string describing the geographical area covered by the MISRHR product on the basis of the input arguments, in a format suitable for use in file names.

# Positional argument(s):
* `target:AbstractString`: An indicator to specify whether the return value should be formatted as a `MISR` (using the underscore character in the site name) or a `MISRHR` string (using the dash character in the site name), which is the default.

# Keyword argument(s):
* `misr_path1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Path number.
* `misr_path2::Union{Integer, Nothing} = nothing`: The last MISR Path number.
* `misr_orbit1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Orbit number.
* `misr_orbit2::Union{Integer, Nothing} = nothing`: The last MISR Orbit number.
* `misr_block1::Union{Integer, Nothing} = nothing`: The first (or only) MISR Block number.
* `misr_block2::Union{Integer, Nothing} = nothing`: The last MISR Block number.
* `misr_site::Union{AbstractString, Nothing} = nothing`: The MISR Local Mode Site name.

# Return value(s):
* `location::AbstractString`: The string describing the geographical area covered by the MISRHR product.

# Algorithm:
* This function generates the string `location` formatted as follows:

`location = [P1[-P2]][+O1[-O2]][+B1[-B2]][+S] | [NOLOC]`

where
- `P1 = "P" * misr_path1`, if `misr_path1` is provided.
- `P2 = "P" * misr_path2`, if `misr_path1` and `misr_path2` are both provided.
- `O1 = "O" * misr_orbit1`, if `misr_orbit1` is provided.
- `O2 = "O" * misr_orbit2`, if `misr_orbit1` and `misr_orbit2` are provided.
- `B1 = "B" * misr_block1`, if `misr_block1` is provided.
- `B2 = "B" * misr_block2`, if `misr_block1` and `misr_block2` are both provided.
- `S = misr_site`, if `misr_site` is provided.

and where

- Keywords that are not provided by the calling function are ignored.
- A keyword `X2` is ignored if `X1` is not also provided (both indicate a range for the corresponding keyword).
-The `misr_site` element is formatted with an underscore character if the positional argument `target` is specified as `MISR`, or with a dash character if the positional argument `target` is specified as `MISRHR` or absent (default value). See Example 4 below.
- If none of the MISR-specific keywords are provided, the output variable is set to `"NOLOC"`.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Notes: None.

# Example 1:
```julia
julia> using Tools

julia> location = make_location()
"NOLOC"
```

# Example 2:
```julia
julia> using Tools

julia> location = make_location(; misr_path1 = 168)
"P168"
```

# Example 3:
```julia
julia> using Tools

julia> location = make_location(; misr_path1 = 168, misr_orbit1 = 68050, misr_block1 = 110)
"P168+O068050+B110"
```

# Example 4:
```julia
julia> using Tools

julia> location = make_location(; misr_path1 = 168, misr_path2 = 170,
        misr_orbit1 = 68050, misr_orbit2 = 72000,
        misr_site = "skukuza")
"P168-P170+O068050-O072000+SITE-SKUKUZA"

julia> location = make_location("MISR"; misr_path1 = 168, misr_path2 = 170,
               misr_orbit1 = 68050, misr_orbit2 = 72000,
               misr_site = "skukuza")
"P168-P170+O068050-O072000+SITE_SKUKUZA"
```
"""
function make_location(
    target::AbstractString = "MISRHR";
    misr_path1::Union{Integer, Nothing} = nothing,
    misr_path2::Union{Integer, Nothing} = nothing,
    misr_orbit1::Union{Integer, Nothing} = nothing,
    misr_orbit2::Union{Integer, Nothing} = nothing,
    misr_block1::Union{Integer, Nothing} = nothing,
    misr_block2::Union{Integer, Nothing} = nothing,
    misr_site::Union{AbstractString, Nothing} = nothing
    )::AbstractString

    if (target != "MISR") & (target != "MISRHR")
        error("make_location: Positional argument target is invalid.")
    end

    # Initialize the local variable location:
    location = ""

    # Assemble the location string and set the output Tuple elements:
    if misr_path1 !== nothing
        bool, misr_path1_string = is_valid_misr_path(misr_path1)
        if bool != true
            error("make_location: Keyword argument misr_path1 is invalid.")
        end
        location = misr_path1_string
        if misr_path2 !== nothing
            bool, misr_path2_string = is_valid_misr_path(misr_path2)
            if bool != true
                error("make_location: Keyword argument misr_path2 is invalid.")
            end
            location = location * '-' * misr_path2_string
        end
    else
        if (misr_orbit1 !== nothing) |
            (misr_orbit2 !== nothing) |
            (misr_block1 !== nothing) |
            (misr_block2 !== nothing)
            error("make_location: If a MISR Orbit or Block number is specified, a first Path number must also be specified.")
        else
            location = "NOLOC"
            return location
        end
    end

    if misr_orbit1 !== nothing
        bool, misr_orbit1_string = is_valid_misr_orbit(misr_orbit1)
        if bool != true
            error("make_location: Keyword argument misr_orbit1 is invalid.")
        end
        location = location * '+' * misr_orbit1_string
        if misr_orbit2 !== nothing
            bool, misr_orbit2_string = is_valid_misr_orbit(misr_orbit2)
            if bool != true
                error("make_location: Keyword argument misr_orbit2 is invalid.")
            end
            location = location * '-' * misr_orbit2_string
        end
    end
    
    if misr_block1 !== nothing
        bool, misr_block1_string = is_valid_misr_block(misr_block1)
        if bool != true
            error("make_location: Keyword argument misr_block1 is invalid.")
        end
        location = location * '+' * misr_block1_string
        if misr_block2 !== nothing
            bool, misr_block2_string = is_valid_misr_block(misr_block2)
            if bool != true
                error("make_location: Keyword argument misr_block2 is invalid.")
            end
            location = location * '-' * misr_block2_string
        end
    end
    
    if misr_site !== nothing
        bool, misr_site_label = is_valid_misr_site(misr_site;
            cap = "TXT", sep = "_", sit = true)
        if bool != true
            error("make_location: Keyword argument misr_site is invalid.")
        end
        if target == "MISRHR"
            misr_site_label = replace(misr_site_label, "_" => "-")
        end
        location = location * '+' * misr_site_label
    end

    return location

end

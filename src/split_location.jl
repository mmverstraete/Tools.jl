"""
    misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site = split_location(location)

# Purpose(s):
* Split the argument `location` into its components.

# Positional argument(s):
* `location::AbstractString`: The `string` describing the geographical area covered by a MISR or MISR-HR deliverable product.

# Keyword argument(s): None.

# Return value(s):
* `misr_path1::Integer`: The first (or only) MISR Path number.
* `misr_path2::Integer`: The last MISR Path number.
* `misr_orbit1::Integer`: The first (or only) MISR Orbit number.
* `misr_orbit2::Integer`: The last MISR Orbit number.
* `misr_block1::Integer`: The first (or only) MISR Block number.
* `misr_block2::Integer`: The last MISR Block number.
* `misr_site::AbstractString`: The MISR Local Mode Site name.

# Algorithm:
* This function splits the `location` argument into its elements separated by the character `+`, and analyzes each element to retrieve the desired metadata.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* This function does not verify that the input argument `location` or the output values are valid, though the output values may be null or empty if the syntax of `location` cannot be interpreted.

# Example 1:
```julia
julia> using Tools

julia> location = "NOLOC"
"NOLOC"

julia> misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site = split_location(location)
(0, 0, 0, 0, 0, 0, "")
```

# Example 2:
```julia
julia> using Tools

julia> location = "P168+O068050+B110"
"P168+O068050+B110"

julia> misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site = split_location(location)
(168, 0, 68050, 0, 110, 0, "")
```

# Example 3:
```julia
julia> using Tools

julia> location = "P168-P170+O068050-O072000+B110-B115+SITE_SKUKUZA"
"P168-P170+O068050-O072000+B110-B115+SITE_SKUKUZA"

julia> misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site = split_location(location)
(168, 170, 68050, 72000, 110, 115, "SITE_SKUKUZA")
```
"""
function split_location(
    location::AbstractString
    )::Tuple{Integer, Integer, Integer, Integer, Integer, Integer, AbstractString}

    # Initialize the output variables to null values:
    misr_path1 = 0
    misr_path2 = 0
    misr_orbit1 = 0
    misr_orbit2 = 0
    misr_block1 = 0
    misr_block2 = 0
    misr_site = ""

    # Return if the location is "NOLOC":
    if (location == "NOLOC") | (location == "") | (location === nothing)
        return misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site
    end

    # Define a local working variable:
    loc = location

    # Split the `location` argument into its elements, separated by `+`:
    elems = split(loc, '+')
    n_elems = length(elems)

    # Loop over the location elements:
    for i_elem = 1:n_elems
        elem = elems[i_elem]

    # Retrieve MISR Path metadata if it exists:
        if elem[1] == 'P'
            regexp1 = r"P[0-9]{3}"
            regexp2 = r"P[0-9]{3}-P[0-9]{3}"
            if occursin(regexp2, elem) & (length(elem) == 9)
                misr_path1 = tryparse(Int, elem[2:4]; base = 10)
                misr_path2 = tryparse(Int, elem[7:9]; base = 10)
            elseif occursin(regexp1, elem) & (length(elem) == 4)
                misr_path1 = tryparse(Int, elem[2:4]; base = 10)
            end

    # Retrieve the MISR Orbit metadata if it exists:
        elseif elem[1] == 'O'
            regexp1 = r"O[0-9]{6}"
            regexp2 = r"O[0-9]{6}-O[0-9]{6}"
            if occursin(regexp2, elem) & (length(elem) == 15)
                misr_orbit1 = tryparse(Int, elem[2:7]; base = 10)
                misr_orbit2 = tryparse(Int, elem[10:15]; base = 10)
            elseif occursin(regexp1, elem) & (length(elem) == 7)
                misr_orbit1 = tryparse(Int, elem[2:7]; base = 10)
            end

    # Retrieve the MISR Block metadata if it exists:
        elseif elem[1] == 'B'
            regexp1 = r"B[0-9]{3}"
            regexp2 = r"B[0-9]{3}-B[0-9]{3}"
            if occursin(regexp2, elem) & (length(elem) == 9)
                misr_block1 = tryparse(Int, elem[2:4]; base = 10)
                misr_block2 = tryparse(Int, elem[7:9]; base = 10)
            elseif occursin(regexp1, elem) & (length(elem) == 4)
                misr_block1 = tryparse(Int, elem[2:4]; base = 10)
            end

    # Retrieve the MISR Local Site name if it exists:
        else
            misr_site = elem
        end
    end

    return misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site

end

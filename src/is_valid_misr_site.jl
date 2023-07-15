"""
    bool, misr_site_label = is_valid_misr_site(misr_site;
        cap = "", sep = "", sit = false)

# Purpose(s):
* Determine whether the specified `misr_site` is a valid MISR site name, and return an edited version of that site name, following the instructions provided by the optional input keywords.

# Positional argument(s):
* `misr_site::AbstractString`: The MISR site name.

# Optional keyword(s):
* `cap::AbstractString = ""`: The capitalization rule used to generate `misr_site_label`:
    - If `cap == ""` (default), the output value `misr_site_label` is set (unmodified) as the positional argument `misr_site`.
    - If `cap == "txt"`, the output value `misr_site_label` is set in all lower cases.
    - If `cap == "Txt"`, the output value `misr_site_label` is set in all lower cases but with the first letter of each distinct word in upper case.
    - If `cap == "TXT"`, the positional argument `misr_site` is set in all upper cases.
* `sep::AbstractString = ""`: The word separator character used to separate words in `misr_site_label`:
    - If `sep == ""` (default), the output value `misr_site_label` is set using the (unmodified) spelling of the positional argument `misr_site`.
    - If `sep == " "`, the words of the output value `misr_site_label` are separated by a blank space.
    - If `sep == "-"`, the words of the output value `misr_site_label` are separated by a dash character.
    - If `sep == "_"`, the words of the output value `misr_site_label` are separated by an underscore character.
* `sit::Bool = false`:
    - If `sit == false` (default), the output value `misr_site_label` is not further modified beyond the rules described above.
    - If `sit == true`, the output value `misr_site_label` is prepended with the identifier `site`, `Site`, or `SITE` capitalized in the same way as indicated by the keyword `cap` and separated with the character specified in the keyword `sep`.

# Return value(s):
* `bool::Bool`: Whether `misr_site` is valid or not.
* `misr_site_label::AbstractString`: The desired site label, properly formatted.

# Algorithm:
* This function lists the recognized MISR Local Mode Sites, checks whethe rthe positional argument `misr_site` is one of them, and returns a properly formatted version of that Local Mode Site following the instructions given in keyword arguments.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* The list `recognized_misr_sites` of recognized MISR Local Mode Site names at the start of the function definition contains a subset of the African sites that have been acquired in Local Mode. It can be expanded as needed to include other regions, but those labels should include neither blank spaces nor dash characters.
* If the positional argument `misr_site` is not recognized, or if one of the keyword arguments `cap` or `sep` is invalid, the return value `bool` is set to `false` and the `misr_site_label` contains an error message describing the exception condition.

# Example 1:
```julia
julia> using Tools

julia> bool, misr_site_label = is_valid_misr_site("egypt 1")
(true, "egypt 1")
```

# Example 2:
```julia
julia> using Tools

julia> bool, misr_site_label = is_valid_misr_site("egypt")
(false, "The positional argument misr_site is not recognized.")
```

# Example 3:
```julia
julia> using Tools

julia> bool, misr_site_label = is_valid_misr_site("egypt desert", cap = "Txt")
(true, "Egypt Desert")
```

# Example 4:
```julia
julia> using Tools

julia> bool, misr_site_label = is_valid_misr_site("egypt desert", cap = "TXT", sep = "_")
(true, "EGYPT_DESERT")
```

# Example 5:
```julia
julia> using Tools

julia> bool, misr_site_label = is_valid_misr_site("egypt desert", cap = "Text")
(false, "The input keyword cap is invalid.")
```

# Example 6:
```julia
julia> using Tools

julia> bool, misr_site_label = is_valid_misr_site("egypt desert", cap = "TXT", sep = ":")
(false, "The keyword argument sep is invalid.")
```

# Example 7:
```julia
julia> using Tools

julia> bool, misr_site_label = is_valid_misr_site("sKuKuZa", cap = "Txt")
(true, "Skukuza")
```
"""
function is_valid_misr_site(
    misr_site::AbstractString;
    cap::AbstractString = "",
    sep::AbstractString = "",
    sit::Bool = false
    )::Tuple{Bool, AbstractString}

    # Set the list of recognized MISR Local Mode site names, without the prefix "Site":
    recognized_misr_sites = [
        "Abidjan",
        "Algeria_3",
        "Algeria_5",
        "Athens",
        "Cairo",
        "Egypt_1",
        "Egypt_Desert",
        "Eridu",
        "Lagos",
        "Libya_1",
        "Libya_4",
        "Mauritania_2",
        "Nairobi",
        "Okavango",
        "Skukuza",
        "Sudd",
        "Tel_Aviv"]

    # Set a working copy of the list of recognized MISR Local Mode site names in lower cases, where the words are separated by blank spaces:
    working_misr_sites = lowercase.(recognized_misr_sites)
    working_misr_sites = replace.(working_misr_sites, "_" => " ")

    # Initialize the return value `misr_site_label` to the positional argument `misr_site` in lower case:
    misr_site_label = lowercase(misr_site)

    # Replace any underscore character by a blank space:
    misr_site_label = replace(misr_site_label, "_" => " ")

    # Strip the prefix "site ", is it is present, for the purpose of checking the validity of the positional argument `misr_site`:
    if (length(misr_site_label) > 5) & (misr_site_label[1] == "s")
        if (misr_site_label[1:5] == "site ")
            misr_site_label = misr_site_label[6:lastindex(misr_site_label)]
        end
    end

    # Check whether misr_site_label occurs in the list of recognized MISR Local Mode site names:
    if !(misr_site_label in working_misr_sites)
        bool = false
        misr_site_label = "The positional argument misr_site is not recognized."
        return bool, misr_site_label
    else
        bool = true
    end

    # Set the capitalization of the return value `misr_site_label` as prescribed by the keyword argument `cap`:
    if cap == ""
        if sit == true
            misr_site_label = "Site " * misr_site_label
        end
    elseif cap == "txt"
        if sit == true
            misr_site_label = "site " * misr_site_label
        end
    elseif cap == "Txt"
        misr_site_label = titlecase(misr_site_label; strict = true)
        if sit == true
            misr_site_label = "Site " * misr_site_label
        end
    elseif cap == "TXT"
        misr_site_label = uppercase(misr_site_label)
        if sit == true
            misr_site_label = "SITE " * misr_site_label
        end
    else
        bool = false
        misr_site_label = "The keyword argument cap is invalid."
        return bool, misr_site_label
    end

    # Set the word separator of the return value `misr_site_label` as prescribed by the keyword argument `sep`:
    if (sep == "") | (sep == " ")
        return bool, misr_site_label
    elseif sep == "-"
        misr_site_label = replace(misr_site_label, " " => "-")
        return bool, misr_site_label
    elseif sep == "_"
        misr_site_label = replace(misr_site_label, " " => "_")
        return bool, misr_site_label
    else
        bool = false
        misr_site_label = "The keyword argument sep is invalid."
        return bool, misr_site_label
    end

end

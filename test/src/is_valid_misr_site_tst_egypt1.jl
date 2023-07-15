"""
    bool, misr_site_label = is_valid_misr_site_tst_egypt1()

# Purpose(s):
* Generate the output of `is_valid_misr_site.jl` for testing purposes. Test egypt1: For a MISR Local Mode Site `egypt 1`.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_site` is valid or not.
* `misr_site_label::AbstractString`: The desired site label, properly formatted.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misr_site_tst_egypt1.jl")
is_valid_misr_site_tst_egypt1

julia> bool, misr_site_label = is_valid_misr_site_tst_egypt1();

julia> @test bool == true
Test Passed

julia> @test misr_site_label == "egypt 1"
Test Passed
```
"""
function is_valid_misr_site_tst_egypt1(
    )::Tuple{Bool, AbstractString}

    bool, misr_site_label = is_valid_misr_site("egypt 1")

    return bool, misr_site_label

end

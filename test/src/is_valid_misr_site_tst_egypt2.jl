"""
    bool, misr_site_label = is_valid_misr_site_tst_egypt2()

# Purpose(s):
* Generate the output of `is_valid_misr_site.jl` for testing purposes. Test egypt2: For a MISR Local Mode Site `egypt 1`.

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

julia> include(Tools_test * "is_valid_misr_site_tst_egypt2.jl")
is_valid_misr_site_tst_egypt2

julia> bool, misr_site_label = is_valid_misr_site_tst_egypt2();

julia> @test bool == false
Test Passed

julia> @test misr_site_label == "The positional argument misr_site is not recognized."
Test Passed
```
"""
function is_valid_misr_site_tst_egypt2(
    )::Tuple{Bool, AbstractString}

    bool, misr_site_label = is_valid_misr_site("egypt")

    return bool, misr_site_label

end

"""
    outcome = is_valid_misrhr_ftype_tst_map2()

# Purpose(s):
* Generate the output of `is_valid_misrhr_ftype.jl` for testing purposes. Test map2: For `ftype = "map"`.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Boolean`: Whether the argument `ftype` is a recognized MISRHR file type or not.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misrhr_ftype_tst_map2.jl")
is_valid_misrhr_ftype_tst_map2

julia> bool = is_valid_misrhr_ftype_tst_map2();

julia> @test bool == false
Test Passed
```
"""
function is_valid_misrhr_ftype_tst_map2(
    )::Bool

    ftype = "map"
    bool = is_valid_misrhr_ftype(ftype)

    return bool

end

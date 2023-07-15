"""
    bool = is_valid_ftype_tst_Caption()

# Purpose(s):
* Generate the output of `is_valid_ftype.jl` for testing purposes. Test Caption: For a file type of `Caption`.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Boolean`: Whether the argument `ftype` is a recognized file type or not.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_ftype_tst_Caption.jl")
is_valid_ftype_tst_Caption

julia> bool = is_valid_ftype_tst_Caption();

julia> @test bool == true
Test Passed
```
"""
function is_valid_ftype_tst_Caption(
    )::Bool

    bool = is_valid_ftype("Caption")

    return bool

end

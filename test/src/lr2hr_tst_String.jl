"""
    matrix_hr = lr2hr_tst_String()

# Purpose(s):
* Generate the output of `lr2hr.jl` for testing purposes. Test Color: For an array of color names.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `matrix_hr::AbstractMatrix`: A matrix `factor` times larger than `matrix_lr` in each dimension, where the elements have been duplicated.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> include(Tools_test * "lr2hr_tst_String.jl")
lr2hr_tst_String

julia> matrix_hr = lr2hr_tst_String();

julia> @test matrix_hr == [
        "white"   "white"   "white"   "black"   "black"   "black"
        "white"   "white"   "white"   "black"   "black"   "black"
        "white"   "white"   "white"   "black"   "black"   "black"
        "yellow"  "yellow"  "yellow"  "orange"  "orange"  "orange"
        "yellow"  "yellow"  "yellow"  "orange"  "orange"  "orange"
        "yellow"  "yellow"  "yellow"  "orange"  "orange"  "orange"
        "blue"    "blue"    "blue"    "green"   "green"   "green"
        "blue"    "blue"    "blue"    "green"   "green"   "green"
        "blue"    "blue"    "blue"    "green"   "green"   "green"]
Test Passed
```
"""
function lr2hr_tst_String(
    )::AbstractMatrix

    matrix_lr = ["white" "black"; "yellow" "orange"; "blue" "green"]
    matrix_hr = lr2hr(matrix_lr, 3)

    return matrix_hr

end

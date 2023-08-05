"""
    matrix_lr = hr2lr_tst_Rad()

# Purpose(s):
Generate the output of `hr2lr.jl` for testing purposes. Test Rad: For a Rad array.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `matrix_lr::AbstractMatrix{Real}`: A shrunk numeric array of the same type as `matrix_hr`, where each dimension is `factor` times smaller than the same dimension of `matrix_hr`.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "hr2lr_tst_Rad.jl")
hr2lr_tst_Rad

julia> matrix_lr = hr2lr_tst_Rad();

julia> @test matrix_lr == [
        350.0  400.0  450.0
        340.0  330.0  310.0]
Test Passed
```
"""
function hr2lr_tst_Rad(
    )::AbstractMatrix{<:Real}

    matrix_hr = [
        350.0   350.0   400.0   400.0   450.0   450.0
        350.0   350.0   400.0   400.0   450.0   450.0
        320.0   340.0   320.0   340.0   310.0   0.0
        360.0   0.0     0.0     0.0     0.0     0.0]

        matrix_lr = hr2lr(matrix_hr, 2, "Rad")

    return matrix_lr

end

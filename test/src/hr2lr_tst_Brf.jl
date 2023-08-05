"""
    matrix_lr = hr2lr_tst_Brf()

# Purpose(s):
Generate the output of `hr2lr.jl` for testing purposes. Test Brf: For a Brf array.

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

julia> include(Tools_test * "hr2lr_tst_Brf.jl")
hr2lr_tst_Brf

julia> matrix_lr = hr2lr_tst_Brf();

julia> @test matrix_lr == [
        0.12  0.14
        0.16  0.18
        0.25  0.0]
Test Passed
```
"""
function hr2lr_tst_Brf(
    )::AbstractMatrix{<:Real}

    matrix_hr = [
        0.12 0.12 0.14 9.99;
        0.12 0.12 0.14 0.14;
        0.16 0.16 9.99 9.99;
        9.99 9.99 9.99 0.18;
        0.21 0.23 9.99 9.99;
        0.27 0.29 9.99 9.99]

    matrix_lr = hr2lr(matrix_hr, 2, "Brf")

    return matrix_lr

end

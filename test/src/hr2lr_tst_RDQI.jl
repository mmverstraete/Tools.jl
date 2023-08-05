"""
    matrix_lr = hr2lr_tst_RDQI()

# Purpose(s):
Generate the output of `hr2lr.jl` for testing purposes. Test hr2lr_tst_RDQI: For a RDQI array.

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

julia> include(Tools_test * "hr2lr_tst_RDQI.jl")
hr2lr_tst_RDQI

julia> matrix_lr = hr2lr_tst_RDQI();

julia> @test matrix_lr == [
        0x00  0x01
        0x02  0x03]
Test Passed
```
"""
function hr2lr_tst_RDQI(
    )::AbstractMatrix{<:Real}

    matrix_hr = [
        0b00    0b00    0b00    0b01
        0b00    0b00    0b00    0b00
        0b00    0b10    0b00    0b11
        0b01    0b01    0b10    0b01]

        matrix_lr = hr2lr(matrix_hr, 2, "RDQI")

    return matrix_lr

end

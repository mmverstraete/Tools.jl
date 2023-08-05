"""
    matrix_lr = hr2lr_tst_LWCMask()

# Purpose(s):
Generate the output of `hr2lr.jl` for testing purposes. Test LWCMask: For a LWCMask array.

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

julia> include(Tools_test * "hr2lr_tst_LWCMask.jl")
hr2lr_tst_LWCMask

julia> matrix_lr = hr2lr_tst_LWCMask();

julia> @test matrix_lr == [
        0x01  0x02  0x03
        0x02  0x01  0x03
        0x03  0xfe  0x02
        0xfe  0xfe  0x01]
Test Passed
```
"""
function hr2lr_tst_LWCMask(
    )::AbstractMatrix{<:Real}

    matrix_hr = [
        0x01    0x01    0x02    0x02    0x03    0x03
        0x01    0x01    0x02    0x02    0x03    0x03
        0x01    0x02    0x01    0x01    0x02    0x01
        0x02    0x01    0x01    0x03    0x03    0x03
        0x01    0x02    0xfe    0xfd    0x02    0xfe
        0x03    0xfd    0xfe    0xfd    0x02    0x03
        0x03    0x03    0x01    0xfe    0x01    0x01
        0xfe    0xfe    0xfe    0xfd    0x03    0xfd]

        matrix_lr = hr2lr(matrix_hr, 2, "LWCMask")

    return matrix_lr

end

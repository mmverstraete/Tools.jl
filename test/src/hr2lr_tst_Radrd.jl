"""
    matrix_lr = hr2lr_tst_RadRd()

# Purpose(s):
Generate the output of `hr2lr.jl` for testing purposes. Test Radrd: For a RadRd array.

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

julia> include(Tools_test * "hr2lr_tst_Radrd.jl")
hr2lr_tst_Radrd

julia> matrix_lr = hr2lr_tst_Radrd();

julia> @test matrix_lr == [
        32752;
        32248;
        32192;
        32152;
        32191;;]
Test Passed
```
"""
function hr2lr_tst_Radrd(
    )::AbstractMatrix{<:Real}

    matrix_hr = [
        32000   32100   32200   32300
        32400   32500   32600   32700
        32800   32900   33000   33100
        33200   33300   33400   33500

        32100   32200   32300   32400
        32100   32200   32300   32400
        32100   32200   32300   32400
        32100   32200   32300   32400

        32100   32200   32300   65515
        32100   32200   32300   65515
        32100   32200   32300   65515
        32100   32200   65511   65515

        32100   32200   65511   65515
        32100   32200   65511   65515
        32100   32200   65511   65515
        32100   32200   65511   65515

        32200   32201   32203   65515
        32201   32200   65511   65515
        32202   32200   65511   65515
        32101   32200   65511   65515]

    matrix_lr = hr2lr(matrix_hr, 4, "RadRd")

    return matrix_lr

end

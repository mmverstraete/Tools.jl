"""
    matrix_hr = lr2hr_tst_Real()

# Purpose(s):
* Generate the output of `lr2hr.jl` for testing purposes. Test Real: Floating point matrix.

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

julia> include(Tools_test * "lr2hr_tst_Real.jl")
lr2hr_tst_Real

julia> matrix_hr = lr2hr_tst_Real();

julia> @test matrix_hr == [
        1.1  1.1  2.2  2.2  3.3  3.3  4.4  4.4
        1.1  1.1  2.2  2.2  3.3  3.3  4.4  4.4
        5.5  5.5  6.6  6.6  7.7  7.7  8.8  8.8
        5.5  5.5  6.6  6.6  7.7  7.7  8.8  8.8]
Test Passed
```
"""
function lr2hr_tst_Real(
    )::AbstractMatrix

    matrix_lr = [1.1 2.2 3.3 4.4; 5.5 6.6 7.7 8.8]
    matrix_hr = lr2hr(matrix_lr, 2)

    return matrix_hr

end

"""
    matrix_hr = lr2hr_tst_Integer()

# Purpose(s):
* Generate the output of `lr2hr.jl` for testing purposes. Test Integer: Integer matrix.

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

julia> include(Tools_test * "lr2hr_tst_Integer.jl")
lr2hr_tst_Integer

julia> matrix_hr = lr2hr_tst_Integer();
 
julia> @test matrix_hr == [
        1  1  2  2
        1  1  2  2
        3  3  4  4
        3  3  4  4]
Test Passed
```
"""
function lr2hr_tst_Integer(
    )::AbstractMatrix

    matrix_lr = [1 2; 3 4]
    matrix_hr = lr2hr(matrix_lr, 2)

    return matrix_hr

end

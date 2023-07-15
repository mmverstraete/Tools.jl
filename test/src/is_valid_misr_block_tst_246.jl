"""
    bool, misr_block_string = is_valid_misr_block_tst_246()

# Purpose(s):
* Generate the output of `is_valid_misr_block.jl` for testing purposes. Test 246: For a MISR Block number 246.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_block` is a valid MISR Block number or not.
* `misr_block_string::AbstractString`: The string version of the MISR Block number, prepended with the letter `'B'`.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misr_block_tst_246.jl")
is_valid_misr_block_tst_246

julia> bool, misr_block_string = is_valid_misr_block_tst_246();

julia> @test bool == false
Test Passed

julia> @test misr_block_string == ""
Test Passed
```
"""
function is_valid_misr_block_tst_246()
    misr_block = 246
    bool, misr_block_string = is_valid_misr_block(misr_block)

    return bool, misr_block_string

end

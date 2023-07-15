"""
    bool, misr_block_string = is_valid_misr_block_tst_168()

# Purpose(s):
* Generate the output of `is_valid_misr_block.jl` for testing purposes. Test 168: For a MISR Block number 168.

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

julia> include(Tools_test * "is_valid_misr_block_tst_168.jl")
is_valid_misr_block_tst_168

julia> bool, misr_block_string = is_valid_misr_block_tst_168();

julia> @test bool == true
Test Passed

julia> @test misr_block_string == "B168"
Test Passed
```
"""
function is_valid_misr_block_tst_168()
    misr_block = 168
    bool, misr_block_string = is_valid_misr_block(misr_block)

    return bool, misr_block_string

end

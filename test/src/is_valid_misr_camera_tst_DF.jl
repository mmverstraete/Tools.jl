"""
    bool = is_valid_misr_camera_tst_DF()

# Purpose(s):
* Generate the output of `is_valid_misr_camera.jl` for testing purposes. Test DF: For the MISR camera DF.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `bool::Bool`: Whether `misr_camera` is valid or not.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "is_valid_misr_camera_tst_DF.jl")
is_valid_misr_camera_tst_DF

julia> bool = is_valid_misr_camera_tst_DF();

julia> @test bool == true
Test Passed
```
"""
function is_valid_misr_camera_tst_DF()
    misr_camera = "DF"
    bool = is_valid_misr_camera(misr_camera)

    return bool

end

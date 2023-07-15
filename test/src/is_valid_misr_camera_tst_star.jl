"""
    bool = is_valid_misr_camera_tst_star()

# Purpose(s):
* Generate the output of `is_valid_misr_camera.jl` for testing purposes. Test star: For the MISR camera specification "*" (all 9 cameras).

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

julia> include(Tools_test * "is_valid_misr_camera_tst_star.jl")
is_valid_misr_camera_tst_star

julia> bool = is_valid_misr_camera_tst_star();

julia> @test bool == false
Test Passed
```
"""
function is_valid_misr_camera_tst_star()
    misr_camera = "*"
    bool = is_valid_misr_camera(misr_camera)

    return bool

end

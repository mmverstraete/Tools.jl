"""
    misr_version = set_misr_version_tst_AGP()

# Purpose:
Generate the output of `set_misr_version.jl` for testing purposes. Test AGP: For a MISR AGP data product.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `misr_version::AbstractString`: The current version label of the specified MISR, MISR-HR or post-processing product acronym.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "set_misr_version_tst_AGP.jl")
set_misr_version_tst_AGP

julia> misr_version = set_misr_version_tst_AGP();

julia> @test misr_version == "F01_24"
Test Passed
```
"""
function set_misr_version_tst_AGP()
    misr_prdct = "AGP"
    misr_version = set_misr_version(misr_prdct)

    return misr_version

end

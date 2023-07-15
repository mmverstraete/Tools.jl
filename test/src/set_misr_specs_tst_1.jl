"""
    misr_specs = set_misr_specs_tst_1()

# Purpose(s):
Generate the output of `set_misr_specs.jl` for testing purposes.

# Positional argument(s): None.

# Keyword argument(s): None.

# Return value(s):
* `misr_specs::Tuple`: Key technical specifications of the MISR instrument.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools

julia> using Test

julia> include(Tools_test * "set_misr_specs_tst_1.jl")
set_misr_specs_tst_1

julia> misr_specs = set_misr_specs_tst_1();

julia> @test misr_specs.nmodes == 2
Test Passed

julia> @test misr_specs.mode_names == ["GM", "LM"]
Test Passed

julia> @test misr_specs.ncameras == 9
Test Passed

julia> @test misr_specs.camera_names == ["DF", "CF", "BF", "AF", "AN", "AA", "BA", "CA", "DA"]
Test Passed

julia> @test misr_specs.camera_ids == [1:9]
Test Passed

julia> @test misr_specs.camera_angles == [70.3, 60.2, 45.7, 26.2, 0.1, 26.2, 45.7, 60.2, 70.6]
Test Passed

julia> @test misr_specs.nbands == 4
Test Passed

julia> @test misr_specs.band_names == ["Blue", "Green", "Red", "NIR"]
Test Passed

julia> @test misr_specs.band_ids == [1:4]
Test Passed

julia> @test misr_specs.band_positions == [446.4, 557.5, 671.7, 866.4]
Test Passed

julia> @test misr_specs.nchannels == 36
Test Passed

julia> @test misr_specs.channel_names == [
        "DF_Blue", "DF_Green", "DF_Red", "DF_NIR",
        "CF_Blue", "CF_Green", "CF_Red", "CF_NIR",
        "BF_Blue", "BF_Green", "BF_Red", "BF_NIR",
        "AF_Blue", "AF_Green", "AF_Red", "AF_NIR",
        "AN_Blue", "AN_Green", "AN_Red", "AN_NIR",
        "AA_Blue", "AA_Green", "AA_Red", "AA_NIR",
        "BA_Blue", "BA_Green", "BA_Red", "BA_NIR",
        "CA_Blue", "CA_Green", "CA_Red", "CA_NIR",
        "DA_Blue", "DA_Green", "DA_Red", "DA_NIR"]
Test Passed

julia> @test misr_specs.channel_ids == [1:36]
Test Passed
```
"""
function set_misr_specs_tst_1(
    )::NamedTuple{(:nmodes, :mode_names, :ncameras, :camera_names, :camera_ids, :camera_angles, :nbands, :band_names, :band_ids, :band_positions, :nchannels, :channel_names, :channel_ids), Tuple{Int64, Vector{String}, Int64, Vector{String}, Vector{UnitRange{Int64}}, Vector{Float64}, Int64, Vector{String}, Vector{UnitRange{Int64}}, Vector{Float64}, Int64, Vector{String}, Vector{UnitRange{Int64}}}}

    misr_specs = set_misr_specs()

    return misr_specs

end

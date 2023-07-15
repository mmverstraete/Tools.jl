"""
    using Tools

# Purpose(s):
* Provide access to MISRHR Tools functions.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Example 1:
```julia
julia> using Tools
[ Info: Precompiling Tools [2aed01e1-a8db-4e67-96fc-9ccdf593ebce]
```
"""
module Tools

# Define required packages:
using Dates
using JMtk15
using StaticArrays
using Statistics

# Define the default root directories for the project :
const Tools_root = pkgdir(Tools)
export Tools_root
const Tools_src = Tools_root * "/src/"
export Tools_src
const Tools_test = Tools_root * "/test/src/"
export Tools_test
# const Tools_docs = Tools_root * "/docs/"
# export Tools_docs

# Include and export functions:
include(Tools_src * "get_orbit_date.jl")
export get_orbit_date
include(Tools_src * "is_from_misr_path.jl")
export is_from_misr_path
include(Tools_src * "is_valid_ftype.jl")
export is_valid_ftype
include(Tools_src * "is_valid_misr_band.jl")
export is_valid_misr_band
include(Tools_src * "is_valid_misr_block.jl")
export is_valid_misr_block
include(Tools_src * "is_valid_misr_camera.jl")
export is_valid_misr_camera
include(Tools_src * "is_valid_misr_orbit.jl")
export is_valid_misr_orbit
include(Tools_src * "is_valid_misr_path.jl")
export is_valid_misr_path
include(Tools_src * "is_valid_misr_prdct.jl")
export is_valid_misr_prdct
include(Tools_src * "is_valid_misr_resolution.jl")
export is_valid_misr_resolution
include(Tools_src * "is_valid_misr_site.jl")
export is_valid_misr_site
include(Tools_src * "is_valid_misr_subprdct.jl")
export is_valid_misr_subprdct
include(Tools_src * "is_valid_misrhr_ftype.jl")
export is_valid_misrhr_ftype
include(Tools_src * "is_valid_misrhr_prdct.jl")
export is_valid_misrhr_prdct
include(Tools_src * "is_valid_misrhr_subprdct.jl")
export is_valid_misrhr_subprdct
include(Tools_src * "make_dates.jl")
export make_dates
include(Tools_src * "make_location.jl")
export make_location
include(Tools_src * "make_misr_fname.jl")
export make_misr_fname
include(Tools_src * "make_misr_fpath.jl")
export make_misr_fpath
include(Tools_src * "make_misr_fspec.jl")
export make_misr_fspec
include(Tools_src * "make_versions.jl")
export make_versions
include(Tools_src * "set_misr_resol.jl")
export set_misr_resol
include(Tools_src * "set_misr_specs.jl")
export set_misr_specs
include(Tools_src * "set_misr_version.jl")
export set_misr_version
include(Tools_src * "make_misrhr_fname.jl")
export make_misrhr_fname
include(Tools_src * "set_misrhr_version.jl")
export set_misrhr_version
include(Tools_src * "set_mroots.jl")
export set_mroots
include(Tools_src * "split_location.jl")
export split_location
include(Tools_src * "split_misr_fname.jl")
export split_misr_fname
include(Tools_src * "split_misr_fpath.jl")
export split_misr_fpath
include(Tools_src * "split_misrhr_fname.jl")
export split_misrhr_fname
include(Tools_src * "split_misrhr_fpath.jl")
export split_misrhr_fpath



end

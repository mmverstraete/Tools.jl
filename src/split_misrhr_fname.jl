"""
    ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id = split_misrhr_fname(misrhr_fname)

# Purpose(s):
* Split the name `misrhr_fname` of a MISRHR file and return the metadata information.

# Positional argument(s):
* `misrhr_fname::AbstractString`: The name of a MISRHR file.

# Keyword argument(s): None.

# Return value(s):
* `ftype_id::AbstractString`: The file type.
* `prdct_id::AbstractString`: The main product acronym .
* `subprdct_id::AbstractString`: The subproduct acronym.
* `qualifier_id::AbstractString`: The qualifier of the subproduct or of the processing applied.
* `resolution_id::Integer`: The spatial resolution of the product (in m).
* `misr_path1_id::Integer`: The first (or only) MISR Path number.
* `misr_path2_id::Integer`: The last MISR Path number.
* `misr_orbit1_id::Integer`: The first (or only) MISR Orbit number.
* `misr_orbit2_id::Integer`: The last MISR Orbit number.
* `misr_block1_id::Integer`: The first (or only) MISR Block number.
* `misr_block2_id::Integer`: The last MISR Block number.
* `misr_site::AbstractString`: The MISR Local Mode Site name.
* `strdate1::AbstractString`: The string representation of the starting date of the period of interest, formatted as "yyyy-mm-dd".
* `strdate2::AbstractString`: The string representation of the ending date of the period of interest, formatted as "yyyy-mm-dd".
* `misr_version::AbstractString`: The version label for the main MISR data product.
* `misrhr_version::AbstractString`: The version label for the MISRHR processing system.
* `ext::AbstractString`: The file extension.

# Algorithm:
* This function discards the directory name, if it is present in the input file specification `misrhr_fname`, and disassembles that  filename to extract the relevant metadata items for that file. Output valuess that are not found in the filename are returned as empty strings.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).



------------------------

of file contained in the file: one of
    `["Caption", "Data", "Hist", "Log", "Map", "Save", "Scatt", "TS"]`.
: one of `["AGP", "L1BROW", "L1GMP", "L1REGM", "L1RELM", "L1RTGM", "L1RTLM", "L1RCCM", "L2TALBEDO", "L2TCLASS", "L2TCLOUD", "L2TSTEREO", "L2AERO", "L2LAND", "RCCMmvr", "L1RTGMmvr", "L1B3", "BRF", "RPV", "TIP"]`.

MISR or MISR-HR subproduct contained in this file: one of the recognized subproducts defined for the `prdct_id` defined above.
* `qualifier_id::AbstractString`: The string of optional indicators of processing conditions.
* `location_id::AbstractString}}`: The location information.
* `from_date_id::Dates.TimeType`: The date of the original MISR data acquisition, or the date of the start of the period relevant to the content of the file.
* `until_date_id::Dates.TimeType`: The date of the end of the period relevant to the content of the file, if `date1_id` is set.
* `proc_date_id::Dates.TimeType`: The date of creation of the deliverable product file `misrhr_fname`.
* `misr_version_id::AbstractString`: The MISR Version identifier.
* `misrhr_version_id::AbstractString`: The MISR-HR Version identifier.
* `post_version_id::AbstractString`: The post-processing Version identifier.
* `ext_id::AbstractString`: The file extension.



following elements: type of product file, the product acronym, the subproduct name, the subproduct qualifier, the location string, the spatial resolution, the initial date of acquisition, the final date of acquisition, the processing date, the MISR Version identifier, the MISR-HR Version identifier, the post-processing Version identifier, and the file extension.

------------------------




# Note(s):
* This function accepts only properly formatted MISRHR filenames as input; all output values are set to null strings if that is not the case.
* This function disassembles a MISRHR filename into its components but does not retrieve exactly the same information required by function `make_misrhr_fname.jl` to create the filename in the first place: Indeed, the latter may need the keyword arguments `misr_camera` and `misr_band` to determine the default spatial resolution of the product, though these components do not figure in the filename itself. Conversely, this function returns the date of creation of the file, though it is not required to generate the filename, as it is generated dynamically.


# Example 1:
```julia
julia> using Tools

julia> misrhr_fname = "Data_L1RCCMmvr_cldm_main_R1100_P168+O068050+B110_2012-10-03+2012-10-03+2023-07-13_F04-0025+v3.0.0.nc"
"Data_L1RCCMmvr_cldm_main_R1100_P168+O068050+B110_2012-10-03+2012-10-03+2023-07-13_F04-0025+v3.0.0.nc"

julia> ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id = split_misrhr_fname(misrhr_fname)
("Data", "L1RCCMmvr", "cldm", "main", 1100, 168, 0, 68050, 0, 110, 0, "", "2012-10-03", "2012-10-03", "2023-07-13", "F04-0025", "v3.0.0", ".nc")
```

# Example 2:
```julia
julia> using Tools

julia> misrhr_fname = "Map_L1RTLM_refl_test_R275_P168+O060000-O070000+B110+SITE-SKUKUZA_2011-03-30+2013-02-14+2023-07-14_F03-0024+v3.0.0.png"
"Map_L1RTLM_refl_test_R275_P168+O060000-O070000+B110+SITE-SKUKUZA_2011-03-30+2013-02-14+2023-07-14_F03-0024+v3.0.0.png"

julia> ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id = split_misrhr_fname(misrhr_fname)
("Map", "L1RTLM", "refl", "test", 275, 168, 0, 60000, 70000, 110, 0, "SITE-SKUKUZA", "2011-03-30", "2013-02-14", "2023-07-14", "F03-0024", "v3.0.0", ".png")
```
"""
function split_misrhr_fname(
    misrhr_fname::AbstractString,
    )::Tuple{AbstractString,
        AbstractString,
        AbstractString,
        AbstractString,
        Integer,
        Integer,
        Integer,
        Integer,
        Integer,
        Integer,
        Integer,
        AbstractString,
        AbstractString,
        AbstractString,
        AbstractString,
        AbstractString,
        AbstractString,
        AbstractString}

    # Initialize the output values:
    ftype_id = ""
    prdct_id = ""
    subprdct_id = ""
    qualifier_id = ""
    resolution_id = 0
    misr_path1_id = 0
    misr_path2_id = 0
    misr_orbit1_id = 0
    misr_orbit2_id = 0
    misr_block1_id = 0
    misr_block2_id = 0
    misr_site_id = ""
    strdate1_id = ""
    strdate2_id = ""
    proc_date_id = ""
    misr_version_id = ""
    misrhr_version_id = ""
    ext_id = ""

    # Remove the path name, if any is present:
    (fpath, fname) = splitdir(misrhr_fname)

    # Retrieve the file extension:
    (fname, ext_id) = splitext(fname)

    # Split the filename into its components:
    parts = split(fname, "_")
    nparts = length(parts)
    if nparts != 8
        return ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id
    end

    ftype_id = string(parts[1])
    prdct_id = string(parts[2])
    subprdct_id = string(parts[3])
    qualifier_id = string(parts[4])
    res_id = string(parts[5])
    resolution_id = parse(Int, res_id[2:length(res_id)], base = 10)
    location_id = string(parts[6])
    dates_id = string(parts[7])
    versions_id = string(parts[8])

    # Retrieve the location information:
    misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id = split_location(location_id)

    # Retrieve the date information:
    parts = split(dates_id, '+')
    strdate1_id = string(parts[1])
    strdate2_id = string(parts[2])
    proc_date_id = string(parts[3])
    
    # Retrieve the versioning information:
    parts = split(versions_id, '+')
    misr_version_id = string(parts[1])
    misrhr_version_id = string(parts[2])

    return ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id

end

"""
    misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id = split_misr_fname(misr_fname)

# Purpose(s):
* Split the name `misr_fname` of a file containing MISR data and return the MISR data product name `misr_product_id`, the MISR data product acronym `misr_prdct_id`, the MISR Mode `misr_mode_id`, the MISR Path number `misr_path_id`, the MISR Orbit number `misr_orbit_id`, MISR Camera name `misr_camera_id`, the MISR Site name `misr_site_id`, the MISR Version identifier `misr_version_id` and the file extension `ext_id`.

# Positional argument(s):
* `misr_fname::AbstractString`: The name of a MISR data product file.

# Keyword argument(s): None.

# Return value(s):
* `misr_product_id::AbstractString`: The full MISR data product name.
* `misr_prdct_id::AbstractString`: The MISR data product acronym.
* `misr_mode_id::AbstractString`: The MISR Mode.
* `misr_path_id::Integer`: The MISR Path number.
* `misr_orbit_id::Integer`: The MISR Orbit number.
* `misr_camera_id::AbstractString`: The MISR Camera name.
* `misr_site_id::AbstractString`: The MISR Local Mode site name.
* `misr_version_id::AbstractString`: The MISR Version identifier.
* `ext_id::AbstractString`: The file extension.

# Algorithm:
* This function discards a directory name, if any is present in the input file specification `misr_fname`, and disassembles the filename to extract the relevant metadata items for that file. Output values that are not retrieved from the filename are returned as empty strings.

# Reference(s):
* The MISRHR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* This function accepts only properly formatted MISR filenames as input; all output values are set to null strings if that is not the case.
* Return values that are not appropriate for the given file name are set to null strings.

# Example 1:
```julia
julia> using Tools

julia> misr_fname = "MISR_AM1_AGP_P168_F01_24.hdf"
"MISR_AM1_AGP_P168_F01_24.hdf"

julia> misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id = split_misr_fname(misr_fname)
("AGP", "AGP", "", 168, 0, "", "", "F01_24", ".hdf")
```

# Example 2:
```julia
julia> using Tools

julia> misr_fname = "MISR_AM1_GRP_RCCM_GM_P168_O068050_CF_F04_0025.hdf"
"MISR_AM1_GRP_RCCM_GM_P168_O068050_CF_F04_0025.hdf"

julia> misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id = split_misr_fname(misr_fname)
("GRP_RCCM_GM", "L1RCCM", "GM", 168, 68050, "CF", "", "F04_0025", ".hdf")
```
"""
function split_misr_fname(
    misr_fname::AbstractString,
    )::Tuple{AbstractString, AbstractString, AbstractString, Integer, Integer, AbstractString, AbstractString, AbstractString, AbstractString}

    # Initialize the output values:
    misr_product_id = ""
    misr_prdct_id = ""
    misr_mode_id = ""
    misr_path_id = 0
    misr_orbit_id = 0
    misr_camera_id = ""
    misr_site_id = ""
    misr_version_id = ""
    ext_id = ""

    # Remove the path name, if any is present:
    (fpath, fname) = splitdir(misr_fname)

    # Check that the header 'MISR_AM1_' is present:
    regexp = r"^MISR_AM1_"
    if occursin(regexp, fname) == false
        return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
    else
        fname = fname[10:length(fname)]
    end

    # Retrieve the file extension:
    (fname, ext_id) = splitext(fname)

    # Split the filename into its components:
    parts = split(fname, "_")
    nparts = length(parts)

    # Analyze the results:
    # ------------------------------------------------------ AGP
    if parts[1] == "AGP"
        if nparts != 4
            return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
        end
        misr_product_id = "AGP"
        misr_prdct_id = "AGP"
        misr_mode_id = ""
        regexp = r"P[0-9][0-9][0-9]"
        if occursin(regexp, parts[2])
            mp = parts[2][2:4]
            misr_path_id = parse(Int, mp)
        end
        part34 = parts[3] * '_' * parts[4]
        regexp = r"F[0-9][0-9]_[0-9][0-9]"
        if occursin(regexp, part34)
            misr_version_id = part34
        end
    # ------------------------------------------------------ GP_GMP
    elseif parts[1] == "GP"
        if nparts != 6
            return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
        end
        if parts[2] == "GMP"
            misr_product_id = "GP_GMP"
            misr_prdct_id = "L1GMP"
            misr_mode_id = ""
            regexp = r"P[0-9][0-9][0-9]"
            if occursin(regexp, parts[3])
                mp = parts[3][2:4]
                misr_path_id = parse(Int, mp)
            end
            regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
            if occursin(regexp, parts[4])
                mo = parts[4][2:7]
                misr_orbit_id = parse(Int, mo)
            end
            part56 = parts[5] * '_' * parts[6]
            regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
            if occursin(regexp, part56)
                misr_version_id = part56
            end
        else
            return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
        end
    # ------------------------------------------------------ GRP
    elseif parts[1] == "GRP"
        if nparts < 8
            return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
        end
    # ------------------------------------------------------ GRP_ELLIPSOID
        if parts[2] == "ELLIPSOID"
    # ------------------------------------------------------ GRP_ELLIPSOID_BR_GM
            if (parts[3] == "BR") & (parts[4] == "GM")
                if nparts != 9
                    return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
                end
                misr_product_id = "GRP_ELLIPSOID_BR_GM"
                misr_prdct_id = "L1BROW"
                misr_mode_id = "GM"
                regexp = r"P[0-9][0-9][0-9]"
                if occursin(regexp, parts[5])
                    mp = parts[5][2:4]
                    misr_path_id = parse(Int, mp)
                end
                regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
                if occursin(regexp, parts[6])
                    mo = parts[6][2:7]
                    misr_orbit_id = parse(Int, mo)
                end
                regexp = r"[A-D][A, F, N]"
                if occursin(regexp, parts[7])
                    mc = parts[7][1:2]
                    misr_camera_id = mc
                end
                part89 = parts[8] * '_' * parts[9]
                regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
                if occursin(regexp, part89)
                    misr_version_id = part89
                end
    # ------------------------------------------------------ GRP_ELLIPSOID_GM
            elseif parts[3] == "GM"
                if nparts != 8
                    return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
                end
                misr_product_id = "GRP_ELLIPSOID_GM"
                misr_prdct_id = "L1REGM"
                misr_mode_id = "GM"
                regexp = r"P[0-9][0-9][0-9]"
                if occursin(regexp, parts[4])
                    mp = parts[4][2:4]
                    misr_path_id = parse(Int, mp)
                end
                regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
                if occursin(regexp, parts[5])
                    mo = parts[5][2:7]
                    misr_orbit_id = parse(Int, mo)
                end
                regexp = r"[A-D][A, F, N]"
                if occursin(regexp, parts[6])
                    mc = parts[6][1:2]
                    misr_camera_id = mc
                end
                part78 = parts[7] * '_' * parts[8]
                regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
                if occursin(regexp, part78)
                    misr_version_id = part78
                end
    # ------------------------------------------------------ GRP_ELLIPSOID_LM
            elseif parts[3] == "LM"
                if nparts < 10
                    return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
                end
                misr_product_id = "GRP_ELLIPSOID_LM"
                misr_prdct_id = "L1RELM"
                misr_mode_id = "LM"
                regexp = r"P[0-9][0-9][0-9]"
                if occursin(regexp, parts[4])
                    mp = parts[4][2:4]
                    misr_path_id = parse(Int, mp)
                end
                regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
                if occursin(regexp, parts[5])
                    mo = parts[5][2:7]
                    misr_orbit_id = parse(Int, mo)
                end
                regexp = r"[A-D][A, F, N]"
                if occursin(regexp, parts[6])
                    mc = parts[6][1:2]
                    misr_camera_id = mc
                end
                partv = parts[nparts - 1] * '_' * parts[nparts]
                regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
                if occursin(regexp, partv)
                    misr_version_id = partv
                end
                if parts[7] == "SITE"
                    misr_site_id = parts[8]
                    if nparts > 10
                        for i = 9:nparts - 2
                            misr_site_id = misr_site_id * '_' * parts[i]
                        end
                    end
                end
            else
                return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
            end
    # ------------------------------------------------------ GRP_TERRAIN
        elseif parts[2] == "TERRAIN"
    # ------------------------------------------------------ GRP_TERRAIN_GM
            if parts[3] == "GM"
                if nparts != 8
                    return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
                end
                misr_product_id = "GRP_TERRAIN_GM"
                misr_prdct_id = "L1RTGM"
                misr_mode_id = "GM"
                regexp = r"P[0-9][0-9][0-9]"
                if occursin(regexp, parts[4])
                    mp = parts[4][2:4]
                    misr_path_id = parse(Int, mp)
                end
                regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
                if occursin(regexp, parts[5])
                    mo = parts[5][2:7]
                    misr_orbit_id = parse(Int, mo)
                end
                regexp = r"[A-D][A, F, N]"
                if occursin(regexp, parts[6])
                    mc = parts[6][1:2]
                    misr_camera_id = mc
                end
                part78 = parts[7] * '_' * parts[8]
                regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
                if occursin(regexp, part78)
                    misr_version_id = part78
                end
    # ------------------------------------------------------ GRP_TERRAIN_LM
            elseif parts[3] == "LM"
                if nparts < 10
                    return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
                end
                misr_product_id = "GRP_TERRAIN_LM"
                misr_prdct_id = "L1RTLM"
                misr_mode_id = "LM"
                regexp = r"P[0-9][0-9][0-9]"
                if occursin(regexp, parts[4])
                    mp = parts[4][2:4]
                    misr_path_id = parse(Int, mp)
                end
                regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
                if occursin(regexp, parts[5])
                    mo = parts[5][2:7]
                    misr_orbit_id = parse(Int, mo)
                end
                regexp = r"[A-D][A, F, N]"
                if occursin(regexp, parts[6])
                    mc = parts[6][1:2]
                    misr_camera_id = mc
                end
                partv = parts[nparts - 1] * '_' * parts[nparts]
                regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
                if occursin(regexp, partv)
                    misr_version_id = partv
                end
                if parts[7] == "SITE"
                    misr_site_id = parts[8]
                    if nparts > 10
                        for i = 9:nparts - 2
                            misr_site_id = misr_site_id * '_' * parts[i]
                        end
                    end
                end
            else
                return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
            end
    # ------------------------------------------------------ GRP_RCCM_GM
        elseif (parts[2] == "RCCM") & (parts[3] == "GM")
            if nparts != 8
                return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
            end
            misr_product_id = "GRP_RCCM_GM"
            misr_prdct_id = "L1RCCM"
            misr_mode_id = "GM"
            regexp = r"P[0-9][0-9][0-9]"
            if occursin(regexp, parts[4])
                mp = parts[4][2:4]
                misr_path_id = parse(Int, mp)
            end
            regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
            if occursin(regexp, parts[5])
                mo = parts[5][2:7]
                misr_orbit_id = parse(Int, mo)
            end
            regexp = r"[A-D][A, F, N]"
            if occursin(regexp, parts[6])
                mc = parts[6][1:2]
                misr_camera_id = mc
            end
            part78 = parts[7] * '_' * parts[8]
            regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
            if occursin(regexp, part78)
                misr_version_id = part78
            end
        else
            return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
        end
    # ------------------------------------------------------ TC
    elseif parts[1] == "TC"
    # ------------------------------------------------------ TC_ALBEDO
        if parts[2] == "ALBEDO"
            if nparts != 6
                return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
            end
            misr_product_id = "TC_ALBEDO"
            misr_prdct_id = "L2TALBEDO"
            regexp = r"P[0-9][0-9][0-9]"
            if occursin(regexp, parts[3])
                mp = parts[3][2:4]
                misr_path_id = parse(Int, mp)
            end
            regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
            if occursin(regexp, parts[4])
                mo = parts[4][2:7]
                misr_orbit_id = parse(Int, mo)
            end
            part56 = parts[5] * '_' * parts[6]
            regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
            if occursin(regexp, part56)
                misr_version_id = part56
            end
    # ------------------------------------------------------ TC_CLASSIFIERS
        elseif parts[2] == "CLASSIFIERS"
            if nparts != 6
                return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
            end
            misr_product_id = "TC_CLASSIFIERS"
            misr_prdct_id = "L2TCLASS"
            regexp = r"P[0-9][0-9][0-9]"
            if occursin(regexp, parts[3])
                mp = parts[3][2:4]
                misr_path_id = parse(Int, mp)
            end
            regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
            if occursin(regexp, parts[4])
                mo = parts[4][2:7]
                misr_orbit_id = parse(Int, mo)
            end
            part56 = parts[5] * '_' * parts[6]
            regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
            if occursin(regexp, part56)
                misr_version_id = part56
            end
    # ------------------------------------------------------ TC_CLOUD
        elseif parts[2] == "CLOUD"
            if nparts != 6
                return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
            end
            misr_product_id = "TC_CLOUD"
            misr_prdct_id = "L2TCLOUD"
            regexp = r"P[0-9][0-9][0-9]"
            if occursin(regexp, parts[3])
                mp = parts[3][2:4]
                misr_path_id = parse(Int, mp)
            end
            regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
            if occursin(regexp, parts[4])
                mo = parts[4][2:7]
                misr_orbit_id = parse(Int, mo)
            end
            part56 = parts[5] * '_' * parts[6]
            regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
            if occursin(regexp, part56)
                misr_version_id = part56
            end
    # ------------------------------------------------------ TC_STEREO
        elseif parts[2] == "STEREO"
            if nparts != 6
                return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
            end
            misr_product_id = "TC_STEREO"
            misr_prdct_id = "L2TSTEREO"
            regexp = r"P[0-9][0-9][0-9]"
            if occursin(regexp, parts[3])
                mp = parts[3][2:4]
                misr_path_id = parse(Int, mp)
            end
            regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
            if occursin(regexp, parts[4])
                mo = parts[4][2:7]
                misr_orbit_id = parse(Int, mo)
            end
            part56 = parts[5] * '_' * parts[6]
            regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
            if occursin(regexp, part56)
                misr_version_id = part56
            end
        else
            return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
        end
    # ------------------------------------------------------ AS
    elseif parts[1] == "AS"
    # ------------------------------------------------------ AS_AEROSOL
        if parts[2] == "AEROSOL"
            if nparts != 6
                return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
            end
            misr_product_id = "AS_AEROSOL"
            misr_prdct_id = "L2AERO"
            regexp = r"P[0-9][0-9][0-9]"
            if occursin(regexp, parts[3])
                mp = parts[3][2:4]
                misr_path_id = parse(Int, mp)
            end
            regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
            if occursin(regexp, parts[4])
                mo = parts[4][2:7]
                misr_orbit_id = parse(Int, mo)
            end
            part56 = parts[5] * '_' * parts[6]
            regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
            if occursin(regexp, part56)
                misr_version_id = part56
            end
    # ------------------------------------------------------ AS_LAND
        elseif parts[2] == "LAND"
            if nparts != 6
                return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
            end
            misr_product_id = "AS_LAND"
            misr_prdct_id = "L2LAND"
            regexp = r"P[0-9][0-9][0-9]"
            if occursin(regexp, parts[3])
                mp = parts[3][2:4]
                misr_path_id = parse(Int, mp)
            end
            regexp = r"O[0-9][0-9][0-9][0-9][0-9][0-9]"
            if occursin(regexp, parts[4])
                mo = parts[4][2:7]
                misr_orbit_id = parse(Int, mo)
            end
            part56 = parts[5] * '_' * parts[6]
            regexp = r"F[0-9][0-9]_[0-9][0-9][0-9][0-9]"
            if occursin(regexp, part56)
                misr_version_id = part56
            end
        else
            return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id
        end
    end

    return misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id

end

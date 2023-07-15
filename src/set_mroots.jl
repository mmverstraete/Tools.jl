"""
    mroots = set_mroots(action; mroot_misr = mroot_misr, mroot_misrhr = mroot_misrhr,
        mroot_agp = mroot_agp, mroot_scrap = mroot_scrap)

# Purpose(s):
* Set, reset, unset or show (on `stdout`) the environment variables pointing to the root directories used by the MISRHR processing system.

# Positional argument(s):
* `action::AbstractString = "Show"`: The processing selector.

# Keyword argument(s):
* `mroot_misr::Union{AbstractString, Nothing} = nothing`: Set the environment variable `MROOT_MISR` to the root directory for MISR data files.
* `mroot_misrhr::Union{AbstractString, Nothing} = nothing`: Set the environment variable `MROOT_MISRHR` to the root directory for MISRHR product files.
* `mroot_agp::Union{AbstractString, Nothing} = nothing`: Set the environment variable `MROOT_AGP` to the root directory for the 233 MISR AGP static files.
* `mroot_scrap::Union{AbstractString, Nothing} = nothing`: Set the environment variable `MROOT_SCRAP` to the root directory for temporary files, e.g., for testing purposes.

# Return value(s):
* `out_misr::AbstractString`: The value of the environment variable `MROOT_MISR`.
* `out_misrhr::AbstractString`: The value of the environment variable `MROOT_MISRHR`.
* `out_agp::AbstractString`: The value of the environment variable `MROOT_AGP`.
* `out_scrap::AbstractString`: The value of the environment variable `MROOT_SCRAP`.

# Algorithm:
* If the positional argument `action == "Set"`:
- If a keyword argument is provided, the corresponding environment variable is set to that value.
- If a keyword argument is not provided and the corresponding environment variable has already been set, it is left unchanged.
- If a keyword argument is not provided and the corresponding environment variable has not been previously set, it is set to its default value.
* If the positional argument `action == "Reset"`:
- All five environment variables are reset to their default values.
* If the positional argument `action == "Unset"`:
- All 5 environment variables are deleted.
* If the positional argument `action == "Show"` (or is absent):
- The current settings of these environment variables are printed on `stdio`, where each valid directory is bracketed between the symbols `>` and `<` to make an eventual null string setting clear.
* If the positional argument takes any other value:
- An error condition is raised.

# References:
* The MISR-HR Processing System Manual.

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* Refer to the MISRHR User Manual for a detailed discussion of the two main filesystems of the MISR-HR processing system: one for the MISR data files, and one for the MISR-HR product files.
* The environment variables defined by this function are used to set the recommended root directories of these three filesystems, used specifically by the functions `make_misr_fspec` and `make_misrhr_fspec`.
* This function only ensures that these environment variables are properly set and ready for use: it does not verify that the indicated directories are actually accessible or contain the desired files.
* The validity and scope of these environment variables are limited to the current Julia session. To make those settings permanent, set and export these environment variables in the shell configuration file (e.g., `.zshenv`).
* AGP files are normally available from the appropriate subdirectory of `MROOT_MISR`. However, since those files are static throughout the mission, a copy of those files may also be installed under `MROOT_AGP` for convenient access. Set this environment variable to a null string to disable this feature.
* The environment variable `MROOT_SCRAP` points to a local directory, meant for temporary storage or for testing purposes. Set this environment variable to a null string to disable this feature.
* In an operational context, files can be stored in multiple external disks: this function can be called repeatedly with different keyword values to adjust these root directories as required. 

# Example 1:
```julia
julia> Tools

julia> mroots = set_mroots("Set"; mroot_misr = "/dir/misr", mroot_misrhr = "/dir/misrhr", mroot_agp = "/dir/agp", mroot_scrap = "/dir/scrap");

julia> set_mroots("Show");
ENV["MROOT_MISR"] = >/dir/misr<
ENV["MROOT_MISRHR"] = >/dir/misrhr<
ENV["MROOT_AGP"] = >/dir/agp<
ENV["MROOT_SCRAP"] = >/dir/scrap<
```

# Example 2:
```julia
julia> Tools

julia> mroots = set_mroots("Set"; mroot_misr = "/Volumes/MISR_Data1");

julia> set_mroots("Show");
ENV["MROOT_MISR"] = >/Volumes/MISR_Data1<
ENV["MROOT_MISRHR"] = >/dir/misrhr<
ENV["MROOT_AGP"] = >/dir/agp<
ENV["MROOT_SCRAP"] = >/dir/scrap<
```

# Example 3:
```julia
julia> Tools

julia> set_mroots("Unset");

julia> set_mroots("Show");
ENV["MROOT_MISR"] is not set.
ENV["MROOT_MISRHR"] is not set.
ENV["MROOT_AGP"] is not set.
ENV["MROOT_SCRAP"] is not set.
```

# Example 4:
```julia
julia> Tools

julia> mroots = set_mroots("Reset");

julia> set_mroots("Show");
ENV["MROOT_MISR"] = >/Volumes/MISR_Data0/<
ENV["MROOT_MISRHR"] = >/Volumes/MISR-HR/<
ENV["MROOT_AGP"] = >/Users/michel/Projects/MISR/Data/AGP/<
ENV["MROOT_SCRAP"] = >/Users/michel/Projects/MISR/Scrap/<
```
"""
function set_mroots(
    action::AbstractString = "Show";
    mroot_misr::Union{AbstractString, Nothing} = nothing,
    mroot_misrhr::Union{AbstractString, Nothing} = nothing,
    mroot_agp::Union{AbstractString, Nothing} = nothing,
    mroot_scrap::Union{AbstractString, Nothing} = nothing
    )::Tuple{AbstractString, AbstractString, AbstractString, AbstractString}

    # Define the default values:
    defaults = [
        "/Volumes/MISR_Data0/"
        "/Volumes/MISRHR/"
        "/Users/michel/Projects/MISR/Data/AGP/"
        "/Users/michel/Projects/MISR/Scrap/"]

    # Set the root directories to their default or specified values:
    if action == "Set"
        if mroot_misr === nothing
            if ("MROOT_MISR" in keys(ENV)) == false
                ENV["MROOT_MISR"] = defaults[1]
            end
        else
            ENV["MROOT_MISR"] = mroot_misr
        end

        if mroot_misrhr === nothing
            if ("MROOT_MISRHR" in keys(ENV)) === false
                ENV["MROOT_MISRHR"] = defaults[2]
            end
        else
            ENV["MROOT_MISRHR"] = mroot_misrhr
        end

        if mroot_agp === nothing
            if ("MROOT_AGP" in keys(ENV)) == false
                ENV["MROOT_AGP"] = defaults[3]
            end
        else
            ENV["MROOT_AGP"] = mroot_agp
        end

        if mroot_scrap === nothing
            if ("MROOT_SCRAP" in keys(ENV)) === false
                ENV["MROOT_SCRAP"] = defaults[4]
            end
        else
            ENV["MROOT_SCRAP"] = mroot_scrap
        end

        return ENV["MROOT_MISR"], ENV["MROOT_MISRHR"], ENV["MROOT_AGP"], ENV["MROOT_SCRAP"]

    # Reset the root directories to their default values:
    elseif action == "Reset"
        ENV["MROOT_MISR"] = defaults[1]
        ENV["MROOT_MISRHR"] = defaults[2]
        ENV["MROOT_AGP"] = defaults[3]
        ENV["MROOT_SCRAP"] = defaults[4]

        return ENV["MROOT_MISR"], ENV["MROOT_MISRHR"], ENV["MROOT_AGP"], ENV["MROOT_SCRAP"]

    # Unset the root directories:
    elseif action == "Unset"
        delete!(ENV, "MROOT_MISR")
        delete!(ENV, "MROOT_MISRHR")
        delete!(ENV, "MROOT_AGP")
        delete!(ENV, "MROOT_SCRAP")
        return "ENV[\"MROOT_MISR\"] is not set.",
            "ENV[\"MROOT_MISRHR\"] is not set.",
            "ENV[\"MROOT_AGP\"] is not set.",
            "ENV[\"MROOT_SCRAP\"] is not set."

    # Exhibit the current root directories:
    elseif (action == "Show") | (action === nothing)
        if "MROOT_MISR" in keys(ENV)
            out_misr = "ENV[\"MROOT_MISR\"] = >" * ENV["MROOT_MISR"] * "<"
        else
            out_misr = "ENV[\"MROOT_MISR\"] is not set."
        end
        println(out_misr)

        if "MROOT_MISRHR" in keys(ENV)
            out_misrhr = "ENV[\"MROOT_MISRHR\"] = >" * ENV["MROOT_MISRHR"] * "<"
        else
            out_misrhr = "ENV[\"MROOT_MISRHR\"] is not set."
        end
        println(out_misrhr)

        if "MROOT_AGP" in keys(ENV)
            out_agp = "ENV[\"MROOT_AGP\"] = >" * ENV["MROOT_AGP"] * "<"
        else
            out_agp = "ENV[\"MROOT_AGP\"] is not set."
        end
        println(out_agp)

        if "MROOT_SCRAP" in keys(ENV)
            out_scrap = "ENV[\"MROOT_SCRAP\"] = >" * ENV["MROOT_SCRAP"] * "<"
        else
            out_scrap = "ENV[\"MROOT_SCRAP\"] is not set."
        end
        println(out_scrap)

        return out_misr, out_misrhr, out_agp, out_scrap
    else
        return out_misr, out_misrhr, out_agp, out_scrap
    end
end

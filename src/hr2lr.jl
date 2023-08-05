"""
    matrix_lr = hr2lr(matrix_hr, factor, innature)

# Purpose(s):
* Downsize the positional argument `matrix_hr` by the shrink `factor` in each dimension, and return a shrunk matrix `matrix_lr` of the same type as `matrix_hr`. The two dimensions of `matrix_hr` must both be multiples of `factor`. The algorithm used to determine the values of the elements in `matrix_lr` depends on the value of the positional argument `innature`.

# Positional argument(s):
* `matrix_hr::AbstractMatrix{<:Real}`: The 2-D array to be downsized.
* `factor::Integer`: The shrink factor.
* `innature::AbstractString`: The algorithm selector.

# Keyword argument(s): None.

# Return value(s):
* `matrix_lr::AbstractMatrix{Real}`: A shrunk numeric array of the same type as `matrix_hr`, where each dimension is `factor` times smaller than the same dimension of `matrix_hr`.

# Algorithm:
* This function accepts arbitrary matrix dimensions and compatible shrink factors but is designed to process a high spatial resolution `matrix_hr` MISR data array dimensioned 512 lines by 2048 columns and generate an `matrix_lr` array dimensioned 128 lines by 512 columns. In the case of radiances or reflectances, this simulates the averaging taking place on-board the Terra platform for the 24 non-red MISR data channels of the Global Mode off-nadir cameras. This function may also be used to downsize other arrays, such as RDQI or land cover masks.

* The downscaling algorithm analyzes successive, non-overlapping subwindows of `factor` by `factor` pixels in `matrix_hr` and generates a single corresponding value in the output `matrix_lr` array as follows, based on the usable data values defined by a range, and depending on the value of the positional argument `innature`:

- If `innature = "Brf"`, the input array `matrix_hr` is expected to be of type `AbstractFloat` and the function assumes that it contains non-dimensional L1B2 Bidirectional Reflectance Factor (BRF) data, which can only take on usable values within the range `]0.0, 2.0]`. If a quarter or more of the `factor` by `factor` subwindow values are deemed usable, the corresponding BRF value of the low resolution output array is set to the arithmetic MEAN VALUE of the usable (non-zero) BRFs in the subwindow. Otherwise, the corresponding BRF value of the low resolution output array is set to `0.0`.

- If `innature = "LWCMask"`, the input array `matrix_hr` is expected to be of type `UInt8` and the function assumes that it contains a Land/Water/Cloud mask, which can only take on usable values within the range `]0x01, 0x11]` (decimal 1, 2 or 3). Larger values are unusable but carry the following meanings: `0xfd` (decimal 253) flags pixels obscured by topography and `0xfe` (decimal 254) flags pixels on the edges of the effective swath width of the MISR instrument. The mask values of the low resolution output array are set to the MOST PREVALENT flag if there are more flags than actual measurements, and to the MOST PREVALENT mask class otherwise, with priority for larger values.

- If `innature = "Rad"`, the input array `matrix_hr` is expected to be of type `AbstractFloat` and the function assumes that it contains unscaled L1B2 Radiance data, which can only take on usable values within the range `]0.0, 800.0]` Watts per square meter per steradian and per micrometer. If a quarter or more of the `factor` by `factor` subwindow values are deemed usable, the corresponding unscaled Radiance value of the low resolution output array is set to the arithmetic MEAN VALUE of the usable (non-zero) Radiances in the subwindow. Otherwise, the corresponding unscaled Radiance value of the low resolution output array is set to `0.0`.

- If `innature = "Radrd"`, the input array `matrix_hr` is expected to be of type `UInt16` and the function assumes that it contains scaled L1B2 Radiance data with the RDQI attached, which can only take on usable values within the range `]0x0000, 0xffe3]` (decimal 0 to 65507). Larger values are unusable but carry the following meanings: `0xffe7` (decimal 65511) flags pixels obscured by topography, `0xffeb` (decimal 65515) flags edge pixels, `0xffef` (decimal 65519) flags pixels in ocean Blocks, and `0xfff3` (decimal 65523) flags missing or bad data, including edge pixels. If a quarter or more of the `factor` by `factor` subwindow values are deemed usable, the corresponding scaled Radiance value of the low resolution output array is set to the arithmetic MEAN VALUE of the usable (non-zero) Radiances in the subwindow (without the RDQI attached), supplemented with the largest RDQI value found among the usable values of the subwindow. Otherwise, the corresponding scaled Radiance value of the low resolution output array is set to the largest `Uint16` found within that subwindow.

- If `innature == "RDQI"`, the input array `matrix_hr` is expected to be of type `UInt8` and the function assumes that it contains RDQI data, which can only take on usable values within the range `[0x00, 0x03]` (decimal 0 to 3). The RDQI values of the low resolution output array are set to the LARGEST RDQI value found among the usable values of the subwindow.

# Reference(s):
* The MISRHR Processing System Manual.
* Michel M. Verstraete, Linda A. Hunt, Hugo De Lemos and Larry Di Girolamo (2020) Replacing Missing Values in the Standard MISR Radiometric Camera-by-Camera Cloud Mask (RCCM) Data Product, _Earth System Science Data_, Vol. 12, p. 611-628, available from https://www.earth-syst-sci-data.net/12/611/2020/essd-12-611-2020.html, (DOI: 10.5194/essd-12-611-2020).

# Licensing:
* Copyright © 2023 Michel M. Verstraete,
    [MIT license](https://opensource.org/licenses/MIT).

# Note(s):
* This function is specifically designed to handle the following MISR data arrays: L1B2 scaled and unscaled RADIANCE, BRF, RDQI and land cover masks, where `factor = 4` to generate a reduced spatial resolution data matrix from a full (native) spatial resolution array.
* In the context of this function, a value is meant to be `usable` if it corresponds to a meaningful geophysical value, by opposition to flags representing missing values.
* This function defines, for each of the 5 possible values of `innature`, a range (defined by a minimum and a maximum) of valid values.
* When `innature` is either `Brf`, `Rad`, or `Radrd, the low resolution value is reset to `0.0` when missing values are prevalent in the corresponding window of the high resolution matrix.
* If `factor < 2`, an error condition is raised.
* Since this function assigns a single value in the low spatial resolution matrix for each `factor x factor` window in the original high spatial resolution, it reduces the information content of the original file. Furthermore, this function does not preserve the information about missing value flags. Contrast this with the function `lr2hr.jl`, which appears to implement the reverse transformation, but only duplicates values. Hence `lr2hr(hr2lr(hr_array))` is generally not equivalent to `hr_array`.

# Example 1:
```julia
julia> using Tools

julia> matrix_hr = [
        0.12 0.12 0.14 9.99;
        0.12 0.12 0.14 0.14;
        0.16 0.16 9.99 9.99;
        9.99 9.99 9.99 0.18;
        0.21 0.23 9.99 9.99;
        0.27 0.29 9.99 9.99]
6×4 Matrix{Float64}:
 0.12  0.12  0.14  9.99
 0.12  0.12  0.14  0.14
 0.16  0.16  9.99  9.99
 9.99  9.99  9.99  0.18
 0.21  0.23  9.99  9.99
 0.27  0.29  9.99  9.99

julia> matrix_lr = hr2lr(matrix_hr, 2, "Brf")
3×2 Matrix{Float64}:
 0.12  0.14
 0.16  0.18
 0.25  0.0
```

# Example 2:
```julia
julia> using Tools

julia> matrix_hr = [
        0x01    0x01    0x02    0x02    0x03    0x03
        0x01    0x01    0x02    0x02    0x03    0x03
        0x01    0x02    0x01    0x01    0x02    0x01
        0x02    0x01    0x01    0x03    0x03    0x03
        0x01    0x02    0xfe    0xfd    0x02    0xfe
        0x03    0xfd    0xfe    0xfd    0x02    0x03
        0x03    0x03    0x01    0xfe    0x01    0x01
        0xfe    0xfe    0xfe    0xfd    0x03    0xfd]
8×6 Matrix{UInt8}:
 0x01  0x01  0x02  0x02  0x03  0x03
 0x01  0x01  0x02  0x02  0x03  0x03
 0x01  0x02  0x01  0x01  0x02  0x01
 0x02  0x01  0x01  0x03  0x03  0x03
 0x01  0x02  0xfe  0xfd  0x02  0xfe
 0x03  0xfd  0xfe  0xfd  0x02  0x03
 0x03  0x03  0x01  0xfe  0x01  0x01
 0xfe  0xfe  0xfe  0xfd  0x03  0xfd

julia> matrix_lr = hr2lr(matrix_hr, 2, "LWCMask")
4×3 Matrix{UInt8}:
 0x01  0x02  0x03
 0x02  0x01  0x03
 0x03  0xfe  0x02
 0xfe  0xfe  0x01
```

# Example 3:
```julia
julia> using Tools

julia> matrix_hr = [
        350.0   350.0   400.0   400.0   450.0   450.0
        350.0   350.0   400.0   400.0   450.0   450.0
        320.0   340.0   320.0   340.0   310.0   0.0
        360.0   0.0     0.0     0.0     0.0     0.0]
4×6 Matrix{Float64}:
 350.0  350.0  400.0  400.0  450.0  450.0
 350.0  350.0  400.0  400.0  450.0  450.0
 320.0  340.0  320.0  340.0  310.0    0.0
 360.0    0.0    0.0    0.0    0.0    0.0

julia> matrix_lr = hr2lr(matrix_hr, 2, "Rad")
2×3 Matrix{Float64}:
 350.0  400.0  450.0
 340.0  330.0  310.0
```

# Example 4:
```julia
julia> using Tools

julia> matrix_hr = [
        32000   32100   32200   32300
        32400   32500   32600   32700
        32800   32900   33000   33100
        33200   33300   33400   33500

        32100   32200   32300   32400
        32100   32200   32300   32400
        32100   32200   32300   32400
        32100   32200   32300   32400

        32100   32200   32300   65515
        32100   32200   32300   65515
        32100   32200   32300   65515
        32100   32200   65511   65515

        32100   32200   65511   65515
        32100   32200   65511   65515
        32100   32200   65511   65515
        32100   32200   65511   65515

        32200   32201   32203   65515
        32201   32200   65511   65515
        32202   32200   65511   65515
        32101   32200   65511   65515]
20×4 Matrix{Int64}:
 32000  32100  32200  32300
 32400  32500  32600  32700
 32800  32900  33000  33100
 33200  33300  33400  33500
 32100  32200  32300  32400
 32100  32200  32300  32400
 32100  32200  32300  32400
 32100  32200  32300  32400
 32100  32200  32300  65515
 32100  32200  32300  65515
 32100  32200  32300  65515
 32100  32200  65511  65515
 32100  32200  65511  65515
 32100  32200  65511  65515
 32100  32200  65511  65515
 32100  32200  65511  65515
 32200  32201  32203  65515
 32201  32200  65511  65515
 32202  32200  65511  65515
 32101  32200  65511  65515

julia> matrix_lr = hr2lr(matrix_hr, 4, "RadRd")
5×1 Matrix{Int64}:
 32752
 32248
 32192
 32152
 32191
```

# Example 5:
```julia
julia> using Tools

julia> matrix_hr = [
        0b00    0b00    0b00    0b01
        0b00    0b00    0b00    0b00
        0b00    0b10    0b00    0b11
        0b01    0b01    0b10    0b01]
4×4 Matrix{UInt8}:
 0x00  0x00  0x00  0x01
 0x00  0x00  0x00  0x00
 0x00  0x02  0x00  0x03
 0x01  0x01  0x02  0x01

julia> matrix_lr = hr2lr(matrix_hr, 2, "RDQI")
2×2 Matrix{UInt8}:
 0x00  0x01
 0x02  0x03
```
"""
function hr2lr(
    matrix_hr::AbstractMatrix{<:Real},
    factor::Integer,
    innature::AbstractString
    )::AbstractMatrix{<:Real}

    # Check the validity of the positional argument `factor`:
    if factor < 2
        error("hr2lr: The positional argument factor must be an integer strictly greater than 1.")
    end

    # Retrieve the dimensions of the positional argument `matrix_hr`, check that those dimensions are multiples of the shrink factor, and retrieve the type of its elements:
    in_size = size(matrix_hr)
    if (mod(in_size[1], factor) != 0) |
        (mod(in_size[2], factor) != 0)
        error("hr2lr: Both dimensions of the positional argument matrix_hr must be multiples of the positional argument factor.")
    end
    in_type = typeof(matrix_hr[1, 1])

    # Define the output array `matrix_lr`:
    os1 = div(in_size[1], factor)
    os2 = div(in_size[2], factor)
    out_size = (os1, os2)
    matrix_lr = similar(matrix_hr, in_type, out_size)

    # Loop over the elements of the low spatial resolution output array `matrix_lr` and set the initial index of the corresponding elements in the high spatial resolution input array:
    for i = 1:out_size[1]
        ii = 1 + (i - 1) * factor

        for j = 1:out_size[2]
            jj = 1 + (j - 1) * factor

    # Populate a local submatrix within the high-resolution input array elements:
            submatrix = matrix_hr[ii:ii + (factor - 1), jj:jj + (factor - 1)]

    # Process the input array according to the argument `innature`:

    # ------------------------------------------------------ Brf
    # Process a high-resolution Brf array: Array elements are expected to be Float64 values in the range [0.0, 2.0], where usable values are within ]0.0, 2.0] (i.e., excluding 0) and where edge, obscured or missing values are all represented by null values. The corresponding low spatial resolution value is set to the average usable Brf within that subwindow:
            if innature == "Brf"
                min_usable = 0.0
                max_usable = 2.0
        
                usable = findall(x -> ((x > min_usable) & (x <= max_usable)), submatrix)
                n_usable = length(usable)
                if n_usable < div((factor * factor), 4)
                    matrix_lr[i, j] = 0.0
                else
                    matrix_lr[i, j] = Statistics.mean(submatrix[usable])
                end

    # ------------------------------------------------------ LWCMask
    # Process a high-resolution Land/Water/Cloud mask array: Array elements are expected to be UInt8 values in the range [0x01, 0x03] (decimal 1 to 3), where Land = 1, Water = 2 and Cloud = 3) and where values larger than 0xfc (decimal 252) are unusable: 0xfd (decimal 253) flags obscured pixels and 0xfe (decimal 254) flags edge pixels. The corresponding low spatial resolution value is set to the most prevalent usable value within the subwindow, with priority for larger values, unless there are more obscured or edge values than usable values:
            elseif innature == "LWCMask"
                min_usable = 0x01
                max_usable = 0x03

                n_lnd = count(==(0x01), submatrix)
                n_wat = count(==(0x02), submatrix)
                n_cld = count(==(0x03), submatrix)
                n_val = n_lnd + n_wat + n_cld
                max_val = maximum([n_lnd, n_wat, n_cld])
                n_obsc = count(==(0xfd), submatrix)
                n_edge = count(==(0xfe), submatrix)
                n_inval = n_obsc + n_edge
                if n_inval >= n_val
                    if n_edge >= n_obsc
                        matrix_lr[i, j] = 0xfe
                    else
                        matrix_lr[i, j] = 0xfd
                    end
                else
                    if n_cld == max_val
                        matrix_lr[i, j] = 0x03
                    elseif n_wat == max_val
                        matrix_lr[i, j] = 0x02
                    else
                        matrix_lr[i, j] = 0x01
                    end
                end

    # ------------------------------------------------------ Rad
    # Process a high-resolution MISR L1B2 unscaled radiance array: Array elements are expected to be Float64 values in the range [0.0, 800.0], where usable values are within ]0.0, 800.0] and null values are unusable. If fewer than half of the values in the subwindow are usable, set the corresponding low spatial resolution value to zero; otherwise set it to the average of the usable values:
            elseif innature == "Rad"
                min_usable = 0.0
                max_usable = 800.0

                usable = findall(x -> ((x > min_usable) & (x <= max_usable)), submatrix)
                n_usable = length(usable)
                if n_usable < div((factor * factor), 4)
                    matrix_lr[i, j] = 0.0
                else
                    matrix_lr[i, j] = Statistics.mean(submatrix[usable])
                end

    # ------------------------------------------------------ RadRd
    # Process a high-resolution MISR L1B2 scaled radiance array: Array elements are expected to be UInt16 values in the range [0x0000, 0xffff], where usable values are within ]0x0000, 0xffe3] and where values larger than 0xffe3 (decimal 65507) are unusable: 0xffe7 (decimal 65511) flags obscured pixels, 0xffeb (decimal 65515) flags edge pixels, 0xffef (decimal 65519) flags pixels in ocean Blocks, and 0xfff3 (decimal 65523) flags missing or bad data. The last (least significant) two bits of those numbers constitute the RDQI quality flag, which must be discarded for the purpose of computing the average usable value. The corresponding low spatial resolution value is set to that average, reassembled with the largest RDQI flag value found among the valid values of the subwindow:
            elseif innature == "RadRd"
                min_usable = 0x0000
                max_usable = 0xffe3

                usable = findall(x -> ((x > min_usable) & (x <= max_usable)), submatrix)
                n_usable = length(usable)
                if n_usable < div((factor * factor), 4)
                    matrix_lr[i, j] = maximum(submatrix)
                else
                    rad = div.(submatrix[usable], 4)
                    rdq = submatrix[usable] - (rad * 4)
                    rad_mean = Statistics.mean(float(rad))
                    rdq_max = maximum(rdq)
                    matrix_lr[i, j] = (round(UInt16, rad_mean) * 4) + rdq_max
                end
    # ------------------------------------------------------ RDQI
    # Process a high-resolution MISR L1B2 Radiometric Data Quality Indicator (RDQI) array: Array elements can only take on one of the four values of a 2-bit integer (0b00, 0b01, 0b10, 0b11, which are decimal 0, 1, 2, 3), though they may be represented by UInt8 integers during the processing. The corresponding low spatial resolution value is set to the highest RDQI value within the subwindow. (Note: This assumes that an RDQI of 0b11 (decimal 3) only occurs when the corresponding radiance value is also flagged as obscured, edge or missing/bad):
            elseif innature == "RDQI"
                matrix_lr[i, j] = maximum(submatrix)
            end
        end    # End of loop on columns of `matrix_lr`.
    end    # End of loop on lines of `matrix_lr`.

    return matrix_lr

end

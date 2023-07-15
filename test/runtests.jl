using Tools
using Dates
using Test

# ==========================================================================================
@testset "Tools.jl" begin
# ---------------------------------------------------------- get_orbit_date
    include(Tools_test * "get_orbit_date_tst_Datapool.jl")
    orbit_date, orbit_date_string = get_orbit_date_tst_Datapool();
    @test orbit_date == Date("2012-10-03")
    @test orbit_date_string == "2012.10.03"

    include(Tools_test * "get_orbit_date_tst_Julian.jl")
    orbit_date, orbit_date_string = get_orbit_date_tst_Julian();
    @test orbit_date == Date("2012-10-03")
    @test orbit_date_string == "2.4562037994444445e6"

    include(Tools_test * "get_orbit_date_tst_NoFmt.jl")
    orbit_date, orbit_date_string = get_orbit_date_tst_NoFmt();
    @test orbit_date == Date("2012-10-03")
    @test orbit_date_string == "2012-10-03"
# ---------------------------------------------------------- is_valid_ftype
    include(Tools_test * "is_valid_ftype_tst_Caption.jl")
    bool = is_valid_ftype_tst_Caption();
    @test bool == true
# ---------------------------------------------------------- is_valid_misr_band
include(Tools_test * "is_valid_misr_band_tst_Blue.jl")
    bool = is_valid_misr_band_tst_Blue();
    @test bool == true

    include(Tools_test * "is_valid_misr_band_tst_red.jl")
    bool = is_valid_misr_band_tst_red();
    @test bool == false
# ---------------------------------------------------------- is_valid_misr_block
    include(Tools_test * "is_valid_misr_block_tst_005.jl")
    bool, misr_block_string = is_valid_misr_block_tst_005();
    @test bool == true
    @test misr_block_string == "B005"

    include(Tools_test * "is_valid_misr_block_tst_168.jl")
    bool, misr_block_string = is_valid_misr_block_tst_168();
    @test bool == true
    @test misr_block_string == "B168"

    include(Tools_test * "is_valid_misr_block_tst_246.jl")
    bool, misr_block_string = is_valid_misr_block_tst_246();
    @test bool == false
    @test misr_block_string == ""
# ---------------------------------------------------------- is_valid_misr_camera
    include(Tools_test * "is_valid_misr_camera_tst_DF.jl")
    bool = is_valid_misr_camera_tst_DF();
    @test bool == true

    include(Tools_test * "is_valid_misr_camera_tst_star.jl")
    bool = is_valid_misr_camera_tst_star();
    @test bool == false
# ---------------------------------------------------------- is_valid_misr_orbit
    include(Tools_test * "is_valid_misr_orbit_tst_068050.jl")
    bool, misr_orbit_string = is_valid_misr_orbit_tst_068050();
    @test bool == true
    @test misr_orbit_string == "O068050"

    include(Tools_test * "is_valid_misr_orbit_tst_000900.jl")
    bool, misr_orbit_string = is_valid_misr_orbit_tst_000900();
    @test bool == false
    @test misr_orbit_string == ""
# ---------------------------------------------------------- is_valid_misr_path
    include(Tools_test * "is_valid_misr_path_tst_168.jl")
    bool, misr_path_string = is_valid_misr_path_tst_168();
    @test bool == true
    @test misr_path_string == "P168"
# ---------------------------------------------------------- is_valid_misr_prdct
    include(Tools_test * "is_valid_misr_prdct_tst_AGP.jl")
    bool, prdct_name, prdct_full_name, prdct_esdt = is_valid_misr_prdct_tst_AGP();
    @test bool == true
    @test prdct_name == "AGP"
    @test prdct_full_name == "Ancillary Geographic Product"
    @test prdct_esdt == "MIANCAGP"

    include(Tools_test * "is_valid_misr_prdct_tst_RCCM.jl")
    bool, prdct_name, prdct_full_name, prdct_esdt = is_valid_misr_prdct_tst_RCCM();
    @test bool == true
    @test prdct_name == "GRP_RCCM_GM"
    @test prdct_full_name == "Radiometric Camera-by-Camera Cloud Mask Product"
    @test prdct_esdt == "MIRCCM"
# ---------------------------------------------------------- is_valid_misr_resolution
    include(Tools_test * "is_valid_misr_resolution_tst_1100.jl")
    bool, misr_resolution_string = is_valid_misr_resolution_tst_1100();
    @test bool == true
    @test misr_resolution_string == "R1100"
# ---------------------------------------------------------- is_valid_misr_site
    include(Tools_test * "is_valid_misr_site_tst_egypt1.jl")
    bool, misr_site_label = is_valid_misr_site_tst_egypt1();
    @test bool == true
    @test misr_site_label == "egypt 1"

    include(Tools_test * "is_valid_misr_site_tst_egypt2.jl")
    bool, misr_site_label = is_valid_misr_site_tst_egypt2();
    @test bool == false
    @test misr_site_label == "The positional argument misr_site is not recognized."
# ---------------------------------------------------------- is_valid_misrhr_ftype
    include(Tools_test * "is_valid_misrhr_ftype_tst_Map1.jl")
    bool = is_valid_misrhr_ftype_tst_Map1();
    @test bool == true

    include(Tools_test * "is_valid_misrhr_ftype_tst_map2.jl")
    bool = is_valid_misrhr_ftype_tst_map2();
    @test bool == false
# ---------------------------------------------------------- is_valid_misrhr_prdct
    include(Tools_test * "is_valid_misrhr_prdct_tst_L1RCCMmvr.jl")
    bool, prdct_full_name = is_valid_misrhr_prdct_tst_L1RCCMmvr();
    @test bool == true
    @test prdct_full_name == "Radiometric Camera-by-Camera Cloud Mask, Missing Values Replaced"

    include(Tools_test * "is_valid_misrhr_prdct_tst_TIP.jl")
    bool, prdct_full_name = is_valid_misrhr_prdct_tst_TIP();
    @test bool == true
    @test prdct_full_name == "Two-stream Inversion Package"
# ---------------------------------------------------------- make_dates
    include(Tools_test * "make_dates_tst_1000.jl")
    dates, date1, date2, date3 = make_dates_tst_1000();
    @test dates == "2012-06-13+2012-06-13+" * Dates.format(today(), "yyyy-mm-dd")
    @test date1 == Date("2012-06-13")
    @test date2 == Date("2012-06-13")
    @test date3 == today()

    include(Tools_test * "make_dates_tst_1100.jl")
    dates, date1, date2, date3 = make_dates_tst_1100();
    @test dates == "2012-06-13+2014-06-28+" * Dates.format(today(), "yyyy-mm-dd")
    @test date1 == Date("2012-06-13")
    @test date2 == Date("2014-06-28")
    @test date3 == today()
# ---------------------------------------------------------- make_location
include(Tools_test * "make_location_tst_1.jl")
    location = make_location_tst_1();
    @test location == "NOLOC"

    include(Tools_test * "make_location_tst_2.jl")
    location = make_location_tst_2();
    @test location == "P168"

    include(Tools_test * "make_location_tst_3.jl")
    location = make_location_tst_3();
    @test location == "P168+O068050+B110"

    include(Tools_test * "make_location_tst_4.jl")
    location = make_location_tst_4();
    @test location == "P168-P170+O068050-O072000+SITE-SKUKUZA"
# ---------------------------------------------------------- make_misr_fname
    include(Tools_test * "make_misr_fname_tst_AGP1.jl")
    misr_fname = make_misr_fname_tst_AGP1();
    @test misr_fname == ["MISR_AM1_AGP_P168_F01_24.hdf"]

    include(Tools_test * "make_misr_fname_tst_AGP2.jl")
    misr_fname = make_misr_fname_tst_AGP2();
    @test misr_fname == ["MISR_AM1_AGP_P168_F01_24.hdf"]

    include(Tools_test * "make_misr_fname_tst_L1RTGM.jl")
    misr_fname = make_misr_fname_tst_L1RTGM();
    @test misr_fname == [
        "MISR_AM1_GRP_TERRAIN_GM_P168_O068050_DF_F03_0024.hdf"
        "MISR_AM1_GRP_TERRAIN_GM_P168_O068050_CF_F03_0024.hdf"
        "MISR_AM1_GRP_TERRAIN_GM_P168_O068050_BF_F03_0024.hdf"
        "MISR_AM1_GRP_TERRAIN_GM_P168_O068050_AF_F03_0024.hdf"
        "MISR_AM1_GRP_TERRAIN_GM_P168_O068050_AN_F03_0024.hdf"
        "MISR_AM1_GRP_TERRAIN_GM_P168_O068050_AA_F03_0024.hdf"
        "MISR_AM1_GRP_TERRAIN_GM_P168_O068050_BA_F03_0024.hdf"
        "MISR_AM1_GRP_TERRAIN_GM_P168_O068050_CA_F03_0024.hdf"
        "MISR_AM1_GRP_TERRAIN_GM_P168_O068050_DA_F03_0024.hdf"]
# ---------------------------------------------------------- make_misr_fpath
    include(Tools_test * "make_misr_fpath_tst_AGP.jl")
    misr_fpath = make_misr_fpath_tst_AGP();
    @test misr_fpath == "~/P168/AGP/"

    include(Tools_test * "make_misr_fpath_tst_L1RTGM.jl")
    misr_fpath = make_misr_fpath_tst_L1RTGM();
    @test misr_fpath == "/Volumes/MISR_Data0/P168/L1RTGM/"
# ---------------------------------------------------------- make_misr_fspec
    include(Tools_test * "make_misr_fspec_tst_L1RTGM1.jl")
    misr_fspec = make_misr_fspec_tst_L1RTGM1();
    @test misr_fspec[1] == "/Volumes/MISR_Data0/P168/L1RTGM/MISR_AM1_GRP_TERRAIN_GM_P168_O068050_AN_F03_0024.hdf"

    include(Tools_test * "make_misr_fspec_tst_L1RTGM2.jl")
    misr_fspec = make_misr_fspec_tst_L1RTGM2();
    @test misr_fspec[1] == "my_path/MISR_AM1_GRP_TERRAIN_GM_P168_O068050_AN_F03_0024.hdf"

    include(Tools_test * "make_misr_fspec_tst_L1RCCM.jl")
    misr_fspec = make_misr_fspec_tst_L1RCCM();
    @test misr_fspec == [
        "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_DF_F04_0025.hdf",
        "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_CF_F04_0025.hdf",
        "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_BF_F04_0025.hdf",
        "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_AF_F04_0025.hdf",
        "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_AN_F04_0025.hdf",
        "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_AA_F04_0025.hdf",
        "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_BA_F04_0025.hdf",
        "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_CA_F04_0025.hdf",
        "/Volumes/MISR_Data0/P168/L1RCCM/MISR_AM1_GRP_RCCM_GM_P168_O068050_DA_F04_0025.hdf"]
# ---------------------------------------------------------- make_misrhr_fname
    include(Tools_test * "make_misrhr_fname_tst_L1RCCMmvr.jl")
    misrhr_fname = make_misrhr_fname_tst_L1RCCMmvr();
    @test misrhr_fname == "Data_L1RCCMmvr_cldm_main_R1100_P168+O068050+B110_2012-10-03+2012-10-03+" * Dates.format(today(), "yyyy-mm-dd") * "_F04-0025+v3.0.0.nc"

    include(Tools_test * "make_misrhr_fname_tst_L1RTLM.jl")
    misrhr_fname = make_misrhr_fname_tst_L1RTLM();
    @test misrhr_fname == "Map_L1RTLM_refl_test_R275_P168+O060000-O070000+B110+SITE-SKUKUZA_2011-03-30+2013-02-14+" * Dates.format(today(), "yyyy-mm-dd") * "_F03-0024+v3.0.0.png"
# ---------------------------------------------------------- set_misr_specs
    include(Tools_test * "set_misr_specs_tst_1.jl")
    misr_specs = set_misr_specs_tst_1();
    @test misr_specs.nmodes == 2
    @test misr_specs.mode_names == ["GM", "LM"]
    @test misr_specs.ncameras == 9
    @test misr_specs.camera_names == ["DF", "CF", "BF", "AF", "AN", "AA", "BA", "CA", "DA"]
    @test misr_specs.camera_ids == [1:9]
    @test misr_specs.camera_angles == [70.3, 60.2, 45.7, 26.2, 0.1, 26.2, 45.7, 60.2, 70.6]
    @test misr_specs.nbands == 4
    @test misr_specs.band_names == ["Blue", "Green", "Red", "NIR"]
    @test misr_specs.band_ids == [1:4]
    @test misr_specs.band_positions == [446.4, 557.5, 671.7, 866.4]
    @test misr_specs.nchannels == 36
    @test misr_specs.channel_names == [
        "DF_Blue", "DF_Green", "DF_Red", "DF_NIR",
        "CF_Blue", "CF_Green", "CF_Red", "CF_NIR",
        "BF_Blue", "BF_Green", "BF_Red", "BF_NIR",
        "AF_Blue", "AF_Green", "AF_Red", "AF_NIR",
        "AN_Blue", "AN_Green", "AN_Red", "AN_NIR",
        "AA_Blue", "AA_Green", "AA_Red", "AA_NIR",
        "BA_Blue", "BA_Green", "BA_Red", "BA_NIR",
        "CA_Blue", "CA_Green", "CA_Red", "CA_NIR",
        "DA_Blue", "DA_Green", "DA_Red", "DA_NIR"]
    @test misr_specs.channel_ids == [1:36]
# ---------------------------------------------------------- set_misr_version
    include(Tools_test * "set_misr_version_tst_AGP.jl")
    misr_version = set_misr_version_tst_AGP();
    @test misr_version == "F01_24"

    include(Tools_test * "set_misr_version_tst_L1RTGM.jl")
    misr_version = set_misr_version_tst_L1RTGM();
    @test misr_version == "F03_0024"
# ---------------------------------------------------------- set_mroots
    include(Tools_test * "set_mroots_tst_1.jl")
    mroots = set_mroots_tst_1();
    @test mroots[1] == "/dir/misr"
    @test mroots[2] == "/dir/misrhr"
    @test mroots[3] == "/dir/agp"
    @test mroots[4] == "/dir/scrap"

    include(Tools_test * "set_mroots_tst_2.jl")
    mroots = set_mroots_tst_2();
    @test mroots[1] == "/Volumes/MISR_Data1"
    @test mroots[2] == "/dir/misrhr"
    @test mroots[3] == "/dir/agp"
    @test mroots[4] == "/dir/scrap"

    include(Tools_test * "set_mroots_tst_3.jl")
    mroots = set_mroots_tst_3();
    @test mroots[1] == "ENV[\"MROOT_MISR\"] is not set."
    @test mroots[2] == "ENV[\"MROOT_MISRHR\"] is not set."
    @test mroots[3] == "ENV[\"MROOT_AGP\"] is not set."
    @test mroots[4] == "ENV[\"MROOT_SCRAP\"] is not set."

    include(Tools_test * "set_mroots_tst_4.jl")
    mroots = set_mroots_tst_4();
    @test mroots[1] == "/Volumes/MISR_Data0/"
    @test mroots[2] == "/Volumes/MISRHR/"
    @test mroots[3] == "/Users/michel/Projects/MISR/Data/AGP/"
    @test mroots[4] == "/Users/michel/Projects/MISR/Scrap/"
# ---------------------------------------------------------- split_location
    include(Tools_test * "split_location_tst_NOLOC.jl")
    misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site = split_location_tst_NOLOC();
    @test (misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site) == (0, 0, 0, 0, 0, 0, "")

    include(Tools_test * "split_location_tst_POB.jl")
    misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site = split_location_tst_POB();
    @test (misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site) == (168, 0, 68050, 0, 110, 0, "")

    include(Tools_test * "split_location_tst_PPOOBBS.jl")
    misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site = split_location_tst_PPOOBBS();
    @test (misr_path1, misr_path2, misr_orbit1, misr_orbit2, misr_block1, misr_block2, misr_site) == (168, 170, 68050, 72000, 110, 115, "SITE_SKUKUZA")
# ---------------------------------------------------------- split_misr_fname
    include(Tools_test * "split_misr_fname_tst_AGP.jl")
    misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id = split_misr_fname_tst_AGP();
    @test misr_product_id == "AGP"
    @test misr_prdct_id == "AGP"
    @test misr_mode_id == ""
    @test misr_path_id == 168
    @test misr_orbit_id == 0
    @test misr_camera_id == ""
    @test misr_site_id == ""
    @test misr_version_id == "F01_24"
    @test ext_id == ".hdf"

    include(Tools_test * "split_misr_fname_tst_L1GMP.jl")
    misr_product_id, misr_prdct_id, misr_mode_id, misr_path_id, misr_orbit_id, misr_camera_id, misr_site_id, misr_version_id, ext_id = split_misr_fname_tst_L1GMP();
    @test misr_product_id == "GP_GMP"
    @test misr_prdct_id == "L1GMP"
    @test misr_mode_id == ""
    @test misr_path_id == 168
    @test misr_orbit_id == 68050
    @test misr_camera_id == ""
    @test misr_site_id == ""
    @test misr_version_id == "F03_0013"
    @test ext_id == ".hdf"
# ---------------------------------------------------------- split_misr_fpath
    include(Tools_test * "split_misr_fpath_tst_L1RTGM.jl")
    mroot_misr, misr_path, misr_prdct = split_misr_fpath_tst_L1RTGM();
    @test mroot_misr == "/Volumes/MISR_Data0/"
    @test misr_path == 168
    @test misr_prdct == "L1RTGM"

    include(Tools_test * "split_misr_fpath_tst_L1RCCM.jl")
    mroot_misr, misr_path, misr_prdct = split_misr_fpath_tst_L1RCCM();
    @test mroot_misr == ""
    @test misr_path == 168
    @test misr_prdct == "L1RCCM"
# ---------------------------------------------------------- split_misrhr_fname
    include(Tools_test * "split_misrhr_fname_tst_L1RCCMmvr.jl")
    ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id = split_misrhr_fname_tst_L1RCCMmvr();
    @test ftype_id == "Data"
    @test prdct_id == "L1RCCMmvr"
    @test subprdct_id == "cldm"
    @test qualifier_id == "main"
    @test resolution_id == 1100
    @test misr_path1_id == 168
    @test misr_path2_id == 0
    @test misr_orbit1_id == 68050
    @test misr_orbit2_id == 0
    @test misr_block1_id == 110
    @test misr_block2_id == 0
    @test misr_site_id == ""
    @test strdate1_id == "2012-10-03"
    @test strdate2_id == "2012-10-03"
    @test proc_date_id == "2023-07-13"
    @test misr_version_id == "F04-0025"
    @test misrhr_version_id == "v3.0.0"
    @test ext_id == ".nc"

    include(Tools_test * "split_misrhr_fname_tst_L1RTLM.jl")
    ftype_id, prdct_id, subprdct_id, qualifier_id, resolution_id, misr_path1_id, misr_path2_id, misr_orbit1_id, misr_orbit2_id, misr_block1_id, misr_block2_id, misr_site_id, strdate1_id, strdate2_id, proc_date_id, misr_version_id, misrhr_version_id, ext_id = split_misrhr_fname_tst_L1RTLM();
    @test ftype_id == "Map"
    @test prdct_id == "L1RTLM"
    @test subprdct_id == "refl"
    @test qualifier_id == "test"
    @test resolution_id == 275
    @test misr_path1_id == 168
    @test misr_path2_id == 0
    @test misr_orbit1_id == 60000
    @test misr_orbit2_id == 70000
    @test misr_block1_id == 110
    @test misr_block2_id == 0
    @test misr_site_id == "SITE-SKUKUZA"
    @test strdate1_id == "2011-03-30"
    @test strdate2_id == "2013-02-14"
    @test proc_date_id == "2023-07-14"
    @test misr_version_id == "F03-0024"
    @test misrhr_version_id == "v3.0.0"
    @test ext_id == ".png"
# ---------------------------------------------------------- split_misrhr_fpath
    include(Tools_test * "split_misrhr_fpath_tst_L1B3.jl")
    mroot_misrhr, misr_path, misr_block, misrhr_prdct, misrhr_subprdct = split_misrhr_fpath_tst_L1B3();
    @test mroot_misrhr == "/Volumes/MISRHR/"
    @test misr_path == 168
    @test misr_block == 111
    @test misrhr_prdct == "L1B3"
    @test misrhr_subprdct == ""

    include(Tools_test * "split_misrhr_fpath_tst_TIP.jl")
    mroot_misrhr, misr_path, misr_block, misrhr_prdct, misrhr_subprdct = split_misrhr_fpath_tst_TIP();
    @test mroot_misrhr == "/Volumes/MISRHR/"
    @test misr_path == 168
    @test misr_block == 110
    @test misrhr_prdct == "TIP"
    @test misrhr_subprdct == "GRN"
# ==========================================================================================

end

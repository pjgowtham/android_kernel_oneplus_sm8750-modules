load(":display_modules.bzl", "display_driver_modules")
load(":display_driver_build.bzl", "display_module_entry", "define_target_variant_modules")
load("//vendor/qcom/kernel:target_variants.bzl", "get_all_la_variants")

def define_waipio():
    registry = display_module_entry(display_driver_modules.hdrs)
    for name, module in display_driver_modules.module_map.items():
        registry.register(
            name = name,
            path = module.path,
            config_option = module.config_option,
            srcs = module.srcs,
            config_srcs = module.config_srcs,
            deps = [dep for dep in module.deps if dep != "//vendor/oplus/kernel/device_info/oplus_fpga:oplus_bsp_fpga_monitor"],
            config_deps = module.config_deps,
        )
    for (t, v) in get_all_la_variants():
        if t == "waipio":
            define_target_variant_modules(
                target = t,
                variant = v,
                registry = registry,
                modules = [
                    "msm_drm",
                ],
                config_options = [
                    "OPLUS_FEATURE_DISPLAY",
                    "OPLUS_FEATURE_DISPLAY_ADFR",
                    "OPLUS_FEATURE_DISPLAY_TEMP_COMPENSATION",
                    "OPLUS_FEATURE_DISPLAY_ONSCREENFINGERPRINT",
                    "OPLUS_FEATURE_TP_BASIC",
                    "OPLUS_TRACKPOINT_REPORT",

                    "CONFIG_DRM_MSM_SDE",
                    "CONFIG_SYNC_FILE",
                    "CONFIG_DRM_MSM_DSI",
                    "CONFIG_DRM_MSM_DP",
                    "CONFIG_DSI_PARSER",
                    "CONFIG_DRM_SDE_WB",
                    "CONFIG_DRM_SDE_RSC",
                    "CONFIG_DRM_MSM_REGISTER_LOGGING",
                    "CONFIG_QCOM_MDSS_PLL",
                    "CONFIG_HDCP_QSEECOM",
                    "CONFIG_THERMAL_OF",
                    "CONFIG_MSM_MMRM",
                    "CONFIG_MSM_EXT_DISPLAY"
                ],
            )

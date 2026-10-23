load(":securemsm_kernel.bzl", "define_target_variant_modules")

def define_waipio():
    for variant in ["consolidate", "perf"]:
        define_target_variant_modules(
            target = "waipio",
            variant = variant,
            modules = [
                "smcinvoke_dlkm",
                "tz_log_dlkm",
                "hdcp_qseecom_dlkm",
                "qce50_dlkm",
                "qcedev-mod_dlkm",
                "qrng_dlkm",
                "qcrypto-msm_dlkm",
                "qseecom_dlkm",
                "smmu_proxy_dlkm",
                "seccam_test_driver",
                "hdcp2p2_test",
                "tornado_mod",
            ],
            extra_options = [
                "CONFIG_QCOM_SMCINVOKE",
                "CONFIG_QSEECOM",
            ],
        )

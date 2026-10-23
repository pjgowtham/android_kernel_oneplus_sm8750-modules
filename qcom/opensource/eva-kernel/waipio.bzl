load(":eva_modules.bzl", "eva_modules")
load(":eva_module_build.bzl", "define_target_variant_modules")
load("//vendor/qcom/kernel:target_variants.bzl", "get_all_la_variants")

def define_waipio():
    for target, variant in get_all_la_variants():
        if target == "waipio":
            define_target_variant_modules(
                target = target,
                variant = variant,
                registry = eva_modules,
                modules = ["msm-eva"],
                config_options = [
                    "CONFIG_MSM_EVA",
                    "CONFIG_EVA_WAIPIO",
                    "TARGET_SYNX_ENABLE",
                    "TARGET_DSP_ENABLE",
                    "TARGET_MMRM_ENABLE",
                ],
            )

load("//build/kernel/kleaf:kernel.bzl", "ddk_module")
load("//build/bazel_common_rules/dist:dist.bzl", "copy_to_dist_dir")

def define_waipio_video(variant):
    tv = "waipio_{}".format(variant)
    ddk_module(
        name = "{}_video_driver_modules".format(tv),
        kernel_build = "//vendor/qcom/kernel:{}".format(tv),
        out = "msm_video.ko",
        srcs = native.glob(["waipio/driver/**/*.c", "waipio/driver/**/*.h", "waipio/include/**/*.h"]),
        includes = ['waipio/driver/vidc/inc', 'waipio/driver/platform/common/inc', 'waipio/driver/platform/waipio/inc', 'waipio/driver/variant/iris2/inc', 'waipio/include/uapi/vidc'],
        local_defines = ["CONFIG_MSM_VIDC_WAIPIO", "CONFIG_MSM_VIDC_IRIS2", "CONFIG_MSM_MMRM"],
        deps = [
            "//vendor/qcom/kernel:all_headers",
            "//vendor/qcom/sm8750-modules/qcom/opensource/mmrm-driver:{}_mmrm_driver".format(tv),
        ],
    )
    copy_to_dist_dir(
        name = "{}_video_driver_modules_dist".format(tv),
        data = [":{}_video_driver_modules".format(tv)],
        dist_dir = "out/target/product/waipio/dlkm/lib/modules/",
        flat = True,
        wipe_dist_dir = False,
        allow_duplicate_filenames = False,
        mode_overrides = {"**/*": "644"},
    )

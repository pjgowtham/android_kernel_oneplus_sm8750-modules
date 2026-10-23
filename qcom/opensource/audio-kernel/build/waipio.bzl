load(":audio_modules.bzl", "audio_modules")
load(":module_mgr.bzl", "create_module_registry", "define_target_modules")

def define_waipio():
    # The common registry also serves newer codecs. Keep their dependencies
    # out of the WAIPIO machine and DMIC modules.
    registry = create_module_registry(audio_modules.hdrs)
    newer_codecs = [":%b_wcd939x_dlkm", ":%b_wsa884x_dlkm", ":%b_wcd9378_dlkm"]
    for name, module in audio_modules.module_map.items():
        deps = [dep for dep in module.deps if dep not in newer_codecs]
        if name in ["machine_dlkm", "swr_dmic_dlkm"]:
            deps = deps + [":%b_wcd938x_dlkm"]
        registry.register(
            name = name,
            path = module.path,
            config_option = module.config_option,
            srcs = module.srcs,
            conditional_srcs = module.conditional_srcs,
            deps = deps,
        )
    define_target_modules(
        target = "waipio",
        variants = ["consolidate", "perf"],
        registry = registry,
        modules = [
            "oplus_audio_daemon",
            "oplus_audio_extend",
            "oplus_audio_pa_manager",
            "oplus_audio_netlink",
            "q6_dlkm",
            "spf_core_dlkm",
            "audpkt_ion_dlkm",
            "q6_notifier_dlkm",
            "adsp_loader_dlkm",
            "audio_prm_dlkm",
            "q6_pdr_dlkm",
            "gpr_dlkm",
            "audio_pkt_dlkm",
            "pinctrl_lpi_dlkm",
            "swr_dlkm",
            "swr_ctrl_dlkm",
            "snd_event_dlkm",
            "machine_dlkm",
            "wcd_core_dlkm",
            "mbhc_dlkm",
            "swr_dmic_dlkm",
            "wcd9xxx_dlkm",
            "swr_haptics_dlkm",
            "stub_dlkm",
            "hdmi_dlkm",
            "lpass_cdc_dlkm",
            "lpass_cdc_wsa_macro_dlkm",
            "lpass_cdc_wsa2_macro_dlkm",
            "lpass_cdc_va_macro_dlkm",
            "lpass_cdc_rx_macro_dlkm",
            "lpass_cdc_tx_macro_dlkm",
            "wsa883x_dlkm",
            "wcd938x_dlkm",
            "wcd938x_slave_dlkm",
        ],
        config_options = [
            "CONFIG_SND_SOC_WAIPIO",
            "CONFIG_SND_SOC_MSM_QDSP6V2_INTF",
            "CONFIG_MSM_QDSP6_SSR",
            "CONFIG_DIGITAL_CDC_RSC_MGR",
            "CONFIG_SOUNDWIRE_MSTR_CTRL",
            "CONFIG_WCD9XXX_CODEC_CORE_V2",
            "CONFIG_MSM_CDC_PINCTRL",
            "CONFIG_SND_SOC_WCD_IRQ",
            "CONFIG_SND_SOC_WCD9XXX_V2",
            "CONFIG_SND_SOC_WCD_MBHC_ADC",
            "CONFIG_MSM_EXT_DISPLAY",
            "OPLUS_ARCH_EXTENDS",
            "OPLUS_FEATURE_SPEAKER_MUTE",
            "OPLUS_FEATURE_RINGTONE_HAPTIC",
        ]
    )

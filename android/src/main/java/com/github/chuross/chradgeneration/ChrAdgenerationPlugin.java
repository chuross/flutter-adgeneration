package com.github.chuross.chradgeneration;

import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * ChrAdgenerationPlugin
 */
public class ChrAdgenerationPlugin {

    public static void registerWith(Registrar registrar) {
        registrar.platformViewRegistry()
                .registerViewFactory(AdgBanner.NAME, new AdgBannerFactory(registrar.messenger()));
    }

}

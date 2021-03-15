package com.qlicue.aunty_rafiki

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import com.qlicue.aunty_rafiki.CloudFirestorePluginRegistrant
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback

class Application : FlutterApplication(), PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
    }

    override fun registerWith(registry: PluginRegistry?) {
        if (registry != null) {
            CloudFirestorePluginRegistrant.registerWith(registry)
        }
    }

}
package com.qlicue.aunty_rafiki

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import com.qlicue.aunty_rafiki.CloudFirestorePluginRegistrant
import com.qlicue.aunty_rafiki.CloudFirestorePluginRegistrant

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
    }

    override fun registerWith(registry: PluginRegistry?) {
        if (registry != null) {
            CloudFirestorePluginRegistrant.registerWith(registry)
        }
    }

}
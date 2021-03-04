package com.qlicue.aunty_rafiki

import android.util.Log
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebase.cloudfirestore.CloudFirestorePlugin

class CloudFirestorePluginRegistrant {

companion object {

fun registerWith(registry: PluginRegistry)
{
Log.d("CloudFirestore", "registerWith");

if(alreadyRegisteredWith(registry)) {
Log.d("Already Registered","");
return
}
try {
CloudFirestorePlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.cloudfirestore.CloudFirestorePlugin"))
} catch (e: Exception) {
Log.d("CloudFirestore", e.toString());
}
Log.d("Plugin Registered","");
}

private fun alreadyRegisteredWith(registry: PluginRegistry): Boolean {

val key = CloudFirestorePluginRegistrant::class.java.canonicalName
if (registry.hasPlugin(key)) {
return true
}
registry.registrarFor(key)
return false
}

}
}
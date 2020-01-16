package io.woodemi.notepad_isolate

import android.content.Context
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

private const val TAG = "NotepadIsolatePlugin"

class NotepadIsolatePlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    companion object {
        private val instance by lazy { NotepadIsolatePlugin() }

        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar) {
            instance.onAttachedToEngine(registrar.context(), registrar.messenger())
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        onAttachedToEngine(binding.applicationContext, binding.binaryMessenger)
    }

    private var context: Context? = null
    private var methodChannel: MethodChannel? = null

    fun onAttachedToEngine(applicationContext: Context, messenger: BinaryMessenger) {
        if (methodChannel != null)
            return

        Log.i(TAG, "onAttachedToEngine")
        context = applicationContext
        methodChannel = MethodChannel(messenger, "notepad_isolate/method")
        methodChannel?.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.i(TAG, "onDetachedFromEngine")
        context = null
        methodChannel?.setMethodCallHandler(null)
        methodChannel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.d(TAG, "$this onMethodCall ${call.method}")
        when (call.method) {
            else -> result.notImplemented()
        }
    }
}

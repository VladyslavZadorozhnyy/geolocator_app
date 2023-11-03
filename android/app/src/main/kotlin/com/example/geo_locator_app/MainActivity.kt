package com.example.geo_locator_app

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import org.json.JSONObject


class MainActivity : FlutterActivity() {
    private val channelName = "geolocator_app_channel_name"
    private var initialRun = true;

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GlobalScope.launch {
            MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                channelName,
            ).setMethodCallHandler { call, result ->
                if (call.method == "getLocationFromNative") {
                    getLocationFromNative(result)
                } else {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getLocationFromNative(resultChannel:  MethodChannel.Result) {
        try {
            if (ContextCompat.checkSelfPermission(
                    applicationContext, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this,
                    arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), 101)
            }

            (getSystemService(Context.LOCATION_SERVICE) as? LocationManager)?.getCurrentLocation(
                LocationManager.GPS_PROVIDER,
                null,
                application.mainExecutor
            ) {
                val resultValue = JSONObject().apply {
                    put("longitude", "${it?.longitude ?: "-"}")
                    put("latitude", "${it?.latitude ?: "-"}")
                }.toString()

                resultChannel.success(resultValue)
            }
        } catch (e: Exception) {
            if ((e.message?.contains("does not have android.permission") == true) && initialRun) {
                initialRun = false
                getLocationFromNative(resultChannel)
            }

            val errorResultValue = JSONObject().apply {
                put("error", "${e.message}")
            }.toString()

            resultChannel.success(errorResultValue)
        }
    }
}

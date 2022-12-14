package app.login.ids.native_oauth_ids

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import org.apache.cordova.*
import org.json.JSONArray
import org.json.JSONException

class NativeOauthIds : CordovaPlugin() {
  lateinit var eventSink: CallbackContext
  private lateinit var activity: Activity
  private lateinit var context: Context
  private lateinit var cordovaInterface: CordovaInterface

  override fun initialize(cordova: CordovaInterface, webView: CordovaWebView): Unit {
    super.initialize(cordova, webView)
    cordovaInterface = cordova
    activity = cordova.getActivity()
    context = activity.getApplicationContext()
  }

  @Throws(JSONException::class)
  override fun execute(action: String, data: JSONArray, callbackContext: CallbackContext): Boolean {
    eventSink = callbackContext
    var result = true
    try {
      if (action == "login") {

        val url = data.getString(0)
        if (url == null) {
          handleException("Url Null")
          result = false
        } else {
          LocalBroadcastManager.getInstance(context)
              .registerReceiver(mMessageReceiver, IntentFilter("LOGIN_SUCCESS"))
          startLogin(url ?: "")
          result = true
        }
      } else {
        handleError("Invalid action")
        result = false
      }
    } catch (e: Exception) {
      handleException(e.toString())
      result = false
    }

    return result
  }

  private fun startLogin(url: String) {
    cordovaInterface.getThreadPool().execute(Runnable() {
      fun run() : Unit {
        try {
          val intent = Intent(context, Login::class.java)
          intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
          val b = Bundle()
          b.putString("url", url)
          intent.putExtras(b)
          activity.startActivity(activity, intent, null)
        } catch (Exception e) {
          handleException(e.toString());
        }
      }
    });
  }

  private val mMessageReceiver: BroadcastReceiver =
      object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent) {
          val loginData = intent?.getStringExtra("login_data")
          if (!TextUtils.isEmpty(loginData)) {
            if (loginData != null) {
              eventSink.success(loginData)
              unregisterReceiver()
            } else {
              eventSink.success("")
              unregisterReceiver()
            }
          }
        }
      }

  fun unregisterReceiver() {
    LocalBroadcastManager.getInstance(context).unregisterReceiver(mMessageReceiver)
  }

  /**
   * Handles an error while executing a plugin API method. Calls the registered Javascript plugin
   * error handler callback.
   *
   * @param errorMsg Error message to pass to the JS error handler
   */
  private fun handleError(errorMsg: String) {
    try {
      Log.e(TAG, errorMsg)
      context.error(errorMsg)
    } catch (e: Exception) {
      Log.e(TAG, e.toString())
    }
  }

  private fun handleException(exception: String) {
    handleError(exception)
  }

  companion object {

    protected val TAG = "NativeOauthIds"
  }
}

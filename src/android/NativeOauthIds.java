package nativeoauthids;

import static org.apache.cordova.device.Device.TAG;
import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

public class NativeOauthIds extends CordovaPlugin {
  private CallbackContext eventSink;
  private Activity activity;
  private Context context;
  private CordovaInterface cordovaInterface;

  @Override
  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);
    cordovaInterface = cordova;
    activity = cordova.getActivity();
    context = activity.getApplicationContext();
  }

  @Override
  public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
    eventSink = callbackContext;
    boolean result = true;
    try {
      if (action.equals("login")) {

        String url = data.getString(0);
        if (url == null) {
          handleException("Url Null");
          result = false;
        } else {
          LocalBroadcastManager.getInstance(context)
              .registerReceiver(mMessageReceiver, new IntentFilter("LOGIN_SUCCESS"));
          startLogin(url);
          result = true;
        }
      } else {
        handleError("Invalid action");
        result = false;
      }
    } catch (Exception e) {
      handleException(e.toString());
      result = false;
    }

    return result;
  }

  private void startLogin(String url) {
    cordovaInterface.getThreadPool().execute(new Runnable() {
      @Override
      public void run() {
        try {
          Intent intent = new Intent(context, Login.class);
          intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
          Bundle b = new Bundle();
          b.putString("url", url);
          intent.putExtras(b);
          activity.startActivity(intent, null);
        } catch (Exception e) {
          handleException(e.toString());
        }
      }
    });
  }

  private BroadcastReceiver mMessageReceiver = new BroadcastReceiver() {
    @Override
    public void onReceive(Context context, Intent intent) {
      String loginData = intent.getStringExtra("login_data");
      if (!TextUtils.isEmpty(loginData)) {
        if (loginData != null) {
          eventSink.success(loginData);
          unregisterReceiver();
        } else {
          eventSink.success("");
          unregisterReceiver();
        }
      }
    }
  };

  private void handleException(String exception) {
    handleError(exception);
  }

  private void handleError(String errorMsg) {
    try {
      Log.e(TAG, errorMsg);
      eventSink.error(errorMsg);
    } catch (Exception e) {
      Log.e(TAG, e.toString());
    }
  }

  void unregisterReceiver() {
    LocalBroadcastManager.getInstance(context).unregisterReceiver(mMessageReceiver);
  }

}

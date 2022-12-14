@objc(NativeOauthIds) class NativeOauthIds : CDVPlugin { 
  @objc(coolMethod:) 
  func coolMethod(command: CDVInvokedUrlCommand) { 
    var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR);

    pluginResult = CDVPluginResult(status: CDVCommandStatus_OK); 
    print("The TestPluginSwift test function ran correctly!"); 
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId); 
  }
}
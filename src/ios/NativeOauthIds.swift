@objc(NativeOauthIds) class NativeOauthIds : CDVPlugin,CieIdDelegate { 

  var loginCallbackId: Any;
  var errorResult = CDVPluginResult (status: CDVCommandStatus_ERROR);

  @objc(login:)
  func login(command: CDVInvokedUrlCommand) { 
    loginCallbackId = command.callbackId
    let url = command.arguments[0] as? String ?? ""

      if msg.characters.count > 0 {

        NotificationCenter.default.addObserver(self, selector: #selector(self.onNotification(notification:)), name: Notification.Name(IDNotificationManager.NOTIFICATION_CENTER_NAME), object: nil)
        let path = args[0];
        let cieIDAuthenticator = CieIDWKWebViewController()
        cieIDAuthenticator.modalPresentationStyle = .fullScreen
        cieIDAuthenticator.delegate = self
        cieIDAuthenticator.path = path;

        self.viewController?.presentViewController(
          cieIDAuthenticator,
          animated: true,
          completion: nil
        )

      }else{

        self.commandDelegate!.send(self.errorResult, callbackId: command.callbackId);

      }

    }

  }

  @objc func onNotification(notification: Notification){

      if let dict = notification.userInfo as Dictionary? {

          if(dict["code"] != nil && dict["session_state"] != nil){

              let code = (dict["code"]!) as! String;

              let session_state = (dict["session_state"]!) as! String;

              let msg = "code=\(code)&session_state=\(session_state)";

              pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAsString: msg
              )

              self.commandDelegate!.send(pluginResult, callbackId: loginCallbackId);

          }

      } else {

      }

  }

  func  CieIDAuthenticationClosedWithSuccess() {

  }

  func  CieIDAuthenticationCanceled() {

  }

  func  CieIDAuthenticationClosedWithError(errorMessage: String) {

  }

}
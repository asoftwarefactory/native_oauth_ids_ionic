
@objc(NativeOauthIds) class NativeOauthIds : CDVPlugin,CieIdDelegate {

  var loginCallbackId: String = "";
  var errorResult = CDVPluginResult (status: CDVCommandStatus_ERROR);

  @objc(login:)
  func login(command: CDVInvokedUrlCommand) { 
    loginCallbackId = command.callbackId
    let url = command.arguments[0] as? String ?? ""

      if !url.isEmpty{

        NotificationCenter.default.addObserver(self, selector: #selector(self.onNotification(notification:)), name: Notification.Name(IDNotificationManager.NOTIFICATION_CENTER_NAME), object: nil)
       
        let cieIDAuthenticator = CieIDWKWebViewController()
        cieIDAuthenticator.modalPresentationStyle = .fullScreen
        cieIDAuthenticator.delegate = self
        cieIDAuthenticator.path = url;

        self.viewController?.present(
          cieIDAuthenticator,
          animated: true,
          completion: nil
        )

      }else{

        self.commandDelegate!.send(self.errorResult, callbackId: command.callbackId);

      }

    }
    
    @objc func onNotification(notification: Notification){

        if let dict = notification.userInfo as Dictionary? {

            if(dict["code"] != nil && dict["session_state"] != nil){

                let code = (dict["code"]!) as! String;

                let session_state = (dict["session_state"]!) as! String;

                let msg = "code=\(code)&session_state=\(session_state)";

                let pluginResult = CDVPluginResult(
                  status: CDVCommandStatus_OK,
                  messageAs: msg
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


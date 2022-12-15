var exec = require("cordova/exec");

exports.login = function (url, success, error) {
  exec(success, error, "NativeOauthIds", "onMessageReceived", [url]);
};

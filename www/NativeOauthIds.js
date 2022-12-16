var exec = require("cordova/exec");

function NativeOauthIds() {
  this.channels = {
    login: channel.create("login"),
  };
}

InAppBrowser.prototype.login = function (url, success, error) {
  exec(success, error, "NativeOauthIds", "login", [url]);
};

module.exports = new NativeOauthIds();

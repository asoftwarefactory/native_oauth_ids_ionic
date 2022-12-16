// cordova è definito globalmente

function NativeOauthIds() {
  this.channels = {
    login: channel.create("login"),
  };
}

InAppBrowser.prototype.login = function (url, success, error) {
  cordova.exec(success, error, "NativeOauthIds", "login", [url]);
};

module.exports = new NativeOauthIds();

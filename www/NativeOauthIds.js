(function () {
  /* var exec = require("cordova/exec");
  var channel = require("cordova/channel"); */

  /* function NativeOauthIds() {
    this.channels = {
      login: channel.create("login"),
    };
  }

  NativeOauthIds.prototype.login = function (url, success, error) {
    exec(success, error, "NativeOauthIds", "login", [url]);
  };

  module.exports = new NativeOauthIds(); */

  var exec = require("cordova/exec");
  // var channel = require("cordova/channel");

  var NativeOauthIds = {
    login: function (url, success, error) {
      exec(success, error, "NativeOauthIds", "login", [url]);
    },
  };

  module.exports = NativeOauthIds;
})();

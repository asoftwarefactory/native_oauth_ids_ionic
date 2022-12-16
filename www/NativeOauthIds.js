(function () {
  var exec = require("cordova/exec");
  // var channel = require("cordova/channel");

  var NativeOauthIds = {
    login: function (url, success, error) {
      exec(success, error, "NativeOauthIds", "login", [url]);
    },
  };

  module.exports = NativeOauthIds;
})();

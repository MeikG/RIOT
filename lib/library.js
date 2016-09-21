var path = function () {
  var self = this;

  // Return a properly formatted URL.
  this.url = function (uri) {
    return config.api + uri;
  };

  // Perform an AJAX request to the back-end API.
  this.ajax = {
    request: function (uri, verb, data, cb) {
      var verbs = ['GET', 'POST', 'PATCH', 'DELETE', 'PUT'];
      $.jsonp({
        url: self.url(uri),
        cache: false,
        callbackParameter: 'callback',
        success: function( response ) {
          return cb(null, response);
        },
        error: function() {
          // Assume our error based based on a request to the API's diagnostics endpoint.
          $.jsonp({
            url: self.url('/diagnostics'),
            cache: false,
            callbackParameter: 'callback',
            success: function(response) {
              // Our API is reachable.
              if (response.loggedIn) {
                // The user is logged in, assume the error was in our request.
                RiotControl.trigger('notification_api_error', self.url(uri));
                return cb('apierror');
              } else {
                // Assume the error is because we're not logged in.
                RiotControl.trigger('notification_not_logged_in');
                return cb('notloggedin');
              }
            },
            error: function() {
              // Can't contact the diagnostics endpoint, assume API is down.
              RiotControl.trigger('notification_api_unreachable');
              return cb('apiunreachable');
            }
          });
        }
      });
    },
    get: function (uri, cb) {
      this.request(uri, 'GET', null, function (err, response) {
        if (err) return cb(err);
        return cb(null, response);
      });
    }
  };
};
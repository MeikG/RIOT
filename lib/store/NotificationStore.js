// NotificationStore definition.
function NotificationStore() {
  riot.observable(this);
  var self = this;
  
  // Trigger a notification.
  self.on('new_notification', function(notification) {
    console.log(notification);
    switch (notification.status) {
      case 403:
        console.log('hide');
        // In the case of a forbidden, display the login box.
        $('#modal-login').modal('show');
        break;
      default:
        self.trigger('notifications_updated', notification);
        break;
    }
  });

  self.on('notification_api_unreachable', function () {
    $('#modal-api-error-path').hide();
    $('#modal-api-error-title').text('The OHMS API is unreachable. Please check the server & client configuration.');
    $('#modal-api-error').modal('show');
  });

  self.on('notification_api_error', function (path) {
    $('#modal-api-error-path').show();
    $('#modal-api-error-path').text('Path: ' + path);
    $('#modal-api-error-title').text('The OHMS API has been unable to complete the request above');
    $('#modal-api-error').modal('show');
  });

  self.on('notification_not_logged_in', function () {
    $('#modal-login').modal('show');
  });
}
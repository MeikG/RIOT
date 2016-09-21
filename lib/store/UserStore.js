// RecipeStore definition.
function UserStore() {
  riot.observable(this);  // Riot provides our event emitter.
  var self = this;

  self.user = {
    loggedIn: false,
    username: null,
    preferences: {
      recipeRenderer: 'list'
    }
  };

  // Back-up the default user in case we need to log out.
  self.defaultUser = self.user;

  self.on('userstore_init', function() {
    // A page
    self.trigger('userstore_changed', self.user);
  });


  // When logging out, forget the user data.
  self.on('userstore_logout', function() {
    // TODO: Delete the cookie.
    self.user = self.defaultUser;
    self.trigger('userstore_changed', self.user);
  });

  self.on('userstore_changepref', function(key, value) {
    if (! self.user.preferences.hasOwnProperty(key)) {
      self.user.preferences[key] = value;
      self.trigger('userstore_changed', self.user);
      // TODO: Send AJAX request to update user preferences on back-end:
      // On Success, do nothing. We've already assumed it has worked.
      // On failure, reload the prefs from the back-end.
    }
  });

}
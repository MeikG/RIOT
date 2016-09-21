// RecipeStore definition.
function RecipeStore() {
  riot.observable(this);  // Riot provides our event emitter.
  var self = this;
  
  self.pathArray = [];
  self.recipeArray = [];
  
  // Request an individual recipe from the API.
  const requestRecipes = function (id) {
    path.ajax.get('/meal/' + id, function (err, response) {
      self.recipeArray[response.id] = response;
    });
  };
  
  // Request multiple recipes from a path.
  const requestPath = function (requestPath, cb) {
    // If there's no entry in the store, create a blank record.
    if (!self.pathArray.hasOwnProperty(requestPath)) {
      self.pathArray[requestPath] = {
        path: requestPath,
        recipeCount: null,
        results: []
      };
    }
    var pathEntry = self.pathArray[requestPath];
    // If our path entry is empty, or we've not received
    if (pathEntry.recipeCount === null || pathEntry.results.length < pathEntry.recipeCount) {
      // Calculate pagination based off the results we've already received.
      var pagination = Math.ceil(pathEntry.results.length / config.pagination);
      path.ajax.get('/recipes/' + requestPath + '/' + pagination, function (err, response) {
        if (err) return cb(err);
        // TODO: Replace this with Async or Promises?
        self.pathArray[requestPath].recipeCount = response.countRecipes;
        response.recipes.forEach(function (each) {
          // Refresh the recipes in the store with the latest version.
          self.recipeArray[each.id] = each;
          // Store the ID in the associative array.
          self.pathArray[requestPath].results[each.id] = each.id;
        });
        return cb(null, true);
      });
    } else {
      return cb(null, true);
    }
  };
  
  // Our store's event handlers / API.
  // This is where we would use AJAX calls to interface with the server.
  // Any number of views can emit actions/events without knowing the specifics of the back-end.
  // This store can easily be swapped for another, while the view components remain untouched.
  
  self.on('get_recipes', function(rawPath, requestMore) {
    // Check to see if we've returned these results before.
    const modes = ['random', 'alphabet', 'ingredient', 'search'];
    // If the user requests an illegal path, just return default.
    // TODO: This should be replaced with a default config.
    var path = (modes.indexOf(rawPath) !== -1) ? rawPath : 'alphabet';
    requestPath(path, function () {
      // Clone the array as we're changing values.
      var pathArray = JSON.parse(JSON.stringify(self.pathArray[path]));
      var recipes = pathArray.results;
      pathArray.results = [];
      recipes.forEach(function (each) {
        if (typeof self.recipeArray[each] !== 'undefined') pathArray.results.push(self.recipeArray[each]);
      });
      self.trigger('recipestore_changed', pathArray);
    });
  });

  // Requesting a single recipe.
  self.on('get_single_recipe', function (id) {
    if (typeof self.recipeArray[id] === 'undefined') {
      // TODO: Send AJAX request to the server for this recipe.
      var returnedRecipe = {};
      // Store the recipe, and return it to the user.
      self.recipeArray[id] = returnedRecipe;
      self.trigger('got_recipe', returnedRecipe);
    } else {
      // Recipe is in the store, return that.
      self.trigger('got_recipe', self.recipeArray[id]);
    }
  });

  self.on('add_faux_recipes', function(rawRecipes, count) {
    // Simulate a naff connection.
    setTimeout(function () {
      var recipes = rawRecipes;
      var newRecipeResults = (recipes.recipeCount - recipes.results.length > count ? generateRandomRecipes(count) : generateRandomRecipes(recipes.recipeCount - recipes.results.length));
      // Append new recipes onto the list of already loaded recipes.
      recipes.results = recipes.results.concat(newRecipeResults);
      // Update the store with our new recipes.
      self.pathArray[recipes.path] = recipes;
      self.trigger('recipestore_changed', recipes);
    }, randomNum(2000, 150));
  });
  
  self.on('recipestore_init', function() {
    //self.recipes = generateRandomRecipes(24);
    // Update the UI with our new recipes.
    //self.trigger('recipestore_changed', self.recipes);
  });

  // The store emits change events to any listening views, so that they may react and redraw themselves.
  return this;
}
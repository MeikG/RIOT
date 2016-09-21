<recipes>
  <element-pageheader title = "Recipes"></element-pageheader>
  <article>
    <h1>{  }</h1>
    <div class = "row recipe-btngroup">
      <div id = "btngroup-viewmode" class = "col-xs-8 col-sm-9 col-md-8">
        <div class="btn-group btn-group-padding btn-group-justified" role="group">
          <a href={ path('mode', 'alphabet') } class="btn btn-{ select('mode', 'alphabet') }" role="button"><span class="glyphicon glyphicon-text-background" aria-hidden="true"></span><span class = "hidden-xs"> Alphabetical</span></a>
          <a href={ path('mode', 'random') } class="btn btn-{ select('mode', 'random') }" role="button"><span class="glyphicon glyphicon-fire" aria-hidden="true"></span><span class = "hidden-xs"> Random</span></a>
          <a href={ path('mode', 'ingredient') } class="btn btn-{ select('mode', 'ingredient') }" role="button"><span class="glyphicon glyphicon-apple" aria-hidden="true"></span><span class = "hidden-xs"> Ingredient</span></a>
          <a href={ path('mode', 'search') } class="btn btn-{ select('mode', 'search') }" role="button"><span class="glyphicon glyphicon-search" aria-hidden="true"></span><span class = "hidden-xs"> Search</span></a>
        </div>
      </div>

      <div id = "btngroup-viewstyle" class = "col-xs-4 col-sm-3 col-sm-offset-0 col-md-2 col-md-offset-2">
        <div class="btn-group btn-group-justified" role="group">
          <a href={ path('view', 'grid') } class="btn btn-{ select('view', 'grid') }" role="button"><span class="glyphicon glyphicon-th" aria-hidden="true"></span><span class = "hidden-xs hidden-sm"> Icons</span></a>
          <a href={ path('view', 'list') } class="btn btn-{ select('view', 'list') }" role="button"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span><span class = "hidden-xs hidden-sm"> List</span></a>
        </div>
      </div>
    </div>

    <span riot-tag="element-renderer-recipes-{ renderer }"></span>
    <div class = "row">

    </div>
    <div id = "loading">Loading Recipes...</div>
  </article>

  <script>
    var self = this;
    // When the page is mounted, we need to do several things:
    this.on('mount', function() {
      // When the page is mounted, get our recipes.
      var renderer = 'grid';
      const query = riot.route.query();
      if (query.view === "list" || query.view === "grid") {
        renderer = query.view;
      }
      // When our recipe store notifies the page that the recipestore has changed, remount our renderer with the new results.
      RiotControl.on('recipestore_changed', function (recipes) {
        riot.mount('element-renderer-recipes-' + self.renderer, {recipes: recipes.results});
        // If we've got more recipes to request, add an event listener to load more on scroll.
        console.log(recipes);
        if (recipes.results.length < recipes.recipeCount) {
          document.addEventListener('scroll', loadrecipes, false);
        } else {
          // If we've hit the number of recipes, remove the event listener on scroll.
          document.removeEventListener('scroll', loadrecipes, false);
          $('#loading').hide();
        }
      });

      // Update this tag with highlighting for the UI.
      self.update({
        renderer,
        select: function (key, value) {
          var query = riot.route.query();
          if (key === 'mode' && value === 'alphabet' && typeof query.mode === 'undefined') return 'ohms';
          if (key === 'view' && value === 'grid' && typeof query.view === 'undefined') return 'ohms';
          if (query[key] === value) return 'ohms';
          return 'default';
        },
        path: function (key, value) {
          var query = riot.route.query();
          query[key] = value;
          return '?' + $.param(query);
        }
      });
      // Trigger the recipe store that we want the recipes for this mode.
      RiotControl.trigger('get_recipes', query.mode, false);
    });

    // When this tag is unmounted, remove the scroll event listener, and we no longer wish to see when the recipestore is updated.
    this.on('unmount', function() {
      document.removeEventListener('scroll', loadrecipes, false);
      RiotControl.off('recipestore_changed');
    });


  </script>

  <style scoped>
    .align-right {
      text-align: right;
    }
    .btn-group-padding {
      padding-bottom: 7px;
    }
    .recipe-btngroup {
      margin-bottom: 50px;
    }

    #loading {
      border: 2px dashed #ccc;
      font-size: x-large;
      padding: 5px;
      color: #ccc;
      text-align: center;
    }
  </style>
</recipes>
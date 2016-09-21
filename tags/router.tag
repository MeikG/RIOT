<app-main>
  <span riot-tag="{ tag }"></span>

  <script>
    var self = this;

    riot.route(function(collection, id, action) {
      const page = collection || 'homepage';
      self.update({
        tag: page,
      });
      const mount = riot.mount(page, {id, action});
      // TODO: If the page can't be loaded, show a pretty error page.
      if (mount.length === 0) {
        self.update({
          tag: 'error-404',
        });
        riot.mount('error-404');
      }
    });
  </script>

  <style scoped>
    .no-margin {
    margin: 0px;
    }
    .no-padding {
    padding: 0px;
    }
    .mobile-spacer {
      display: block;
      width: 50px;
      height: 100%;
    }
    .content {
      width: 100%;
    }
  </style>
</app-main>

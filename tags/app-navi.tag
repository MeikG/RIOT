<app-navi xmlns:active="http://www.w3.org/1999/xhtml">
  <!-- Page logo & navigation -->
  <div class = "top-logo hidden-xs visible-sm visible-md visible-lg">
    <img src="/img/logo.png" alt="OHMS" height="150" width="20">
  </div>
  <div class = "top-text visible-xs hidden-sm hidden-md hidden-lg">
    <span>OHMS</span>
  </div>
  <a each = { links } href="/{ url }" class="{ selected: parent.selectedId === url}">
    <span class="glyphicon glyphicon-{ name }"></span>
  </a>
  <script>
    var self = this;
    this.links = [
      { name: 'home', url: '', tabName: 'Home'},
      { name: "list-alt", url: "recipes", tabName: "Recipes" },
      { name: "equalizer", url: "planner", tabName: "Meal Planner" }
    ];
    var r = riot.route.create();
    r(highlightCurrent);

    /*  Highlight the currently selected controller.
     *
     *  @param {string} controller  Current controller from the route.
     *  @return {void}              Updates the DOM.
     */
    function highlightCurrent(controller) {
      self.update({
        selectedId: controller
      });
    }
  </script>

  <style scoped>
    :scope {
      text-align: center;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      box-sizing: border-box;
      font-family: sans-serif;
      display: inline-flex;
      color: #666;
      background: #333;
      border-bottom: 2px solid #903681;
    }
    .top-text {
      box-sizing: border-box;
      line-height: 50px;
      padding: 0 .8em;
      width: 100%;
      display: inline-block;
      text-align: left;
    }

    a {
      box-sizing: border-box;

      height: 50px;
      line-height: 50px;
      padding: 0 .8em;
      color: white;
      text-decoration: none;
      background: #444;
      width: 70px;
      display: inline-block;
    }

    @media( min-width:768px){
      :scope {
        display: block;
        height: 100%;
        width: 50px;
        border-bottom: 0;
      }
      a {
        width: 100%;
        display: block;
      }
      a:hover {
        background: #666;
      }
    }

    a:active, a:visited, a:hover{
      color: white;
    }
    a.selected {
      background: #660066;
    }
    .top-logo {
      margin-top: 30px;
      margin-bottom: 30px;
    }
  </style>
</app-navi>
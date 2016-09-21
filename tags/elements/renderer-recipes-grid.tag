<element-renderer-recipes-grid>
  <div class = "row">
    <div each = { opts.recipes } class = "col-xs-12 col-sm-4 col-md-2">
      <a href = "/meal/{ recipeName }/{ id }">
        <div class = "recipe-box">
          <div class = "col-xs-12 col-sm-4 col-md-2 image-box">
            <img src="https://upload.wikimedia.org/wikipedia/commons/3/31/Schloss_Kalbeck_mit_Garten.jpg" width="99.5%" height="200px">
          </div>
          <div class = "col-xs-12 col-sm-4 col-md-2 image-box image-gradient">
            <img src="/img/gradient.png" width="99.5%" height="150px">
          </div>
          <div>
            <p class = "recipeTitle">{ recipeName }</p>
          </div>
        </div>
      </a>
    </div>
  </div>

  <style scoped>
    .image-box {
      position: absolute;
      z-index: -1;
      left: 0;
      top: 0;
      opacity: 1;
    }
    .recipe-box {
      border: 2px solid #ccc;
      padding: 5px;
      display: table;
      margin-bottom: 30px;
      height: 200px;
      color: #666;
      cursor: pointer;
      transition: border .2s, color .2s;
      width: 100%
    }

    .recipe-box:hover {
      border: 2px solid #660066;
      color: #000;
    }

    .image-gradient{
      top: 50px;
      opacity: 0.7;
    }

    .recipe-box:hover .image-gradient{
      opacity: 1;
      transition: opacity .2s;
    }

    .recipe-box > div {
      display: table-cell;
      width: 100%;
      vertical-align: bottom;
    }
    .recipeTitle {
      font-size: large;
      margin-bottom: 5px;
      text-align: center;
      max-height: 180px;
      overflow: hidden;
    }

    a, a:hover {
      color: #444;
      text-decoration: none;
    }
  </style>
</element-renderer-recipes-grid>
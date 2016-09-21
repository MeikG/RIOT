<element-renderer-recipes-list>
  <div class = "row">
    <div class = "col-xs-12 col-sm-6 col-md-" each = { opts.recipes }>
      <div class = "recipes-box">
        <p>{ recipeName }</p>
      </div>
    </div>
  </div>

  <style scoped>
    .recipes-box {
      border: 2px solid #ccc;
      padding: 10px;
      display: table;
      margin-bottom: 5px;
      height: 65px;
      color: #666;
      cursor: pointer;
      width: 100%;
      transition: border .2s, color .2s, padding-left .2s;
      text-align: left;
      max-height: 65px;
      overflow: hidden;
    }

    .recipes-box:hover {
      padding-left: 20px;
      border: 2px solid #660066;
      color: #000;
    }

    .recipes-box > p {
      display: table-cell;
      vertical-align: middle;
      margin: 5px;
      text-align: left;
    }
  </style>
</element-renderer-recipes-list>
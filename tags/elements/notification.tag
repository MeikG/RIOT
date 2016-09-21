<element-notification>
  <div class="modal fade" id="modal-api-error" tabindex="-1" role="dialog" aria-labelledby="login">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">OHMS API Error</h4>
        </div>
        <div class="modal-body">
          <p>OHMS has encountered an error:<br>
            <div class = "well well-sm">
              <samp id="modal-api-error-path"></samp><br>
              <samp id="modal-api-error-title"></samp>
            </div>
          </p>
          <p>Please notify { webadmin.name } (website administrator) at <a href="mailto: { webadmin.email }">{ webadmin.email }</a>.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Dismiss</button>
        </div>
      </div>
    </div>
  </div>

  <script>
    // Update the tag's text with details from the configuration.
    this.webadmin = config.webadmin;
  </script>
</element-notification>
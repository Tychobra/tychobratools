
function loading_button(id, style, loading_text, loading_style, label) {
  
  // Allow Shiny session to start
  $(document).on('shiny:sessioninitialized', function() {
    // Set initial button style
    var target = $('#loading_button-' + id);
    target.attr('style', style);   
  });
  
  // Disable button & change text
  $(document).on('click', '#loading_button-' + id, function() {
    Shiny.setInputValue(id, true, { priority: 'event' });
    $(this).attr('disabled', true);
    $(this).html('<i class="fas fa-spinner fa-spin"></i> ' + loading_text);
    $(this).attr('style', loading_style);
  });
  
  // Reset button to original state
  Shiny.addCustomMessageHandler('reset_loading_button', function(message) {
    $('#loading_button-' + message.id).attr('disabled', false);
    $('#loading_button-' + message.id).html(label);
    $('#loading_button-' + message.id).attr('style', style);
  });
}


function loading_button(id, label, class_name, style, loading_label, loading_class, loading_style) {

  var btn_value = 0

  // Allow Shiny session to start
  $(document).on('shiny:sessioninitialized', function() {

    var target = $('#loading_button-' + id);

    // set the initial loading button value
    Shiny.setInputValue(id, btn_value, { priority: 'event' });
  });

  // Disable button & change text
  $(document).on('click', '#loading_button-' + id, function() {
    // increment the button value by 1.  This is consistent with how `shiny::actionButton`
    // value works.
    btn_value = btn_value + 1
    Shiny.setInputValue(id, btn_value, { priority: 'event' });

    var loading_button = $(this)

    loading_button.attr('disabled', true);
    loading_button.html('<i class="fas fa-spinner fa-spin"></i> ' + loading_label);
    loading_button.attr('style', loading_style);
    loading_button.removeClass(class_name);
    loading_button.addClass(loading_class);
  });

  // Reset button to original state
  Shiny.addCustomMessageHandler('reset_loading_button', function(message) {

    var loading_button = $('#loading_button-' + message.id)

    loading_button.attr('disabled', false);
    loading_button.html(label);
    loading_button.attr('style', style);
    loading_button.removeClass(loading_class);
    loading_button.addClass(class_name);
  });
}

#' loading_button
#'
#' Button that becomes disabled until reset w/ `reset_loading_button`
#'
#' @param id the flipbox id
#' @param label the button text (label)
#' @param style style for button (pre-loading); character string w/ CSS styling format: "color: black; background-color: red;"
#' @param loading_text text to show after button is clicked (e.g. during loading)
#' @param loading_style style for button (while loading); character string w/ CSS styling format: "color: black; background-color: red;"
#'
#' @export
#'
#' @importFrom htmltools tags
#' @family flip_box functions

loading_button <- function(id, 
                           label,
                           style = NULL,
                           loading_text = "Loading...",
                           loading_style = NULL
) {
  
  htmltools::tagList(
    tags$button(
      id = paste0("loading_button-", id),
      class = "btn btn-primary",
      label
    ),
    tagList(
      shiny::singleton(
        tags$head(
          # Used personalized kit from FA
          tags$script(
            src = "https://kit.fontawesome.com/fb4611ff56.js"
          ),
          tags$style(
            paste0(
              "
              .custom_button {",
              style,
              "}
              
              .loading {
                color: #fff;
                background-color: grey;
                border-color: grey;
              }
              
              .custom_loading {",
              loading_style,
              "}
              "
            )
          ),
          tags$script(
            if (!is.null(style)) {
              paste0(
                "$(function() {
                  $('#loading_button-", id, "').removeClass('btn-primary');
                  $('#loading_button-", id, "').addClass('custom_button');
                });
                "
              )
            }
          ),
          # Script for disabling button & changing text
          tags$script(
            if (!is.null(style) && !is.null(loading_style)) {
              # browser()
              HTML(
                paste0(
                  "$(function() {
                    $('#loading_button-", id, "').click(function() {
                      Shiny.setInputValue('", id, "', true, { priority: 'event' });
                      $(this).attr('disabled', true);
                      $(this).html('<i class=", '"fas fa-spinner fa-spin">', "</i> ", loading_text, "');
                      $(this).removeClass('custom_button');
                      $(this).addClass('custom_loading');
                      debugger;
                    });
                  });"
                )
              )
            } else if (!is.null(style) && is.null(loading_style)) {
              HTML(
                paste0(
                  "$(function() {
                    $('#loading_button-", id, "').click(function() {
                      Shiny.setInputValue('", id, "', true, { priority: 'event' });
                      $(this).attr('disabled', true);
                      $(this).html('<i class=", '"fas fa-spinner fa-spin">', "</i> ", loading_text, "');
                      $(this).removeClass('custom_button');
                      $(this).addClass('loading');
                      debugger;
                    });
                  });"
                )
              )  
            } else if (!is.null(loading_style) && is.null(style)) {
              HTML(
                paste0(
                  "$(function() {
                    $('#loading_button-", id, "').click(function() {
                      Shiny.setInputValue('", id, "', true, { priority: 'event' });
                      $(this).attr('disabled', true);
                      $(this).html('<i class=", '"fas fa-spinner fa-spin">', "</i> ", loading_text, "');
                      $(this).removeClass('btn-primary');
                      $(this).addClass('custom_loading');
                      debugger;
                    });
                  });"
                )
              )
            } else {
              HTML(
                paste0(
                  "$(function() {
                    $('#loading_button-", id, "').click(function() {
                      Shiny.setInputValue('", id, "', true, { priority: 'event' });
                      $(this).attr('disabled', true);
                      $(this).html('<i class=", '"fas fa-spinner fa-spin">', "</i> ", loading_text, "');
                      $(this).removeClass('btn-primary');
                      $(this).addClass('loading');
                    });
                  });"
                )
              )
            }
          ),
          # Script for resetting button
          tags$script(
            if (!is.null(style) && !is.null(loading_style)) {
              paste0(
                "Shiny.addCustomMessageHandler('reset_loading_button', function(message) {
                  $('#loading_button-' + message.id).attr('disabled', false);
                  $('#loading_button-' + message.id).html('", label, "');
                  $('#loading_button-' + message.id).removeClass('custom_loading');
                  $('#loading_button-' + message.id).addClass('custom_button');
                });"
              )
            } else if (!is.null(style) && is.null(loading_style)) {
              paste0(
                "Shiny.addCustomMessageHandler('reset_loading_button', function(message) {
                  $('#loading_button-' + message.id).attr('disabled', false);
                  $('#loading_button-' + message.id).html('", label, "');
                  $('#loading_button-' + message.id).removeClass('loading');
                  $('#loading_button-' + message.id).addClass('custom_button');
                });"
              )
            } else if (!is.null(loading_style) && is.null(style)) {
              paste0(
                "Shiny.addCustomMessageHandler('reset_loading_button', function(message) {
                  $('#loading_button-' + message.id).attr('disabled', false);
                  $('#loading_button-' + message.id).html('", label, "');
                  $('#loading_button-' + message.id).removeClass('custom_loading');
                  $('#loading_button-' + message.id).addClass('btn-primary');
                });"
              )
            } else {
              paste0(
                "Shiny.addCustomMessageHandler('reset_loading_button', function(message) {
                  $('#loading_button-' + message.id).attr('disabled', false);
                  $('#loading_button-' + message.id).html('", label, "');
                  $('#loading_button-' + message.id).removeClass('loading');
                  $('#loading_button-' + message.id).addClass('btn-primary');
                });"
              )
            }
          )
        )
      )
    )
  )
}

reset_loading_button <- function(id, session = shiny::getDefaultReactiveDomain()) {
  
  session$sendCustomMessage(
    'reset_loading_button', 
    message = list(
      id = session$ns(id)
    )
  )
}

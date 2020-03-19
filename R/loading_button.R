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
                           style = "color: #FFFFFF; background-color: #337AB7; border-color: #2E6DA4;",
                           loading_text = "Loading...",
                           loading_style = "color: #FFFFFF; background-color: grey; border-color: grey;"
) {
  
  htmltools::tagList(
    tags$button(
      id = paste0("loading_button-", id),
      class = "btn style",
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
              .style {",
              style,
              "}
              
              .loading_style {",
              loading_style,
              "}
              "
            )
          ),
          # Script for disabling button & changing text
          tags$script(
            HTML(
              paste0(
                "$(function() {
                  $('#loading_button-", id, "').click(function() {
                    Shiny.setInputValue('", id, "', true, { priority: 'event' });
                    $(this).attr('disabled', true);
                    $(this).html('<i class=", '"fas fa-spinner fa-spin">', "</i> ", loading_text, "');
                    $(this).removeClass('style');
                    $(this).addClass('loading_style');
                    debugger;
                  });
                });"
              )
            )
          ),
          # Script for resetting button
          tags$script(
            paste0(
              "Shiny.addCustomMessageHandler('reset_loading_button', function(message) {
                $('#loading_button-' + message.id).attr('disabled', false);
                $('#loading_button-' + message.id).html('", label, "');
                $('#loading_button-' + message.id).removeClass('loading_style');
                $('#loading_button-' + message.id).addClass('style');
              });"
            )
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


#' loading_button
#'
#' Button that becomes disabled until reset w/ `reset_loading_button`
#'
#' @param id the flipbox id
#' @param label the button text (label)
#'
#' @export
#'
#' @importFrom htmltools tags
#' @family flip_box functions
loading_button <- function(id, 
                           label,
                           loading_text = "Loading...",
                           loading_color = "grey"
) {
  
  htmltools::tagList(
    tags$button(
      id = paste0("loading_button-", id),
      class = "btn",
      label
    ),
    tagList(
      shiny::singleton(
        tags$head(
          tags$style(
            paste0(
              "
              #loading_button-", id, " {
                color: #fff;
                background-color: #337ab7;
                border-color: #2e6da4;
              }
              
              .loading {
                color: #fff;
                background-color: ", loading_color, ";
                border-color: ", loading_color, ";
              }
              "
            )
          ),
          # Script for disabling button & changing text
          tags$script(
            paste0(
              "$(function() {
              
                $('#loading_button-", id, "').click(function() {
                  Shiny.setInputValue('", id, "', true, { priority: 'event' });
                  $(this).attr('disabled', true);
                  $(this).html('", loading_text, "');
                  $(this).css({'background-color': '", loading_color, "', 'border-color': '", loading_color, "'});
                });
              });"
            )
          ),
          # Script for resetting button
          tags$script(
            paste0(
              "Shiny.addCustomMessageHandler('reset_loading_button', function(message) {
                $('#loading_button-' + message.id).attr('disabled', false);
                $('#loading_button-' + message.id).html('", label, "');
                $('#loading_button-' + message.id).css({'color': '#fff', 'background-color': '#337ab7', 'border-color': '#2e6da4'});
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


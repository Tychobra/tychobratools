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
                           class = 'btn',
                           style = "color: #FFFFFF; background-color: #337AB7; border-color: #2E6DA4;",
                           loading_text = "Loading...",
                           loading_style = "color: #FFFFFF; background-color: grey; border-color: grey;"
) {
  
  htmltools::tagList(
    tags$button(
      id = paste0("loading_button-", id),
      class = class,
      label
    ),
    tagList(
      tags$head(
        shiny::singleton(
          # Used personalized kit from FA
          tags$script(
            src = "https://kit.fontawesome.com/fb4611ff56.js"
          )
        ),
        tags$script(paste0("loading_button('", id, "', '", style, "', '", loading_text, "', '", loading_style, "', '", label, "')"))
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


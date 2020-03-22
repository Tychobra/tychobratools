#' loading_button
#'
#' Button that becomes disabled until reset w/ `reset_loading_button`
#'
#' @param id the input id
#' @param label the button text (label)
#' @param class the class(es) to apply to the button
#' @param style style for button (pre-loading); character string w/ CSS styling format: "color: black; background-color: red;"
#' @param loading_label text to show after button is clicked (e.g. during loading)
#' @param loading_class the loading button css class(es).
#' @param loading_style style for button (while loading); character string w/ CSS styling format: "color: black; background-color: red;"
#'
#' @export
#'
#' @importFrom htmltools tags tagList singleton
#'
loading_button <- function(id,
                           label,
                           class = "btn",
                           style = "color: #FFFFFF; background-color: #337AB7; border-color: #2E6DA4;",
                           loading_label = "Loading...",
                           loading_class = "btn",
                           loading_style = "color: #FFFFFF; background-color: grey; border-color: grey;"
) {

  htmltools::tagList(
    tags$button(
      id = paste0("loading_button-", id),
      class = class,
      style = style,
      label
    ),
    htmltools::singleton(
      # Used personalized kit from FA
      tags$script(src = "https://kit.fontawesome.com/fb4611ff56.js")
    ),
    htmltools::singleton(
      tags$script(src = "tychobratools/loading_button.js")
    ),
    tags$script(paste0(
      "loading_button('", id, "', '", label, "', '", class, "', '", style, "', '",
      loading_label, "', '", loading_class, "', '", loading_style, "')"
    ))
  )
}


#' reset_loading_button
#'
#' Reset the `loading_button` to its original style
#'
#' @param id the input id
#' @param session the shiny session
#'
#' @export
#'
#' @importFrom shiny getDefaultReactiveDomain
#'
reset_loading_button <- function(id, session = shiny::getDefaultReactiveDomain()) {

  session$sendCustomMessage(
    'reset_loading_button',
    message = list(
      id = session$ns(id)
    )
  )
}


#' url_to_link
#'
#' convert a url to a link in html
#'
#' @param url the string of the url
#' @param base_link boolean. If `TRUE` the basename of the url
#' will be displayed in the link.  If `FALSE`, the full url will
#' be displayed in the link
#'
#' @return the html for the link
#'
#' @examples
#' url_to_link("https://tychobra.com/howdy")
#'
url_to_link <- function(url, base_link = TRUE) {
  if (base_link == TRUE) {
    link_name <- basename(url)
  } else {
    link_name <- url
  }


  link_out <- ifelse(
    is.na(link_name),
    NA_character_,
    paste0(
      "<a href=", url, " target='_blank'>",
      link_name, "</a>"
    )
  )


  link_out
}

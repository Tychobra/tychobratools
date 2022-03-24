#' Use Tychobra Github Labels
#'
#' Apply Tychobra Specific Github Labels to a Repository.
#'
#' @return invisibly returns \code{data.frame} of github labels
#' @export
#'
#' @importFrom usethis use_github_labels
use_tychobra_gh_labels <- function() {

  # adjust colors
  colors <- gsub("#", "", c(tychobra_gh_labels$color))
  names(colors) <- tychobra_gh_labels$label

  usethis::use_github_labels(
    labels = tychobra_gh_labels$label,
    colours = colors,
    descriptions = tychobra_gh_labels$description
  )

  invisible(return(tychobra_gh_labels))

}


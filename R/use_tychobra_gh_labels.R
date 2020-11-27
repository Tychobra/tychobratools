#' Use Tychobra Github Labels
#'
#' Apply Tychobra Specific Github Labels to a Repository.
#'
#' @inheritDotParams usethis::use_github_labels
#'
#' @return invisibly returns \code{data.frame} of github labels
#' @export
#'
#' @importFrom usethis use_github_labels
use_tychobra_gh_labels <- function(...) {

  usethis::use_github_labels(
    labels = tychobra_gh_labels$name,
    colours = tychobra_gh_labels$color,
    descriptions = tychobra_gh_labels$description,
    ...
  )

  invisible(return(tychobra_gh_labels))

}


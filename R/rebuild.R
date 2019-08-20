#' rebuild
#'
#' Builds and installs your package, then restarts R
#'
#' @importFrom devtools build install
#' @importFrom utils sessionInfo
#' @importFrom startup restart
#'
#' @export
#'
rebuild <- function() {
  devtools::build()
  devtools::install()

  if (!is.null(utils::sessionInfo()$otherPkgs)) {
    lapply(
      paste0('package:', names(utils::sessionInfo()$otherPkgs)),
      detach,
      character.only=TRUE,
      unload=TRUE
    )
  }

  startup::restart()
}


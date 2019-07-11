#' rebuild
#'
#' Builds and installs your package, then restarts R
#'
#' @importFrom devtools build install
#'
#' @export
#'
rebuild <- function() {
  devtools::build()
  devtools::install()

  if (!is.null(sessionInfo()$otherPkgs)) {
    lapply(
      paste0('package:', names(sessionInfo()$otherPkgs)),
      detach,
      character.only=TRUE,
      unload=TRUE
    )
  }

  .rs.restartR()
}


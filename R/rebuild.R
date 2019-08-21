#' rebuild
#'
#' Builds and installs your package, then restarts R
#'
#' @param detach_packages boolean - `TRUE` by default.  Whether or not to detatch all attached packages other than
#' base packages
#' @param clear_global_env boolean - `TRUE` by default. Whether or not to clear the global environment.
#'
#' @importFrom devtools build install
#' @importFrom utils sessionInfo
#' @importFrom rstudioapi restartSession
#'
#' @export
#'
#'
rebuild <- function(detach_packages = TRUE, clear_global_env = TRUE) {
  devtools::build()
  devtools::install()


  if (isTRUE(detach_packages) && !is.null(utils::sessionInfo()$otherPkgs)) {

    lapply(
      paste0('package:', names(utils::sessionInfo()$otherPkgs)),
      detach,
      character.only=TRUE,
      unload=TRUE
    )
  }

  if (isTRUE(clear_global_env) ) {

    rm(list = ls())
  }

  rstudioapi::restartSession()
}


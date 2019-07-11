#' rebuild
#' 
#' Builds and installs your package, then restarts R
#' 
#' @export
#'
rebuild <- function() {
  devtools::build()
  devtools::install()
  
  invisible(lapply(
    paste0('package:', names(sessionInfo()$otherPkgs)),
    detach,
    character.only=TRUE,
    unload=TRUE)
  )
  
  .rs.restartR()
}


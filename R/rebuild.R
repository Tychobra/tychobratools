#' rebuild
#' 
#' Builds and installs your package, then restarts R
#' 
#' @export
#'
rebuild <- function() {
  devtools::build()
  devtools::install()
  
  .rs.restartR()
  
  invisible(lapply(
    paste0('package:', names(sessionInfo()$otherPkgs)),
    detach,
    character.only=TRUE,
    unload=TRUE)
  )
}


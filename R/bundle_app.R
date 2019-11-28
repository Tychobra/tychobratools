#' bundle_app
#'
#' creates a tar ball for the app in "packrat/bundles/" using `packrat`
#'
#' @param path to the the root directory of the app. defaults to the working directory
#'
#' @importFrom packrat snapshot bundle
#'
#' @export
#'
bundle_app <- function(path = ".") {
  app_dir <- normalizePath(path)
  app_name <- basename(app_dir)
  app_tar <- paste0(app_name, ".tar.gz")

  # directory to store app bundle
  app_tar_dir <- file.path(app_dir, "packrat/bundles")
  # app bundle file name
  app_tar_path <- file.path(app_tar_dir, app_tar)

  if (!dir.exists(app_tar_dir)) {
    dir.create(app_tar_dir)
  }

  # snapshot and bundle app
  cat("creating app snapshot...")
  packrat::snapshot(project = app_dir)
  cat(" DONE")

  cat("bundling app... ")
  if (file.exists(app_tar_path)) {
    file.remove(app_tar_path)
  }

  packrat::bundle(
    project = app_dir,
    file = app_tar_path,
    include.bundles = FALSE
  )
  cat(" DONE")
}

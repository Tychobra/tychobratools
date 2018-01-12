#' loads bootstrap 4 dependencies in Shiny app
#'
#' @export
#'
use_bootstrap_4 <- function() {
  tagList(
    suppressDependencies("bootstrap"),
    tags$link(
      rel="stylesheet",
      href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css",
      integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy",
      crossorigin="anonymous"
    ),
    tags$script(
      src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js",
      integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q",
      crossorigin="anonymous"
    ),
    tags$script(
      src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js",
      integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4",
      crossorigin="anonymous"
    )
  )
}

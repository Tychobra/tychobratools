#' Database connection module
#'
#' connect to the db
#'
#' @param db_config database configuration
#' @param db_driver database driver
#'
#' @importFrom RPostgres Postgres
#' @importFrom DBI dbConnect dbDisconnect
#' @importFrom shiny onStop
#'
#' @export
#'
#' @return a DBIConnect object
#'
db_connect <- function(db_config, db_driver = RPostgres::Postgres()) {

  if (is.null(db_config)) {
    stop("Missing or invalid config file")
  } else {
    conn <- DBI::dbConnect(
      db_driver,
      dbname =  db_config$dbname,
      user = db_config$user,
      host = db_config$host,
      password = db_config$password
    )

    # make sure we disconnect the database connection when the session ends
    try({
      shiny::onStop(function() {
        DBI::dbDisconnect(conn)
      })
    })

  }

  conn
}

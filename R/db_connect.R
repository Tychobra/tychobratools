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


  conn
}


#' Database connection pool module
#'
#' create a database connection pool
#'
#' @param db_config database configuration
#' @param db_driver database driver
#'
#' @importFrom RPostgres Postgres
#' @importFrom pool dbPool poolClose
#' @importFrom shiny onStop
#'
#' @export
#'
#' @return a database pool
#'
db_pool <- function(db_config, db_driver = RPostgres::Postgres()) {

  pool <- pool::dbPool(
    db_driver,
    dbname =  db_config$dbname,
    user = db_config$user,
    host = db_config$host,
    password = db_config$password
  )

  # make sure we disconnect the database connection when the session ends
  try({
    shiny::onStop(function() {
      pool::poolClose(conn)
    })
  })

  pool
}

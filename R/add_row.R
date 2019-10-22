#' insert a row into a table
#'
#' @param conn the `DBI` connection
#' @param tbl_name the name of the table in the database
#' @param .dat a named list where the name is the database table field name and
#' the each value is of length 1 and is the value for the field
#'
#' @importFrom DBI sqlInterpolate dbExecute
#'
#' @return the number of rows affected or an error
#'
#' @export
#'
#' @examples
#' con <- DBI::dbConnect(
#'   RSQLite::SQLite(),
#'   dbname = ":memory:"
#' )
#'
#' DBI::dbWriteTable(
#'   con,
#'   name = "test",
#'   value = data.frame(
#'     id = 1:2,
#'     data_col = rep("hi", times = 2)
#'   )
#' )
#'
#' test <- dplyr::collect(dplyr::tbl(con, "test"))
#'
#' test_dat <- list(
#'   id = 3,
#'   data_col = "hello"
#' )
#'
#' add_row(con, "test", .dat = test_dat)
#'
#' test <- dplyr::collect(dplyr::tbl(con, "test"))
#'
#' DBI::dbDisconnect(con)
#'
#'
add_row <- function(conn, tbl_name, .dat) {

  .dat <- lapply(.dat, DBI::dbQuoteLiteral, conn = conn)

  query <- sprintf(
    "INSERT INTO %s (%s) VALUES (%s);",
    tbl_name,
    paste(names(.dat), collapse = ", "),
    paste0("?", names(.dat), collapse = ", ")
  )


  query <- DBI::sqlInterpolate(
    conn = conn,
    sql = query,
    .dots = .dat
  )

  # execute SQL statement
  rows_affected <- DBI::dbExecute(conn, query)

  rows_affected
}

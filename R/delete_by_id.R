#' delete_by_id
#'
#' Delete a row from a table by the row id
#'
#' @param conn the DBI connection
#' @param tbl_name the name of the table
#' @param id the row id
#'
#' @import DBI
#'
#' @return the number of rows affected or an error. This value should be 1, 0, or the error
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
#' delete_by_id(con, "test", id = 1)
#'
#' DBI::dbDisconnect(con)
#'
delete_by_id <- function(conn, tbl_name, id) {
  stopifnot(length(id) == 1)
  stopifnot(length(tbl_name) == 1 && is.character(tbl_name))

  query <- "DELETE FROM ?__tbl_name__ WHERE id=?__id__"

  dat_list <- c(
    "__tbl_name__" = tbl_name,
    "__id__" = id
  )

  # protect against SQL injection
  query <- DBI::sqlInterpolate(
    conn = conn,
    sql = query,
    .dots = dat_list
  )

  rows_affected <- DBI::dbExecute(conn, query)

  rows_affected
}

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
#' test <- collect(tbl(con, "test"))
#'
#' delete_by(con, "test", by = list(id = "1"))
#' 
#' test <- collect(tbl(con, "test"))
#'
#' DBI::dbDisconnect(con)
#' 
#'
#'
#' con <- DBI::dbConnect(
#'   RSQLite::SQLite(),
#'   dbname = ":memory:"
#' )
#'
#' DBI::dbWriteTable(
#'   con,
#'   name = "test",
#'   value = data.frame(
#'     id = c(1,1,1,2,2),
#'     uid = c(1,2,1,1,2),
#'     data_col = rep("hi", times = 5)
#'   )
#' )
#' 
#' test <- collect(tbl(con, "test"))
#'
#' delete_by(con, "test", by = list(id = "1", uid = "1"))
#' 
#' test <- collect(tbl(con, "test"))
#'
#' DBI::dbDisconnect(con)
delete_by <- function(conn, tbl_name, by) {
  stopifnot(length(by) > 0)
  stopifnot(length(tbl_name) == 1 && is.character(tbl_name))

  sql_prep <- paste0(names(by), "=?", names(by))
  
  query <- sprintf(
    "DELETE FROM %s WHERE %s;",
    tbl_name,
    paste(sql_prep, collapse = " AND ")
  )

  dat_list <- lapply(by, DBI::dbQuoteLiteral, conn = conn)

  # protect against SQL injection
  query <- DBI::sqlInterpolate(
    conn = conn,
    sql = query,
    .dots = dat_list
  )

  rows_affected <- DBI::dbExecute(conn, query)

  rows_affected
}

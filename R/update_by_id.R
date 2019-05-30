#' update a row in a table
#'
#' @param conn the DBI connection
#' @param tbl_name the name of the table
#' @param id the row id
#' @param .dat a named list where the name is the database table field name and
#' each value is of length 1 and is the value to be updated
#'
#' @import DBI
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
#' test_dat <- list(
#'   data_col = "hello"
#' )
#'
#' update_by_id(con, "test", id = 1, .dat = test_dat)
#'
#' DBI::dbDisconnect(con)
#'
update_by_id <- function(conn, tbl_name, id, .dat) {
  stopifnot(length(id) == 1)
  stopifnot(length(tbl_name) == 1 && is.character(tbl_name))


  sql_prep <- paste0(names(.dat), "=?", names(.dat))

  query <- sprintf(
    "UPDATE %s SET %s WHERE id=?__id__;",
    tbl_name,
    paste(sql_prep, collapse = ", ")
  )

  dat_list <- lapply(.dat, as.character)

  id_list <- c(
    "__id__" = id
  )

  dat_list <- c(
    dat_list,
    id_list
  )

  # protect against SQL injection
  query <- DBI::sqlInterpolate(
    conn = conn,
    sql = query,
    .dots = dat_list
  )

  # execute SQL statement
  rows_affected <- DBI::dbExecute(conn, query)

  rows_affected
}

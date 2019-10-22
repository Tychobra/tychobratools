#' read_by
#'
#' Get rows from a table by values in its columns
#'
#' @param conn the DBI connection
#' @param tbl_name the name of the table
#' @param cols The columns to select from the table
#' @param by A named list of the field names and values to determine which rows to read
#' @param operator Either "AND" or "OR", determines whether the SQL query selects
#' the rows that match all of by or just at least one element of by
#'
#' @importFrom DBI dbExecute sqlInterpolate
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
#' dplyr::collect(dplyr::tbl(con, "test"))
#'
#' read_by(con, "test", by = list(id = "1"))
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
#' dplyr::collect(dplyr::tbl(con, "test"))
#'
#' read_by(con, "test", by = list(id = "1", uid = "1"))
#'
#' read_by(con, "test", by = list(id = "1", uid = "1"), operator = "Or")
#'
#' read_by(con, "test", cols = "data_col", by = list(id = "1", uid = "1"))
#'
#' read_by(con, "test", cols = c("uid", "data_col"), by = list(id = "1", uid = "1"))
#'
#' DBI::dbDisconnect(con)
read_by <- function(conn, tbl_name, cols = "*", by, operator = "AND") {
  stopifnot(length(by) > 0)
  stopifnot(length(cols) > 0)
  stopifnot(length(tbl_name) == 1 && is.character(tbl_name))
  operator <- toupper(operator)
  stopifnot(operator %in% c("AND", "OR"))

  sql_cols_prep <- paste(cols, collapse = ", ")
  sql_prep <- paste0(names(by), "=?", names(by))

  query <- sprintf(
    "SELECT %s FROM %s WHERE %s;",
    sql_cols_prep,
    tbl_name,
    paste(sql_prep, collapse = paste0(" ", operator, " "))
  )

  dat_list <- lapply(by, DBI::dbQuoteLiteral, conn = conn)

  # protect against SQL injection
  query <- DBI::sqlInterpolate(
    conn = conn,
    sql = query,
    .dots = dat_list
  )

  DBI::dbGetQuery(conn, query)
}

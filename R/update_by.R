#' update a row in a table
#'
#' @param conn the DBI connection
#' @param tbl_name the name of the table
#' @param by the field names and values to be updated
#' @param .dat a named list where the name is the database table field name and
#' each value is of length 1 and is the value to be updated
#' @param operator Either "AND" or "OR", determines whether the SQL query updates
#' all rows that match all of by or at least one element of by
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
#' test <- collect(tbl(con, "test")) 
#'
#' test_dat <- list(
#'   data_col = "hello"
#' )
#'
#' update_by(con, "test", by = list(id = 1), .dat = test_dat)
#' 
#' test <- collect(tbl(con, "test")) 
#' 
#' DBI::dbDisconnect(con)
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
#'     id = c(1,2,1,1,2),
#'     uid = c(1,2,1,2,1),
#'     data_col = rep("hi", times = 5)
#'   )
#' )
#' 
#' test <- collect(tbl(con, "test")) 
#'
#' test_dat <- list(
#'   data_col = "hello"
#' )
#' 
#' update_by(con, "test", by = list(id = 1, uid = 1), .dat = test_dat)
#' 
#' test <- collect(tbl(con, "test")) 
#' 
#' update_by(con, "test", by = list(id = 1, uid = 1), .dat = test_dat, operator = "or")
#' 
#' test <- collect(tbl(con, "test")) 
#' 
#' DBI::dbDisconnect(con)
#' 
#'
update_by <- function(conn, tbl_name, by, .dat, operator = "AND") {
  stopifnot(length(id) > 0)
  stopifnot(length(tbl_name) == 1 && is.character(tbl_name))
  operator <- toupper(operator)
  stopifnot(operator %in% c("AND", "OR"))
  
  #.dat <- lapply(.dat, DBI::dbQuoteLiteral, conn = conn)

  sql_prep <- paste0(names(.dat), "=?", names(.dat))
  sql_where_prep <- paste0(names(by), "=?", names(by))

  query <- sprintf(
    "UPDATE %s SET %s WHERE %s;",
    tbl_name,
    paste(sql_prep, collapse = ", "),
    paste(sql_where_prep, collapse = paste0(" ", operator, " "))
  )
  
  dat_list <- c(
    .dat,
    by
  )
  
  dat_list <- lapply(dat_list, DBI::dbQuoteLiteral, conn = conn)

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

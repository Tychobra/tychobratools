#' Convert values in a vector to their cooresponding values according to 
#' a data frame
#' 
#' @param old_names The column names of a data frame
#' @param names_map A data frame with columns "names" and "display names"
#' 
#' @return The names where every old name in names is replaced with its cooresponding
#' display name
#' 
#' @export
#' 
#' @examples
#' names_vector <- c("lot_location_code", "location_name", "actions")
#' names_map <- data.frame(
#'                names = c("location_name", "lot_location_code"),
#'                display_names = c("Location Name", "Lot Location Code"),
#'                stringsAsFactors = FALSE
#'                )
#' convert_column_names(names_vector, names_map)
#' 
convert_column_names <- function(names_vector, names_map){
  for (i in seq_along(names_vector)) {
    if (names_vector[[i]] %in% names_map$names) {
      index <- match(names_vector[[i]], names_map$names)
      names_vector[[i]] <- names_map$display_names[[index]]
    }
  }
  
  names_vector
}

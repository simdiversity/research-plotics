#' @importFrom utils data write.table
#' @importFrom here here
NULL

#'   Data name string to dataset
#'
#' Useful to load a dataset into a variable.
#'
#' @param dataset_name the name of the dataset to load
#' @return the dataset
#'
#' @export
dataset_from_str <- function(dataset_name) {
  d <- new.env()
  data(list = c(dataset_name), envir = d)
  dataset <- get(dataset_name, envir = d)
  rm(d)
  dataset
}

#' importFrom utils write.csv2
#'  Data name string to dataset
#'
#' Useful to load a dataset into a variable.
#'
#' @param new_name name of the data
#' @param variable the original variable
#' @param format "rda" or "csv"
#' @param compress compression type see save
#'
#' @export
save_with_name <- function(variable, new_name, format="rda", compress = "gzip") {
  assign(new_name, variable)
  if (format == "rda") {
    save(
      list = c(new_name),
      file = here::here("data", paste0(new_name, ".rda")),
      compress = compress
    )
  } else if (format == "csv") {
    utils::write.table(variable, file = here::here("data", paste0(new_name, ".csv")), sep = ",", dec = ".", quote = TRUE, col.names = TRUE, row.names = TRUE)
  }
  invisible(variable)
}


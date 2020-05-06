#' Data name string to dataset
#'
#' Useful to load a dataset into a variable.
#'
#' @param dataset_name
#' @return the dataset
#'
#' @exapmle
#' cars <- dataset_from_str("mtcars")
#'
#' @export
dataset_from_str <- function(dataset_name) {
  d <- new.env()
  data(list = c(dataset_name), envir = d)
  dataset <- get(dataset_name, envir = d)
  rm(d)
  dataset
}


#' import simdiversity.RNcEDGPS
#' import simdiversity.data.politics
#' importFrom magrittr %>%
#' importFrom tibble tibble
#' importFrom dplyr select
#' importFrom here here
compute_distances <- function() {
data_sets <- c(
  data(package = "simdiversity.data.politics")
)[["results"]][, "Item"]

for (dataset_name in data_sets) {
  data_set <- dataset_from_str(dataset_name)

  for (option in seq(3)) {
    if (file.exists(
      here("data", paste0(dataset_name, "-", option, "-D_final.rda")
    ))) {
      next
    }

    if (option == 1) {
      poll_codes <-
        c(
          `0` = 0, `1` = 1, `2` = NA_real_,
          `3` = NA_real_, `4` = NA_real_,
          `5` = NA_real_, `6` = NA_real_,
          `7` = NA_real_
        )
    }

    if (option == 2) {
      poll_codes <-
        c(
          `0` = 0, `1` = 1, `2` = 0.5,
          `3` = NA_real_, `4` = NA_real_,
          `5` = NA_real_, `6` = NA_real_,
          `7` = NA_real_
        )
    }
    if (option == 3) {
      poll_codes <-
        c(
          `0` = 0, `1` = 1, `2` = 0.5,
          `3` = 0.5, `4` = NA_real_,
          `5` = NA_real_, `6` = NA_real_,
          `7` = NA_real_
        )
    }

    scores_matrix <-
      data_set$polls %>%
      recode(!!!poll_codes) %>%
      matrix(nrow = nrow(data_set$polls), dimnames = dimnames(data_set$polls))


    file_name = paste0(dataset_name, "-", option, "-scores_matrix")
    assign(file_name, scores_matrix )
    save(
      list=c(file_name),
      file = here("data", paste0(file_name, ".rda")),
      compress = "xz"
    )

    null_votes_index <- apply(scores_matrix, 2, function(x) {
      all(is.na(x))
    })
    null_councillors_index <- apply(scores_matrix, 1, function(x) {
      all(is.na(x))
    })
    null_votes <- c(names(which(null_votes_index)))
    null_councilors <- c(names(which(null_councillors_index)))

    file_name = paste0(dataset_name, "-", option, "-null_votes")
    assign(file_name, null_votes )
    save(
      list=c(file_name),
      file = here("data", paste0(file_name, ".rda")),
      compress = "xz"
    )

    file_name = paste0(dataset_name, "-", option, "-null_councilors")
    assign(file_name, null_councilors )
    save(
      list=c(file_name),
      file = here("data", paste0(file_name, ".rda")),
      compress = "xz"
    )

    scores_matrix <- scores_matrix[!null_councillors_index, !null_votes_index]
    n <- nrow(scores_matrix)
    p <- ncol(scores_matrix)

    weight <- validity_weight(scores_matrix)

    file_name = paste0(dataset_name, "-", option, "-weight")
    assign(file_name, weight )
    save(
      list=c(file_name),
      file = here("data", paste0(file_name, ".rda")),
      compress = "xz"
    )

    weighted_vote_disputedness <- disputedness(
      scores_matrix, weight
    )

    file_name = paste0(dataset_name, "-", option, "-weighted_vote_disputedness")
    assign(file_name, weighted_vote_disputedness )
    save(
      list=c(file_name),
      file = here("data", paste0(file_name, ".rda")),
      compress = "xz"
    )

    D_final <- estimate_distance(
      scores_matrix, weight, weighted_vote_disputedness
    )

    file_name = paste0(dataset_name, "-", option, "-D_final")
    assign(file_name, D_final )
    save(
      list=c(file_name),
      file = here("data", paste0(D_final, ".rda")),
      compress = "xz"
    )

  gc()
  }
}
}

library(here)
library(magrittr)
library(dplyr)
library(simdiversity.RNcEDGPS)
library(simdiversity.data.politics)
compute_distances()


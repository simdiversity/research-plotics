library(here)
library(magrittr)
library(dplyr)
library(simdiversity.RNcEDGPS)
library(simdiversity.data.politics)

data_sets <- c(
  data(package = "simdiversity.data.politics")
)[["results"]][, "Item"]

for (dataset_name in data_sets) {
  data_set <- dataset_from_str(dataset_name)

  for (option in seq(3)) {

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


    file_name = paste0(dataset_name, "__", option, "__scores_matrix")
    assign(file_name, scores_matrix )
    save(
      list = c(file_name),
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
    save_with_name(
      null_votes,
      paste0(dataset_name, "__", option, "__null_votes"),
      compress = "gzip"
    )


    null_councilors <- c(names(which(null_councillors_index)))
    save_with_name(
      null_councilors,
      paste0(dataset_name, "__", option, "__null_councilors"),
      compress = "gzip"
    )

    scores_matrix <- scores_matrix[!null_councillors_index, !null_votes_index]
    n <- nrow(scores_matrix)
    p <- ncol(scores_matrix)

    weight <- validity_weight(scores_matrix)
    save_with_name(
      weight,
      paste0(dataset_name, "__", option, "__weight"),
      compress = "gzip"
    )

    weighted_vote_disputedness <- disputedness(
      scores_matrix, weight
    )
    save_with_name( weighted_vote_disputedness,
      paste0(dataset_name, "__", option, "__weighted_vote_disputedness"),
      compress = "gzip"
    )

    D_final <- estimate_distance(
      scores_matrix, weight, weighted_vote_disputedness
    )
    save_with_name(D_final,
      paste0(dataset_name, "__", option, "__D_final"),
      compress = "xz"
    )

  gc()
  }
}



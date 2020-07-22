library(here)
library(magrittr)
library(dplyr)
library(R.matlab)
if (!require(simdiversity.data.politics))
devtools::install_github(simdiversity/data-politics, auth_token = "8a5922b49bcc3a395ea3ea0c026c48518bb65d2d")
if (!require(simdiversity.entropy))
devtools::install_github(simdiversity/entropy, auth_token = "8a5922b49bcc3a395ea3ea0c026c48518bb65d2d")
if (!require(simdiversity.RNcEDGPS))
devtools::install_github(simdiversity/RNcEDGPS, auth_token = "8a5922b49bcc3a395ea3ea0c026c48518bb65d2d")
devtools::load_all()

data_sets <- c(
  data(package = "simdiversity.data.politics")
)[["results"]][, "Item"]

for (dataset_name in data_sets) {
  data_set <- dataset_from_str(dataset_name)

  for (option in seq(3)) {
    poll_codes <- poll_codes_for_option(option)


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

    null_votes <- c(names(which(null_votes_index)))
    save_with_name(
      null_votes,
      paste0(dataset_name, "__", option, "__null_votes"),
      compress = "gzip"
    )

    null_councillors_index <- apply(scores_matrix, 1, function(x) {
      all(is.na(x))
    })
    null_councilors <- c(names(which(null_councillors_index)))
    save_with_name(
      null_councilors,
      paste0(dataset_name, "__", option, "__null_councilors"),
      compress = "gzip"
    )

    scores_matrix <- scores_matrix[!null_councillors_index, !null_votes_index]
    n <- nrow(scores_matrix)
    p <- ncol(scores_matrix)

    save_with_name(
      scores_matrix,
      paste0(dataset_name, "__", option, "__scores"),
      format = "csv"
    )

    weight <- validity_weight(scores_matrix)
    save_with_name(
      weight,
      paste0(dataset_name, "__", option, "__weight"),
      compress = "gzip"
    )




    D_l1 <- dissimilarity_L1(scores_matrix)
    save_with_name( D_l1,
                    paste0(dataset_name, "__", option, "__D_l1"),
                    format = "csv"
    )


<<<<<<< HEAD
      weighted_vote_disputedness <- dataset_from_str(
        paste0(
          dataset_name, "__", option,
          "__weighted_vote_disputedness"
        )
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
        paste0(dataset_name, "__", option, "__D_final__weighted"),
        compress = "xz"
      )

      unweighted_vote_disputedness <- disputedness(
        scores_matrix, weight
      )
      save_with_name( unweighted_vote_disputedness,
                      paste0(dataset_name, "__", option, "__unweighted_vote_disputedness"),
                      compress = "gzip"
      )

      D_final_unweighted <- estimate_distance(
        scores_matrix, weight, unweighted_vote_disputedness
      )

      save_with_name(D_final_unweighted,
                     paste0(dataset_name, "__", option, "__D_final__unweighted"),
                     compress = "xz"
      )
=======
    #  weighted_vote_disputedness <- dataset_from_str(
    #    paste0(
    #      dataset_name, "__", option,
    #      "__weighted_vote_disputedness"
    #    )
    #  )
    # #
    #  weighted_vote_disputedness <- disputedness(
    #    scores_matrix, weight
    #  )
    #  save_with_name( weighted_vote_disputedness,
    #                  paste0(dataset_name, "__", option, "__weighted_vote_disputedness"),
    #                  compress = "gzip"
    #  )
    # #
    #  D_final <- estimate_distance(
    #    scores_matrix, weight, weighted_vote_disputedness
    #  )
    #
    #  save_with_name(D_final,
    #    paste0(dataset_name, "__", option, "__D_final__weighted"),
    #    compress = "xz"
    #  )
    #
    #  unweighted_vote_disputedness <- disputedness(
    #    scores_matrix, weight
    #  )
    #  save_with_name( unweighted_vote_disputedness,
    #                  paste0(dataset_name, "__", option, "__unweighted_vote_disputedness"),
    #                  compress = "gzip"
    #  )
    #
    #  D_final_unweighted <- estimate_distance(
    #    scores_matrix, weight, unweighted_vote_disputedness
    #  )
    #
    #  save_with_name(D_final_unweighted,
    #                 paste0(dataset_name, "__", option, "__D_final__unweighted"),
    #                 compress = "xz"
    #  )
>>>>>>> 62ba069... Last version

  gc()
  }
}



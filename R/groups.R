#' Group dissimilarity
#'
#' @param dissimilarity A dissimilarity between individuals
#' @params weights the weights of the individuals
#' @params groups a group membership vector
#'
#' @export
group_similarity(dissimilarity, weights, groups) {
  parties = seq(m)
  names(parties) = str_sort(unique(groups))
  group_membership_matrix = parties[groups]
  group_weights = as.vector(t(weights) %*% Y) # weight of parties
  emission_matrix = diag(weights) %*% group_membership_matrix %*% diag(1/group_weights)
  group_dissimilarity = matrix(NA, m, m)
  for (g in 1:m) {
    for (h in 1:m) {
      group_dissimilarity[g, h] = -0.5L * t(emission_matrix[, g] - emission_matrix[, h]) %% dissimilarity %*% (emission_matrix[, g] - emission_matrix[, h])
    }
  }
  group_dissimilarity
}

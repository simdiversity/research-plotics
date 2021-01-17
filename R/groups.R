#'  importFrom dplyr bind_cols
#'  importFrom stringr str_sort
NULL

#'
#' @title group_dissimilarity
#'
#' @param dissimilarity A dissimilarity between individuals
#' @param weight the weights of the individuals
#' @param groups a group membership vector
#'
#' @export
group_dissimilarity <- function(dissimilarity, f, groups) {
  m <- length(unique(groups))
  parties = seq(m)
  names(parties) = stringr::str_sort(unique(groups))
  group_membership_matrix = as.matrix(dplyr::bind_cols(
    lapply(parties, function(i) as.numeric(parties[groups] == i))
  ))
  group_weights = as.vector(t(f) %*% group_membership_matrix) # weight of parties
  emission_matrix = diag(f) %*% group_membership_matrix %*% diag(1/group_weights)
  group_dissimilarity = matrix(NA, m, m)
  for (g in 1:m) {
    for (h in 1:m) {
      group_dissimilarity[g, h] = -0.5 * t(emission_matrix[, g] - emission_matrix[, h]) %*% dissimilarity %*% (emission_matrix[, g] - emission_matrix[, h])
    }
  }
  group_dissimilarity
}

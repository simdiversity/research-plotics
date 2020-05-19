#' Column means and variances
#'
#'
#' @param M the matrix containing the data
#'

column_means_and_vars <- function(M) {
  mean_votes = apply(M, 2, mean, na.rm = TRUE)
  var_votes = apply(M, 2, (function(x) mean(x^2, na.rm = TRUE) - mean(x, na.rm = TRUE)^2))
  names(mean_votes) <- colnames(M)
  names(var_votes) <- colnames(M)
  result <- list(mean_votes, var_votes)
  names(result) <- c("Mean_votes", "Votes_variance")
  return(result)
}

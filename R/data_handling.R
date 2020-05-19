#' Set poll codes
#'
#' The values of the data are coded as follows:
#'
#' 0. "Nein", "Non", "No"
#' 1. "Ja", "Oui", "Si"
#' 2. "Enthaltung", "Abstention", "Astensione"
#' 3. "Der Pr\\u00e4sident stimmt nicht", "Pr\\u00e9sident ne vote pas", "Presidente non voto"
#' 4. "Entschuldigt", "Excus\\u00e9", "Scusato"
#' 5. "Not avilable": means that the councillor is not part of the council.
#' 6. "Hat nicht teilgenommen", "N'a pas particip\\u00e9" "Non ha partecipato"
#' 7. NA
#'
#' @param option a number in [1,3]
#'
#' Option 1: Only real votes count
#' Option 2:  Abstentions, Persidential non - vote, are set to 0.5
#' Option 3:  Abstentions, Persidential non - vote, and excused are set to 0.5
#'
#'
poll_codes_for_option <- function(option) {
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
  poll_codes
}

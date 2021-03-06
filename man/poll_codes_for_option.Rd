% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_handling.R
\name{poll_codes_for_option}
\alias{poll_codes_for_option}
\title{Set poll codes}
\usage{
poll_codes_for_option(option)
}
\arguments{
\item{option}{a number in [1,3]

Option 1: Only real votes count
Option 2:  Abstentions, Persidential non - vote, are set to 0.5
Option 3:  Abstentions, Persidential non - vote, and excused are set to 0.5}
}
\description{
The values of the data are coded as follows:
}
\details{
0. "Nein", "Non", "No"
1. "Ja", "Oui", "Si"
2. "Enthaltung", "Abstention", "Astensione"
3. "Der Pr\\u00e4sident stimmt nicht", "Pr\\u00e9sident ne vote pas", "Presidente non voto"
4. "Entschuldigt", "Excus\\u00e9", "Scusato"
5. "Not avilable": means that the councillor is not part of the council.
6. "Hat nicht teilgenommen", "N'a pas particip\\u00e9" "Non ha partecipato"
7. NA
}

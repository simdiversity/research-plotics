# research-plotics
The research on the political data

# Install

in R
```{r}
  install.packages(c("tidyverse", "devtools", "here", "rmarkdown", "golem", "qpdf"))
  
  library("devtools")
  devtools::install_github(simdiversity/data-politics, auth_token = "8a5922b49bcc3a395ea3ea0c026c48518bb65d2d")
  devtools::install_github(simdiversity/entropy, auth_token = "8a5922b49bcc3a395ea3ea0c026c48518bb65d2d")
  devtools::install_github(simdiversity/RNcEDGPS, auth_token = "8a5922b49bcc3a395ea3ea0c026c48518bb65d2d")
```
in terminal 
```{bash}
  git clone https://github.com/simdiversity/research-plotics.git
```

library("devtools")


devtools::build_vignettes(
  pkg = ".",
  dependencies = "VignetteBuilder",
  clean = TRUE,
  upgrade = "never",
  quiet = TRUE,
  install = TRUE,
  keep_md = TRUE
)

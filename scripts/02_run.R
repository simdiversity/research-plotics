#' importFrom magrittr %>%
#' importFrom tibble tibble
#' importFrom dplyr select
NULL

data_sets <- c(
  data(package = "simdiversity.data.politics")
)[["results"]][,"Item"]


knite_files <- function(filename, datasets) {

  if (filename %in% c("data", "na", "na_handeling", "")) {
    # NA Handeling for all
    for (selected_option in c(1, 2, 3)) {
      for (dataset in datasets) {
        print(paste(dataset, selected_option))
        rmarkdown::render("politics_2_na_and_distance.Rmd",
                          params = list(
                            datasets = data_sets,
                            selected_dataset = which(datasets == dataset),
                            selected_option = selected_option
                          ),
                          output_dir = base_output_path,
                          output_file = paste0(
                            "02_na_handeling_",
                            dataset, "_option_", selected_option, ".pdf"
                          ),
                          envir = new.env()
        )
        gc()
        gc()
      }
    }
  }

  # Analysis per NA handeling option
  for (selected_option in seq(3)) {
    rmarkdown::render(
      "politics_3_analysis.Rmd",
      params = list(
        selected_option = selected_option,
        data_path = base_data_path,
        datasets = c("italy_17", "italy_18", "switzerland_49", "switzerland_50"),
        data_path_pattern =  "%s%s/option_%s/02_%s.rds"
      ),
      output_dir = base_output_path,
      output_file = paste0("03_analysis_option_",selected_option, ".pdf"),
      envir = new.env()
    )
    gc()
    gc()
  }

}



#
# Script to execute all other scripts.
#

args <- commandArgs(trailingOnly = TRUE)


usage <- sprintf("
Usage
=====

run.R [arg1] [arg2]

Arguments:

arg1 : \"[A]ll\" , \"[D]ata\", \"[NA]_handeling\", \"[A]anlysis\"
arg2 : \"[IT]aly\", \"[CH]\"|\"Switzerland\", %s
", data_sets)

if (is.null(args)) {
  cat(usage)
} else if (length(args) == 1) {
  cat(usage)
} else {
  print(paste("Chosen Arguments:", args[1], ",", args[2]))
  args <- tolower(args)
  if (!(args[2] %in% c("a", "all", ""))) {
    if (args[2] %in% c("switzerland", "ch")) {
      data_sets =  c("switzerland_49", "switzerland_50")
    } else if (args[2] %in% c("italy", "it")) {
      data_sets =  c("italy_17", "italy_18")
    } else if (args[2] %in% data_sets) {
      data_sets = c(args[2])
    }
  }
  original_encoding <- options(encoding = "UTF-8")
  options(encoding = original_encoding)
}




#
# Script to execute all other scripts.
#
args <- commandArgs(trailingOnly = TRUE)


library('rmarkdown')

base_data_path = "../../simdiversity-data/datasets/politics/"
base_output_path = "../../simdiversity-data/outputs/"

datasets =  c("italy_17", "italy_18", "switzerland_49", "switzerland_50")

usage <- sprintf("
Usage
=====

run.R [arg1] [arg2]

Arguments:

arg1 : \"[A]ll\" , \"[D]ata\", \"[NA]_handeling\", \"[A]anlysis\"
arg2 : \"[IT]aly\", \"[CH]\"|\"Switzerland\", %s
", datasets)




if (is.null(args)) {
  cat(usage)
  q("no")
} else if (length(args) == 1) {
  cat(usage)
  q("no")
}
print(paste("Chosen Arguments:", args[1], ",", args[2]))

args <- tolower(args)

options(encoding = "UTF-8")


if (!(args[2] %in% c("a", "all", ""))) {
  if (args[2] %in% c("switzerland", "ch")) {
    datasets =  c("switzerland_49", "switzerland_50")

  } else if (args[2] %in% c("italy", "it")) {
    datasets =  c("italy_17", "italy_18")
  } else if (args[2] %in% datasets) {
    datasets = c(args[2])
  }
}

if (args[1] == "data") {
  # Prepare folders
  if (!dir.exists(base_data_path)) dir.create(base_data_path, recursive = TRUE)
  if (!dir.exists(base_output_path)) dir.create(base_output_path, recursive = TRUE)

  # Get Data

  if ("italy_17" %in% datasets) {
    # Italy legislative session 17
    print("italy_17")
    rmarkdown::render("politics_1_data_italy.Rmd",
      params = list(
        country = "italy",
        legislative_period = "17",
        data_base_path = "../../simdiversity-data/datasets/politics/",
        original_data_path = "../../simdiversity-data/original-data/politics_italy/",
        dataset_type = "politics",
        refresh_data = TRUE
      ),
      output_dir = base_output_path,
      output_file = "01_data_italy_17.pdf",
      envir = new.env()
    )
    gc()
    gc()
  }
  if ("italy_18" %in% datasets) {
    print("italy_18")
    # Italy legislative session 18
    rmarkdown::render("politics_1_data_italy.Rmd",
      params = list(
        country = "italy",
        legislative_period = "18",
        data_base_path = "../../simdiversity-data/datasets/politics/",
        original_data_path = "../../simdiversity-data/original-data/politics_italy/",
        dataset_type = "politics",
        refresh_data = TRUE
      ),
      output_dir = base_output_path,
      output_file = "01_data_italy_18.pdf",
      envir = new.env()
    )
    gc()
    gc()
  }


  if ("switzerland_49" %in% datasets) {
    # Switzerland legislative session 49
    print("switzerland_49")
    rmarkdown::render("politics_1_data_switzerland.Rmd",
      params = list(
          country = "switzerland",
          legislative_period = "49",
          data_base_path = "../../simdiversity-data/datasets/politics/",
          original_data_path = "../../simdiversity-data/original-data/politics_switzerland/",
          dataset_type = "politics"
      ),
      output_dir = base_output_path,
      output_file = "01_data_switzerland_49.pdf",
      envir = new.env()
    )
    gc()
    gc()
  }
  if ("switzerland_50" %in% datasets) {
    print("switzerland_50")
    # Switzerland legislative session 50
    rmarkdown::render("politics_1_data_switzerland.Rmd",
          params = list(
            country = "switzerland",
            legislative_period = "50",
            data_base_path = "../../simdiversity-data/datasets/politics/",
            original_data_path = "../../simdiversity-data/original-data/politics_switzerland/",
            dataset_type = "politics"
          ),
      output_dir = base_output_path,
      output_file = "01_data_switzerland_50.pdf",
      envir = new.env()
    )
    gc()
    gc()
  }
}
#
# if (args[1] %in% c("data", "na", "na_handeling", "")) {
#   # NA Handeling for all
#   for (selected_option in c(1, 2, 3)) {
#     for (dataset in datasets) {
#       print(paste(dataset, selected_option))
#       rmarkdown::render("politics_2_na_and_distance.Rmd",
#         params = list(
#           data_path = base_data_path,
#           dataset = dataset,
#           selected_option = selected_option,
#           datasets = datasets,
#           data_files_pattern = "%s%s/01_data.rds"
#         ),
#         output_dir = base_output_path,
#         output_file = paste0(
#           "02_na_handeling_",
#           dataset, "_option_", selected_option, ".pdf"
#         ),
#         envir = new.env()
#       )
#       gc()
#       gc()
#     }
#   }
# }
#
# # Analysis per NA handeling option
# for (selected_option in seq(3)) {
#   rmarkdown::render(
#     "politics_3_analysis.Rmd",
#     params = list(
#       selected_option = selected_option,
#       data_path = base_data_path,
#       datasets = c("italy_17", "italy_18", "switzerland_49", "switzerland_50"),
#       data_path_pattern =  "%s%s/option_%s/02_%s.rds"
#         ),
#     output_dir = base_output_path,
#     output_file = paste0("03_analysis_option_",selected_option, ".pdf"),
#      envir = new.env()
#   )
#   gc()
#   gc()
# }

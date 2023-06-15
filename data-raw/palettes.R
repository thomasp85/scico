curl::curl_download(
  "https://zenodo.org/record/8035877/files/ScientificColourMaps8.zip",
  "./data-raw/raw_palettes.zip"
)

unzip("./data-raw/raw_palettes.zip", exdir = "./data-raw/")

palettes <- list(
  .categorical = list()
)

palette_names <- list.dirs(
  "./data-raw/ScientificColourMaps8/", 
  full.names = FALSE, 
  recursive = FALSE
)

palette_names <- grep("^\\w", palette_names, value = TRUE)

for (name in palette_names) {
  standard_pal <- paste0("./data-raw/ScientificColourMaps8/", name, "/", name, ".txt")
  if (file.exists(standard_pal)) {
    palettes[[name]] <- read.table(standard_pal, sep = " ", col.names = c("r", "g", "b"))
  }
  categorical_pal <- paste0("./data-raw/ScientificColourMaps8/", name, "/CategoricalPalettes/", name, "S_HEX.txt")
  if (file.exists(categorical_pal)) {
    palettes$.categorical[[name]] <- read.table(categorical_pal, skip = 2, comment.char = "", col.names = c("r", "g", "b", "name", "hex"))$hex
  }
}

unlink("./data-raw/raw_palettes.zip")
unlink("./data-raw/ScientificColourMaps8/", recursive = TRUE)

usethis::use_data(palettes, overwrite = TRUE, internal = TRUE)

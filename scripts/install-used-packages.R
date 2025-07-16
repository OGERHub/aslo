# scripts/install-used-packages.R

install.packages("stringr", repos = "https://cloud.r-project.org")

used_packages <- unique(stringr::str_match_all(
  paste(readLines(list.files(pattern = "\\.qmd$", recursive = TRUE)), collapse = "\n"),
  "library\\((['\"]?)([[:alnum:]\\.]+)\\1\\)"
)[[1]][,3])

if (length(used_packages) > 0) {
  message("Installing detected packages: ", paste(used_packages, collapse = ", "))
  install.packages(used_packages, repos = "https://cloud.r-project.org")
} else {
  message("No R packages detected in .qmd files.")
}

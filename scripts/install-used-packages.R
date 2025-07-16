# scripts/install-used-packages.R

install.packages("stringr", repos = "https://cloud.r-project.org")

qmd_files <- list.files(pattern = "\\.qmd$", recursive = TRUE)

if (length(qmd_files) == 0) {
  message("No .qmd files found in project. Skipping package detection.")
} else {
  text <- paste(readLines(qmd_files, warn = FALSE), collapse = "\n")
  
  used_packages <- unique(stringr::str_match_all(
    text,
    "library\\((['\"]?)([[:alnum:]\\.]+)\\1\\)"
  )[[1]][,3])
  
  if (length(used_packages) > 0 && !all(is.na(used_packages))) {
    message("Installing detected packages: ", paste(used_packages, collapse = ", "))
    install.packages(used_packages, repos = "https://cloud.r-project.org")
  } else {
    message("No R packages detected via library() calls.")
  }
}

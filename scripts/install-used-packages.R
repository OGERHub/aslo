# scripts/install-used-packages.R

install.packages("stringr", repos = "https://cloud.r-project.org")

qmd_files <- list.files(pattern = "\\.qmd$", recursive = TRUE, full.names = TRUE)

# Sicherheitsfilter: Nur existierende und lesbare Dateien
qmd_files <- qmd_files[file.exists(qmd_files)]

if (length(qmd_files) == 0) {
  message("No readable .qmd files found in project. Skipping package detection.")
} else {
  file_contents <- vapply(qmd_files, function(f) {
    tryCatch(paste(readLines(f, warn = FALSE), collapse = "\n"),
             error = function(e) "")
  }, character(1))
  
  all_text <- paste(file_contents, collapse = "\n")
  
  matches <- stringr::str_match_all(
    all_text,
    "library\\((['\"]?)([[:alnum:]\\.]+)\\1\\)"
  )[[1]]
  
  if (nrow(matches) == 0) {
    message("No R packages detected via library() calls.")
  } else {
    used_packages <- unique(na.omit(matches[, 3]))
    message("Installing detected packages: ", paste(used_packages, collapse = ", "))
    install.packages(used_packages, repos = "https://cloud.r-project.org")
  }
}

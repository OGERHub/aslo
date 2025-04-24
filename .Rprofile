linkkarten_konverter <- function() {
  pfad <- file.path("tools", "linkkarten-konverter.html")
  pfad_absolut <- normalizePath(pfad, mustWork = TRUE)

  viewer <- getOption("viewer")
  if (!is.null(viewer)) {
    viewer(pfad_absolut)  # ⚠️ KEIN file:// hier!
  } else {
    utils::browseURL(pfad_absolut)
  }
}

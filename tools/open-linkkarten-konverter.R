#' Öffnet den HTML-Linkkarten-Konverter im Viewer
#'
#' Diese Funktion öffnet die Datei tools/linkkarten-konverter.html im RStudio Viewer.
#' Du kannst sie einfach in einem Chunk oder Console aufrufen.
#'
#' @export
linkkarten_konverter <- function() {
  html_path <- file.path("tools", "linkkarten-konverter.html")
  viewer <- getOption("viewer")
  if (!is.null(viewer)) {
    viewer(paste0("file://", normalizePath(html_path)))
  } else {
    utils::browseURL(normalizePath(html_path))
  }
}
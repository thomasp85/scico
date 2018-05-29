#' Scales to use for ggplot2
#' 
#' These functions provide the option to use the scico palettes along with the
#' `ggplot2` package. It goes without saying that it requires `ggplot2` to work.
#' 
#' @param ... Arguments to pass on to `ggplot2::scale_colour_gradientn()` or 
#' `ggplot2::scale_fill_gradientn()`
#' @inheritParams scico
#' 
#' @return A `ScaleContinuous` object that can be added to a `ggplot` object
#' 
#' @name ggplot2-scales
#' @rdname ggplot2-scales
#' @export
#' 
#' @examples 
#' 
#' if (require('ggplot2')) {
#'   volcano <- data.frame(
#'     x = rep(seq_len(ncol(volcano)), each = nrow(volcano)),
#'     y = rep(seq_len(nrow(volcano)), ncol(volcano)),
#'     height = as.vector(volcano)
#'   )
#'   
#'   ggplot(volcano, aes(x = x, y = y, fill = height)) + 
#'     geom_raster() + 
#'     scale_fill_scico(palette = 'tokyo') 
#' }
#' 
scale_colour_scico <- function(..., alpha = NULL, begin = 0, end = 1, direction = 1, palette = "bilbao") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop('ggplot2 is required for this functionality', call. = FALSE)
  }
  ggplot2::scale_colour_gradientn(colours = scico(256, alpha, begin, end, direction, palette), ...)
}
#' @rdname ggplot2-scales
#' @export
#' 
scale_color_scico <- scale_colour_scico
#' @rdname ggplot2-scales
#' @export
#' 
scale_fill_scico <- function(..., alpha = NULL, begin = 0, end = 1, direction = 1, palette = "bilbao") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop('ggplot2 is required for this functionality', call. = FALSE)
  }
  ggplot2::scale_fill_gradientn(colours = scico(256, alpha, begin, end, direction, palette), ...)
}

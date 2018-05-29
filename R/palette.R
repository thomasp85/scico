#' Scientific colour map palettes
#' 
#' This function constructs palettes of the specified size based on the colour 
#' maps developed by Fabio Crameri. It follows the same API style as `viridis()`
#' from the `viridisLite` package so anyone familiar with this package can 
#' easily adapt to that.
#' 
#' @param n The number of colours to generate for the palette
#' @param alpha The opacity of the generated colours. If specified rgba values
#' will be generated. The default (`NULL`) will generate rgb values which 
#' corresponds to `alpha = 1`
#' @param begin,end The interval within the palette to sample colours from. 
#' Defaults to `0` and `1` respectively
#' @param direction Either `1` or `-1`. If `-1` the palette will be reversed
#' @param palette The name of the palette to sample from. See 
#' [scico_palette_names()] for a list of possible names
#' 
#' @return A character vector of length `n` with hexencoded rgb(a) colour values
#' 
#' @references 
#' <http://www.fabiocrameri.ch/colourmaps.php>
#' 
#' Crameri, Fabio. (2018, May 8). *Scientific colour maps (Version 3.0.1)*. Zenodo. doi:10.5281/zenodo.1243909
#' Crameri, Fabio. (2018). *Geodynamic diagnostics, scientific visualisation and StagLab 3.0*. Geosci. Model Dev. Discuss. doi:10.5194/gmd-2017-328
#' 
#' @export
#' @importFrom grDevices rgb colorRamp
#' 
#' @examples 
#' 
#' # Use the default palette
#' scico(15)
#' 
#' # Flip the direction
#' scico(15, direction = -1)
#' 
#' # Take a subset of a palette
#' scico(15, begin = 0.3, end = 0.6, palette = 'berlin')
#' 
scico <- function(n, alpha = NULL, begin = 0, end = 1, direction = 1, palette = "bilbao") {
  if (begin < 0 | begin > 1 | end < 0 | end > 1) {
    stop("begin and end must be in [0,1]")
  }
  
  if (abs(direction) != 1) {
    stop("direction must be 1 or -1")
  }
  
  if (direction == -1) {
    tmp <- begin
    begin <- end
    end <- tmp
  }
  
  palette <- scico_palette_data(palette)
  
  map_cols <- rgb(palette$r, palette$g, palette$b)
  fn_cols <- colorRamp(map_cols, space = "Lab", interpolate = "spline")
  cols <- fn_cols(seq(begin, end, length.out = n))
  if (is.null(alpha)) {
    rgb(cols[, 1], cols[, 2], cols[, 3], maxColorValue = 255)
  } else {
    rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha * 255, maxColorValue = 255)
  }
}
#' Access raw palette data
#' 
#' These functions gives access to the data underlying the palettes
#' 
#' @keywords internal
#' 
#' @name scico_data
#' @rdname scico_data
#' 
#' @export
#' 
scico_palette_names <- function() names(palettes)
#' @rdname scico_data
#' 
#' @param palette The name of the palette to fetch data for
#' @export
#' 
scico_palette_data <- function(palette) {
  palette <- match.arg(palette, names(palettes))
  palettes[[palette]]
}

#' Show the different scico palettes
#' 
#' This is a simple function to show a gradient of the different palettes 
#' available in the `scico` package
#' 
#' @param palettes One or more palette names to show
#' 
#' 
#' @importFrom grDevices n2mfrow
#' @importFrom graphics image par
#' @export
#' 
#' @examples 
#' 
#' scico_palette_show()
#' 
scico_palette_show <- function(palettes = scico_palette_names()) {
  dims <- n2mfrow(length(palettes))
  oldpar <- par(mfrow = dims, mai = par('mai')/5)
  on.exit(par(oldpar))
  
  for (i in palettes) {
    image(matrix(1:100, ncol = 1), col = scico(100, palette = i), main = i, axes = FALSE)
  }
}
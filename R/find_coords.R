#' Find coordinates of a tensor
#'
#' @param cellcenter x, y, z coordinates.
#' @param tipUnit x, y, z coordinates.
#' @param d Norm of the vector.
#' @param scale Shorten or lengthen the line for visualisation.
#'
#' @importFrom dplyr tibble
#' @return a tibble with coordinates (x1, y1, z1, x2, y2, z2)
#' @export
#'

find_coords <- function(cellcenter, tipUnit, d, scale = 1) {
  d <- d*scale
  # Distance
  tip1 <- d / (sqrt(sum(tipUnit^2))) * tipUnit + cellcenter
  tip2 <- (-d / (sqrt(sum(tipUnit^2))) * tipUnit) + cellcenter
  tibble(x1 = tip1[1], y1 = tip1[2], z1 = tip1[3],
         x2 = tip2[1], y2 = tip2[2], z2 = tip2[3])
}

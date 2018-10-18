#' Convert an integer to hour minutes in digital format
#' Assumes that integers (0, 1, 2) refers to 30 minutes timesteps (00:00, 00:30, 01:00)... Same function as in {mamut2r}.
#'
#' @param x integer
#' @importFrom glue glue
#'
#' @return a string with the hour in digital format (HH:mm)
#'
#' @examples

int2hours <- function(x) {
  Hours <- formatC(floor(x), width = 2, flag = "0")
  Minutes <- formatC( (x - floor(x))*60, width = 2, flag = "0")
  glue(Hours, ":", Minutes)
}

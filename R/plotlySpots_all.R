#' A layout for 3D scatter plotly graphs with a time player  - Many thanks to @friep for her help on this function.
#'
#' @param Spots_df dataframe containing x,y,z coordinates, timepoints and number of spots per timepoint (for instance generated with Spots.as.dataframe)
#' @param x x coordinate
#' @param y y coordinate
#' @param z z coordinate
#' @param timepoint column of the timepoints
#' @param number column with the number of spots per timepoint
#' @param color continuous value used for coloring the spots
#'
#' @importFrom dplyr enquo mutate
#' @importFrom plotly add_markers animation_opts animation_slider layout plot_ly
#'
#' @return
#' @export
#'
#' @examples

plotlySpots_all <- function(Spots_df,
                            x,
                            y,
                            z,
                            timepoint,
                            number,
                            color) {
  x <- enquo(x)
  y <- enquo(y)
  z <- enquo(z)
  timepoint <- enquo(timepoint)
  number <- enquo(number)
  color <- enquo(color)

  Spots_df_tmp <- Spots_df %>%
    mutate(timepointNum = as.numeric((!!timepoint))/2,
           cellNum =  (!!number),
           x = (!!x),
           y=(!!y),
           z=(!!z),
           color=(!!color))

  p <- plot_ly(Spots_df_tmp, x = ~x, y = ~y, z = ~z,
               frame = ~purrr::map2_chr(
                 .x = purrr::map_chr(
                   .x = timepointNum,
                   .f = int2hours), # concat frame with nb of cells
                 .y= cellNum ,~glue(.x, " - ", .y)),
               text = ~paste('Fluo: ', round(color),
                             '<br> x: ', round(x),
                             '<br> ID: ', ID),
               hoverinfo = 'text') %>%
    animation_opts(frame=50) %>%
    add_markers(color = ~ color) %>%
    layout(scene = list(xaxis = list(title = 'X'),
                        yaxis = list(title = 'Y'),
                        zaxis = list(title = 'Z'),
                        aspectmode = "data"),
           title = "Growing LRP<br> MaMuT data") %>%
    animation_slider(
      currentvalue = list(prefix = "Time: ",
                          font = list(color="black"), suffix = " cells")
    )
  rm(Spots_df_tmp)
  return(p)
}

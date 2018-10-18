#' A layout for 3D scatter plotly graphs for a single timepoint
#'
#' @param Spots_df dataframe containing x,y,z coordinates, timepoints and number of spots per tiempoint (for instance generated with Spots.as.dataframe)
#' @param x x coordinate
#' @param y y coordinate
#' @param z z coordinate
#' @param timepoint column of the timepoints
#' @param singleTimepoint single timepoint to display
#' @param number column with the number of spots per timepoint
#' @param color continuous value used for coloring the spots
#'
#' @importFrom dplyr enquo filter mutate
#' @importFrom glue glue
#' @importFrom plotly add_markers layout plot_ly
#'
#' @return
#' @export
#'
#' @examples

plotlySpots <- function(Spots_df,
                        x,
                        y,
                        z,
                        timepoint,
                        singleTimepoint,
                        number,
                        color) {

  x <- enquo(x)
  y <- enquo(y)
  z <- enquo(z)
  timepoint <- enquo(timepoint)
  timepointName <- enquo(timepoint)
  number <- enquo(number)
  color <- enquo(color)

  Spots_df_tmp <- Spots_df %>%
    mutate(timepointNum = as.numeric((!!timepoint))/2,
           cellNum =  (!!number),
           x = (!!x),
           y=(!!y),
           z=(!!z),
           color=(!!color)) %>%
    filter((!!timepointName) == singleTimepoint)

  a_text <- glue("Time: ",
                 int2hours(unique(Spots_df_tmp$timepointNum)),
                 " - ",
                 unique(Spots_df_tmp$cellNum),
                 " cells")

  a <- list(
    x = 0.5,
    y = -0.05,
    text = a_text,
    align = "center",
    xref = "paper",
    yref = "paper",
    showarrow = FALSE,
    font = list(
      size = 16
    )
  )

  p <- plot_ly(Spots_df_tmp, x = ~x, y = ~y, z = ~z,
               text = ~paste('Fluo: ', round(color),
                             '<br> x: ', round(x),
                             '<br> ID: ', ID),
               hoverinfo = 'text'
  ) %>%
    add_markers(color = ~ color) %>%
    layout(scene = list(xaxis = list(title = 'X'),
                        yaxis = list(title = 'Y'),
                        zaxis = list(title = 'Z'),
                        aspectmode = "data"),
           title = "Growing LRP<br> MaMuT data",
           annotations = a)

  rm(Spots_df_tmp)
  return(p)
}




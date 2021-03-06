#' Add tensor visualisation to a plotly graph of type mesh3d
#'
#' @param p A plot created with plotlyMesh() function.
#' @param cellGraph A cell graph created with read_cellGraph().
#' @param tensor_name The name of the tensor variable from cell graph to visualise.
#' @inheritParams find_coords
#'
#' @importFrom dplyr inner_join mutate rename starts_with select
#' @importFrom glue glue
#' @importFrom plotly add_trace layout
#' @importFrom purrr pmap
#' @importFrom tidyr unnest
#' @export
#'
#' @examples
#' \dontrun{
#' myMesh <- readRDS(system.file("extdata",
#'  "mgx/2013-02-12_LTi6B_dis_A_T0_cells_minW1_normalMesh_full.rds",
#'   package = "cellviz3d"))
#' myCellGraph <- readRDS(system.file("extdata",
#'  "mgx/2013-02-12_LTi6B_dis_A_T0_cells_minW1_cellGraph_full.rds",
#'   package = "cellviz3d"))
#'
#'  # With a uniform mesh color:
#' p <- plotlyMesh(meshExample = myMesh,
#' meshCellcenter = meshCellcenter) %>%
#' layout(scene =
#' list(aspectmode = "data"))
#'
#' show_tensors(p, myCellGraph,
#' tensor_name = "CellAxiscurv10microns",
#' scale = 50)
#' }
#' @return a plotly graph

show_tensors <- function(p,
                         cellGraph,
                         tensor_name,
                         scale = 1) {

  long.name <- glue("{tensor_name}.{c(1:3, 7)}")
  short.name <- glue("{tensor_name}.{c(4:6, 8)}")

  tmp <- cellGraph$vertices %>%
    rename(
      tipUnit.1 = !!long.name[1],
      tipUnit.2 = !!long.name[2],
      tipUnit.3 = !!long.name[3],
      d = !!long.name[4]
    ) %>%
    mutate(long = pmap(list(x, y, z, tipUnit.1, tipUnit.2, tipUnit.3, d),
                       ~find_coords(cellcenter = c(..1, ..2, ..3),
                                    tipUnit = c(..4, ..5, ..6),
                                    d = ..7,
                                    scale = scale))) %>%
    unnest(long, .sep = ".") %>%
    select(-starts_with("tipUnit"), -d) %>%
    rename(
      tipUnit.1 = !!short.name[1],
      tipUnit.2 = !!short.name[2],
      tipUnit.3 = !!short.name[3],
      d = !!short.name[4]
    ) %>%
    mutate(short = pmap(list(x, y, z, tipUnit.1, tipUnit.2, tipUnit.3, d),
                        ~find_coords(cellcenter = c(..1, ..2, ..3),
                                     tipUnit = c(..4, ..5, ..6),
                                     d = ..7,
                                     scale = scale))) %>%
    unnest(short, .sep = ".") %>%
    select(-starts_with("tipUnit"), -d) %>%
    inner_join(cellGraph$vertices)

  for (i in 1:nrow(tmp)){
    xcoord <- as.vector(t(select(tmp, x, long.x1, long.x2)[i,]))
    ycoord <- as.vector(t(select(tmp, y, long.y1, long.y2)[i,]))
    zcoord <- as.vector(t(select(tmp, z, long.z1, long.z2)[i,]))
    p <- add_trace(p, x = xcoord, y = ycoord, z = zcoord,
                   line = list(color = 'rgb(0, 0, 0)', width = 6), mode = "lines",
                   type = "scatter3d", hoverinfo = 'none') %>%
      layout(showlegend = FALSE)

    xcoord <- as.vector(t(select(tmp, x, short.x1, short.x2)[i,]))
    ycoord <- as.vector(t(select(tmp, y, short.y1, short.y2)[i,]))
    zcoord <- as.vector(t(select(tmp, z, short.z1, short.z2)[i,]))
    p <- add_trace(p, x = xcoord, y = ycoord, z = zcoord,
                   line = list(color = 'rgb(0, 0, 0)', width = 6), mode = "lines",
                   type = "scatter3d", hoverinfo = 'none') %>%
      layout(showlegend = FALSE)

  }
  p
}

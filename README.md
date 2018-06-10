
<!-- README.md is generated from README.Rmd. Please edit that file -->
cellviz3d
=========

The goal of {cellviz3d} is to propose visualisation of meshes created from the segmentation of 3D/4D microscopic images, and point clouds. In particular, it helps visualising meshes from MorphographX, in combination with [{mgx2r}](https://github.com/marionlouveaux/mgx2r), or point clouds from the MaMuT Fiji plugin, in combination with {mamut2r}. <!--[{mamut2r}](https://github.com/marionlouveaux/mamut2r)-->

Installation
------------

You can install the released version of {cellviz3d} from [Github](https://github.com/marionlouveaux/cellviz3d) with:

``` r
# install.packages("devtools")
devtools::install_github("marionlouveaux/cellviz3d")
# With vignettes
devtools::install_github("marionlouveaux/cellviz3d", build_vignettes = TRUE)
```

Vignette
--------

A vignette is available in the package if you built it during installation with `build_vignettes = TRUE`:

-   `vignette("cellviz3d-mgx_meshes", package = "cellviz3d")`: how to build 3d interactive plots of meshes as issued from {mgx2r}

Example
-------

The data in the example below were created with the package {mgx2r}, on the example dataset of {mgx2r}. This dataset is a timelapse recording of the development of a shoot apical meristem of the plant expressing a membrane marker. I took one 3D stack every 12h and have 5 timepoints in total. To know more about the example dataset of {mgx2r}, see `help.search("mgx2r-package")`.

``` r
library(cellviz3d)
library(plotly)
```

``` r
# Read data
myMesh <- readRDS(system.file("extdata",
                              "mgx/mesh_meristem_full_T0.rds",
                              package = "cellviz3d"))

myCellGraph <- readRDS(system.file("extdata",
                                   "mgx/cellGraph_meristem_full_T0.rds",
                                   package = "cellviz3d"))
```

`plotlyMesh()` creates a plotly graph of type mesh 3D, with custom colors and custom hover information for a single mesh. Below, the mesh is displayed with one color and one cell label per biological cell. Cell label is visible when hovering over the cell center.

``` r
meshCellcenter <- myCellGraph$vertices[,c("label","x", "y", "z")]

plotlyMesh(meshExample = myMesh,
           meshColors = myMesh$allColors$Col_label,
           meshCellcenter = meshCellcenter) %>%
  layout(scene = list(aspectmode = "data"))
```

<img src="https://github.com/marionlouveaux/cellviz3d/blob/master/inst/extdata/mgx/img/p1labels.png" width="100%" />

For more examples, see the vignette of {cellviz3d} and {mgx2r}.

Code of conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
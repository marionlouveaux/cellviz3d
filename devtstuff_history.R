# the goal of this file is to keep track of all devtools/usethis
# call you make for yout project

# Feel free to cherry pick what you need and add elements

# install.packages("desc")
# install.packages("devtools")
# install.packages("usethis")

# Hide this file from build
usethis::use_build_ignore("devstuff_history.R")

# DESCRIPTION

library(desc)
# Create and clean desc
my_desc <- description$new("DESCRIPTION")
# Set your package name
my_desc$set("Package", "cellviz3d")

#Set your name
my_desc$set("Authors@R", "person('Marion', 'Louveaux', email = 'marion.louveaux@gmail.com', role = c('cre', 'aut'))")

# Remove some author fields
my_desc$del("Maintainer")

# Set the version
my_desc$set_version("0.0.0.9000")

# The title of your package
my_desc$set(Title = "Tools for 3D/4D interactive visualization of cells and biological tissue")
# The description of your package
my_desc$set(Description = "Proposes visualization for segmented images issued from 3D/4D microscopy. This can be linked with outputs from MorphographX with {mgx2r} or Mamut with {mamut2r}.")

# Depends
my_desc$set(Depends = "R (>= 3.4)")

# The urls
my_desc$set("URL", "https://github.com/marionlouveaux/cellviz3d")
my_desc$set("BugReports", "https://github.com/marionlouveaux/cellviz3d/issues")
# Save everyting
my_desc$write(file = "DESCRIPTION")

# If you want to use the MIT licence, code of conduct, lifecycle badge, and README
usethis::use_gpl3_license(name = "Marion Louveaux")
usethis::use_readme_rmd()
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge("Experimental")
usethis::use_news_md()

# For data
usethis::use_data_raw()

# For tests
usethis::use_testthat()
usethis::use_test("app")

# Dependencies
usethis::use_pipe()
usethis::use_package("shiny")
usethis::use_package("DT")
usethis::use_package("stats")
usethis::use_package("graphics")
usethis::use_package("colorRamps")
usethis::use_package("dplyr")
usethis::use_package("glue")
usethis::use_package("plotly")
usethis::use_package("purrr")
usethis::use_package("tidyr")
usethis::use_package("utils")
# Suggests
usethis::use_package("knitr", type = "Suggests")
usethis::use_package("rmarkdown", type = "Suggests")
usethis::use_package("testthat", type = "Suggests")

# Reorder your DESC
usethis::use_tidy_description()

# Vignette
usethis::use_vignette("mgx-viz3d")
devtools::build_vignettes()

# Github
usethis::use_git()
usethis::browse_github_pat()
usethis::use_github()
usethis::use_github_links()

# Codecov
usethis::use_travis()
# usethis::use_appveyor()
usethis::use_coverage()

# Test with rhub
# rhub::check_for_cran()


#!/bin/bash

docker run -i -v "$PWD"/fishtree:/fishtree rocker/tidyverse:latest R --slave << COMMANDS
options(repos = "https://cloud.r-project.org")
install.packages("fishtree", dependencies = TRUE, Ncpus = 4)
requireNamespace("pkgdown")
td <- tempdir()
xx <- download.packages("fishtree", type = "source", dest = td)
tf <- xx[, 2]
untar(tf, exdir = td, verbose = TRUE)
extpath <- file.path(td, "fishtree")
pkgdown::build_site(extpath, override = list(destination = "/fishtree"))
COMMANDS

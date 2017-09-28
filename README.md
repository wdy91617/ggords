-   [ggords](#ggords)
    -   [Installation](#installation)
    -   [Example Usage](#example-usage)
    -   [Remove the arrow](#remove-the-arrow)
    -   [Modify legend title, group color and point shape](#modify-legend-title-group-color-and-point-shape)
    -   [Add confidence ellipses](#add-confidence-ellipses)
    -   [License](#license)

<!-- README.md is generated from README.Rmd. Please edit that file -->
ggords
======

The package provides six functions: `ggpca()`, `ggca()`, `ggpcoa()`, `ggnmds()`, `ggrda()`, `ggcca()`. You can customize the display labels and themes. Labels can contain formulas. Image themes can be set by themes in ggplots or by other packages(ggthemr).

Installation
------------

``` r
library(devtools)
install_github("wdy91617/ggords")
```

Example Usage
-------------

``` r
library(ggords)
require(vegan)
#> Loading required package: vegan
#> Loading required package: permute
#> Loading required package: lattice
#> This is vegan 2.4-4
require(ggplot2)
#> Loading required package: ggplot2
data(Envs)
```

### get group factor

``` r

Env.w <- hclust(dist(scale(Envs)), "ward.D")
gr <- cutree(Env.w , k=4)
grl <- factor(gr)
```

### Compute PCA

``` r
Env.pca <- rda(Envs,scale = TRUE)
#head(summary(Env.pca))
```

### Produce a plot

``` r
ggpca(Env.pca)
```

<img src="README-unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

### Add a group

``` r
ggpca(Env.pca, group = grl) 
```

<img src="README-unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

### Set a theme

``` r
ggpca(Env.pca, group = grl, spacol = "white") + theme_dark()
```

<img src="README-unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

### Set a theme (use ggthemr packages, more themes in ggthemer)

``` r
library(ggthemr)#[](https://github.com/cttobin/ggthemr)

chalk_theme <- ggthemr('chalk', set_theme = FALSE)
fd_theme <- ggthemr('flat dark', set_theme = FALSE)

p <- ggpca(Env.pca, group = grl, spacol = "white")
p + chalk_theme$theme
```

<img src="README-unnamed-chunk-9-1.png" style="display: block; margin: auto;" />

``` r
p + fd_theme$theme
```

<img src="README-unnamed-chunk-9-2.png" style="display: block; margin: auto;" />

Remove the arrow
----------------

``` r
ggpca(Env.pca, group = grl, spearrow = NULL)
```

<img src="README-unnamed-chunk-10-1.png" style="display: block; margin: auto;" />

Modify legend title, group color and point shape
------------------------------------------------

``` r
ggpca(Env.pca, group = grl, spearrow = NULL) + 
  scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
  scale_shape_manual(name = "Groups",values = c(8,15,16,17))
```

<img src="README-unnamed-chunk-11-1.png" style="display: block; margin: auto;" />

Add confidence ellipses
-----------------------

``` r
ggpca(Env.pca, group = grl, spearrow = NULL, ellipse = TRUE) +
  scale_colour_hue(l = 70, c = 300)
```

<img src="README-unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

License
-------

Released under GPL-3.

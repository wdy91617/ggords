-   [ggords](#ggords)
    -   [Installation](#installation)
    -   [Example Usage](#example-usage)
    -   [Remove the arrow](#remove-the-arrow)
    -   [Modify legend title, group color and point shape](#modify-legend-title-group-color-and-point-shape)
    -   [Add confidence ellipses](#add-confidence-ellipses)
    -   [<img src="README-unnamed-chunk-12-1.png" style="display: block; margin: auto;" />](#section)
    -   [Compute NMDS](#compute-nmds)
    -   [Produce a plot](#produce-a-plot-1)
    -   [Add a group](#add-a-group-1)
    -   [Set a theme](#set-a-theme-1)
    -   [Set a theme (use ggthemr packages, more themes in ggthemer)](#set-a-theme-use-ggthemr-packages-more-themes-in-ggthemer-1)
    -   [Remove the arrow](#remove-the-arrow-1)
    -   [Set labels](#set-labels)
    -   [Modify legend title, group color and point shape](#modify-legend-title-group-color-and-point-shape-1)
    -   [Add confidence ellipses](#add-confidence-ellipses-1)
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

==ggpca==

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

[](https://github.com/cttobin/ggthemr)

``` r
library(ggthemr)

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
---------------------------------------------------------------------------------

------------------------------------------------------------------------

==ggpnmds==

Compute NMDS
------------

``` r
Env.nmds <- metaMDS(Envs, distance="bray")
#> Square root transformation
#> Wisconsin double standardization
#> Run 0 stress 0.04321381 
#> Run 1 stress 0.04321623 
#> ... Procrustes: rmse 0.0004370102  max resid 0.002033296 
#> ... Similar to previous best
#> Run 2 stress 0.06230554 
#> Run 3 stress 0.04321425 
#> ... Procrustes: rmse 0.0006777623  max resid 0.003159122 
#> ... Similar to previous best
#> Run 4 stress 0.06230581 
#> Run 5 stress 0.06230566 
#> Run 6 stress 0.04321597 
#> ... Procrustes: rmse 0.0009571874  max resid 0.004465885 
#> ... Similar to previous best
#> Run 7 stress 0.04321508 
#> ... Procrustes: rmse 0.00025741  max resid 0.001193477 
#> ... Similar to previous best
#> Run 8 stress 0.07029839 
#> Run 9 stress 0.06230485 
#> Run 10 stress 0.04321484 
#> ... Procrustes: rmse 0.0007419825  max resid 0.003454613 
#> ... Similar to previous best
#> Run 11 stress 0.07053354 
#> Run 12 stress 0.07547604 
#> Run 13 stress 0.06230489 
#> Run 14 stress 0.04321522 
#> ... Procrustes: rmse 0.0002997219  max resid 0.001401736 
#> ... Similar to previous best
#> Run 15 stress 0.06230581 
#> Run 16 stress 0.04321402 
#> ... Procrustes: rmse 7.708914e-05  max resid 0.0003530284 
#> ... Similar to previous best
#> Run 17 stress 0.06230519 
#> Run 18 stress 0.04321463 
#> ... Procrustes: rmse 0.0001829384  max resid 0.0008390205 
#> ... Similar to previous best
#> Run 19 stress 0.04321636 
#> ... Procrustes: rmse 0.001005531  max resid 0.004693268 
#> ... Similar to previous best
#> Run 20 stress 0.04321481 
#> ... Procrustes: rmse 0.0007868633  max resid 0.003672846 
#> ... Similar to previous best
#> *** Solution reached
#head(summary(Env.nmds))
```

Produce a plot
--------------

``` r
ggnmds(Env.nmds)
```

![](README-unnamed-chunk-14-1.png)

Add a group
-----------

``` r
ggnmds(Env.nmds, group = grl) 
```

![](README-unnamed-chunk-15-1.png)

Set a theme
-----------

``` r
ggnmds(Env.nmds, group = grl, spacol = "white") + theme_dark()
```

![](README-unnamed-chunk-16-1.png)

Set a theme (use ggthemr packages, more themes in ggthemer)
-----------------------------------------------------------

[](https://github.com/cttobin/ggthemr)

``` r

library(ggthemr)

chalk_theme <- ggthemr('chalk', set_theme = FALSE)
fd_theme <- ggthemr('flat dark', set_theme = FALSE)

p <- ggnmds(Env.nmds, group = grl, spacol = "white")
p + chalk_theme$theme
```

![](README-unnamed-chunk-17-1.png)

``` r
p + fd_theme$theme
```

![](README-unnamed-chunk-17-2.png)

Remove the arrow
----------------

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL)
```

![](README-unnamed-chunk-18-1.png)

Set labels
----------

``` r
mlabs<-c("NH[4]^{`+`}" , "NO[3]^{`-`}" ,"delta^13*C","A[1]","sqrt(2*pi)","frac(x^2,2)",
         "sin(x)","hat(x)","bar(xy)","90*degree","x^{y+z}")

ggnmds(Env.nmds, group = grl, spearrow = NULL, msplabs = mlabs)
```

![](README-unnamed-chunk-19-1.png)

Modify legend title, group color and point shape
------------------------------------------------

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL) + 
  scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
  scale_shape_manual(name = "Groups",values = c(8,15,16,17))
```

![](README-unnamed-chunk-20-1.png)

Add confidence ellipses
-----------------------

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL, ellipse = TRUE) +
  scale_colour_hue(l = 70, c = 300)
```

![](README-unnamed-chunk-21-1.png)

License
-------

Released under GPL-3.

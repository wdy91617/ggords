-   [**ggords**](#ggords)
    -   [Installation](#installation)
    -   [Example Usage](#example-usage)
    -   [**ggpca**](#ggpca)
    -   [**ggpnmds**](#ggpnmds)
    -   [License](#license)

<!-- README.md is generated from README.Rmd. Please edit that file -->
**ggords**
==========

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

------------------------------------------------------------------------

**ggpca**
---------

1.  get group factor

``` r

Env.w <- hclust(dist(scale(Envs)), "ward.D")
gr <- cutree(Env.w , k=4)
grl <- factor(gr)
```

1.  Compute PCA

``` r
Env.pca <- rda(Envs,scale = TRUE)
#head(summary(Env.pca))
```

1.  Produce a plot

``` r
ggpca(Env.pca)
```

<img src="README-unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

-   Add a group

``` r
ggpca(Env.pca, group = grl) 
```

<img src="README-unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

-   Set a theme

``` r
ggpca(Env.pca, group = grl, spacol = "white") + theme_dark()
```

<img src="README-unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

-   Set a theme (use ggthemr packages, more themes in ggthemer) [](https://github.com/cttobin/ggthemr)

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

-   Remove the arrow

``` r
ggpca(Env.pca, group = grl, spearrow = NULL)
```

<img src="README-unnamed-chunk-10-1.png" style="display: block; margin: auto;" />

-   Modify legend title, group color and point shape

``` r
ggpca(Env.pca, group = grl, spearrow = NULL) + 
  scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
  scale_shape_manual(name = "Groups",values = c(8,15,16,17))
```

<img src="README-unnamed-chunk-11-1.png" style="display: block; margin: auto;" />

-   Add confidence ellipses

``` r
ggpca(Env.pca, group = grl, spearrow = NULL, ellipse = TRUE) +
  scale_colour_hue(l = 70, c = 300)
```

<img src="README-unnamed-chunk-12-1.png" style="display: block; margin: auto;" /> \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

**ggpnmds**
-----------

-   Compute NMDS

``` r
Env.nmds <- metaMDS(Envs, distance="bray")
#> Square root transformation
#> Wisconsin double standardization
#> Run 0 stress 0.04321381 
#> Run 1 stress 0.04321485 
#> ... Procrustes: rmse 0.00078967  max resid 0.003684506 
#> ... Similar to previous best
#> Run 2 stress 0.04321434 
#> ... Procrustes: rmse 0.000148537  max resid 0.0006890069 
#> ... Similar to previous best
#> Run 3 stress 0.043215 
#> ... Procrustes: rmse 0.0008034782  max resid 0.003677543 
#> ... Similar to previous best
#> Run 4 stress 0.04321411 
#> ... Procrustes: rmse 0.0006457844  max resid 0.003011902 
#> ... Similar to previous best
#> Run 5 stress 0.04321542 
#> ... Procrustes: rmse 0.0003350677  max resid 0.001561671 
#> ... Similar to previous best
#> Run 6 stress 0.04321395 
#> ... Procrustes: rmse 0.0005693296  max resid 0.002655009 
#> ... Similar to previous best
#> Run 7 stress 0.06230615 
#> Run 8 stress 0.04321455 
#> ... Procrustes: rmse 0.0007211992  max resid 0.003345816 
#> ... Similar to previous best
#> Run 9 stress 0.07681689 
#> Run 10 stress 0.07029498 
#> Run 11 stress 0.04321583 
#> ... Procrustes: rmse 0.0009427922  max resid 0.004399741 
#> ... Similar to previous best
#> Run 12 stress 0.04321398 
#> ... Procrustes: rmse 4.338954e-05  max resid 0.000164707 
#> ... Similar to previous best
#> Run 13 stress 0.04321499 
#> ... Procrustes: rmse 0.0008163096  max resid 0.003791112 
#> ... Similar to previous best
#> Run 14 stress 0.043214 
#> ... Procrustes: rmse 0.0006194595  max resid 0.002890801 
#> ... Similar to previous best
#> Run 15 stress 0.06230502 
#> Run 16 stress 0.04321347 
#> ... New best solution
#> ... Procrustes: rmse 0.0004247602  max resid 0.001980023 
#> ... Similar to previous best
#> Run 17 stress 0.04321623 
#> ... Procrustes: rmse 0.0005637102  max resid 0.002626748 
#> ... Similar to previous best
#> Run 18 stress 0.0432139 
#> ... Procrustes: rmse 0.0001639923  max resid 0.0007590241 
#> ... Similar to previous best
#> Run 19 stress 0.04321388 
#> ... Procrustes: rmse 0.0004587616  max resid 0.002139769 
#> ... Similar to previous best
#> Run 20 stress 0.06230519 
#> *** Solution reached
#head(summary(Env.nmds))
```

-   Produce a plot

``` r
ggnmds(Env.nmds)
```

<img src="README-unnamed-chunk-14-1.png" style="display: block; margin: auto;" />

-   Add a group

``` r
ggnmds(Env.nmds, group = grl) 
```

<img src="README-unnamed-chunk-15-1.png" style="display: block; margin: auto;" />

-   Set a theme

``` r
ggnmds(Env.nmds, group = grl, spacol = "white") + theme_dark()
```

<img src="README-unnamed-chunk-16-1.png" style="display: block; margin: auto;" />

-   Set a theme (use ggthemr packages, more themes in ggthemer) [](https://github.com/cttobin/ggthemr)

``` r

library(ggthemr)

chalk_theme <- ggthemr('chalk', set_theme = FALSE)
fd_theme <- ggthemr('flat dark', set_theme = FALSE)

p <- ggnmds(Env.nmds, group = grl, spacol = "white")
p + chalk_theme$theme
```

<img src="README-unnamed-chunk-17-1.png" style="display: block; margin: auto;" />

``` r
p + fd_theme$theme
```

<img src="README-unnamed-chunk-17-2.png" style="display: block; margin: auto;" />

-   Remove the arrow

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL)
```

<img src="README-unnamed-chunk-18-1.png" style="display: block; margin: auto;" />

-   Set labels

``` r
mlabs<-c("NH[4]^{`+`}" , "NO[3]^{`-`}" ,"delta^13*C","A[1]","sqrt(2*pi)","frac(x^2,2)",
         "sin(x)","hat(x)","bar(xy)","90*degree","x^{y+z}")

ggnmds(Env.nmds, group = grl, spearrow = NULL, msplabs = mlabs)
```

<img src="README-unnamed-chunk-19-1.png" style="display: block; margin: auto;" />

-   Modify legend title, group color and point shape

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL) + 
  scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
  scale_shape_manual(name = "Groups",values = c(8,15,16,17))
```

<img src="README-unnamed-chunk-20-1.png" style="display: block; margin: auto;" />

-   Add confidence ellipses

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL, ellipse = TRUE) +
  scale_colour_hue(l = 70, c = 300)
```

<img src="README-unnamed-chunk-21-1.png" style="display: block; margin: auto;" />

License
-------

Released under GPL-3.

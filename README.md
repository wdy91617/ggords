-   [ggords](#ggords)
    -   [Installation](#installation)
    -   [Example Usage](#example-usage)
    -   [ggpca](#ggpca)
    -   [ggpnmds](#ggpnmds)
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

ggpca
-----

-   get group factor

``` r

Env.w <- hclust(dist(scale(Envs)), "ward.D")
gr <- cutree(Env.w , k=4)
grl <- factor(gr)
```

-   Compute PCA

``` r
Env.pca <- rda(Envs,scale = TRUE)
#head(summary(Env.pca))
```

-   Produce a plot

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

<img src="README-unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

ggpnmds
-------

-   Compute NMDS

``` r
Env.nmds <- metaMDS(Envs, distance="bray")
#> Square root transformation
#> Wisconsin double standardization
#> Run 0 stress 0.04321381 
#> Run 1 stress 0.0432161 
#> ... Procrustes: rmse 0.0009768189  max resid 0.004553941 
#> ... Similar to previous best
#> Run 2 stress 0.04321577 
#> ... Procrustes: rmse 0.0003105869  max resid 0.001437191 
#> ... Similar to previous best
#> Run 3 stress 0.04321513 
#> ... Procrustes: rmse 0.0002243168  max resid 0.001024746 
#> ... Similar to previous best
#> Run 4 stress 0.04321509 
#> ... Procrustes: rmse 0.0008341996  max resid 0.003897355 
#> ... Similar to previous best
#> Run 5 stress 0.04321436 
#> ... Procrustes: rmse 0.0001435139  max resid 0.0006648939 
#> ... Similar to previous best
#> Run 6 stress 0.04321474 
#> ... Procrustes: rmse 0.0002100922  max resid 0.0009694395 
#> ... Similar to previous best
#> Run 7 stress 0.04321559 
#> ... Procrustes: rmse 0.0009094767  max resid 0.004242458 
#> ... Similar to previous best
#> Run 8 stress 0.04321381 
#> ... Procrustes: rmse 2.116557e-05  max resid 7.794265e-05 
#> ... Similar to previous best
#> Run 9 stress 0.04321479 
#> ... Procrustes: rmse 0.000232526  max resid 0.001079938 
#> ... Similar to previous best
#> Run 10 stress 0.04321607 
#> ... Procrustes: rmse 0.0009703773  max resid 0.004526845 
#> ... Similar to previous best
#> Run 11 stress 0.04321617 
#> ... Procrustes: rmse 0.000968435  max resid 0.004518191 
#> ... Similar to previous best
#> Run 12 stress 0.04321517 
#> ... Procrustes: rmse 0.0008287413  max resid 0.003866713 
#> ... Similar to previous best
#> Run 13 stress 0.04321596 
#> ... Procrustes: rmse 0.0009573606  max resid 0.004466765 
#> ... Similar to previous best
#> Run 14 stress 0.04321559 
#> ... Procrustes: rmse 0.0003508798  max resid 0.00164377 
#> ... Similar to previous best
#> Run 15 stress 0.04321579 
#> ... Procrustes: rmse 0.0003862913  max resid 0.001800007 
#> ... Similar to previous best
#> Run 16 stress 0.06230747 
#> Run 17 stress 0.04321492 
#> ... Procrustes: rmse 0.0002574282  max resid 0.001197316 
#> ... Similar to previous best
#> Run 18 stress 0.04321539 
#> ... Procrustes: rmse 0.0003059636  max resid 0.001416406 
#> ... Similar to previous best
#> Run 19 stress 0.07052911 
#> Run 20 stress 0.04321547 
#> ... Procrustes: rmse 0.0003354284  max resid 0.001559937 
#> ... Similar to previous best
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

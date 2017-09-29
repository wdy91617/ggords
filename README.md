-   [ggords](#ggords)
    -   [Installation](#installation)
    -   [Example Usage](#example-usage)
    -   [ggpca](#ggpca)
    -   [<img src="README-unnamed-chunk-12-1.png" style="display: block; margin: auto;" />](#section)
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

### get group factor

``` r

Env.w <- hclust(dist(scale(Envs)), "ward.D")
gr <- cutree(Env.w , k=4)
grl <- factor(gr)
```

ggpca
-----

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

### Remove the arrow

``` r
ggpca(Env.pca, group = grl, spearrow = NULL)
```

<img src="README-unnamed-chunk-10-1.png" style="display: block; margin: auto;" />

### Modify legend title, group color and point shape

``` r
ggpca(Env.pca, group = grl, spearrow = NULL) + 
  scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
  scale_shape_manual(name = "Groups",values = c(8,15,16,17))
```

<img src="README-unnamed-chunk-11-1.png" style="display: block; margin: auto;" />

### Add confidence ellipses

``` r
ggpca(Env.pca, group = grl, spearrow = NULL, ellipse = TRUE) +
  scale_colour_hue(l = 70, c = 300)
```

<img src="README-unnamed-chunk-12-1.png" style="display: block; margin: auto;" />
---------------------------------------------------------------------------------

ggpnmds
-------

### Compute NMDS

``` r
Env.nmds <- metaMDS(Envs, distance="bray")
#> Square root transformation
#> Wisconsin double standardization
#> Run 0 stress 0.04321381 
#> Run 1 stress 0.06230517 
#> Run 2 stress 0.07028756 
#> Run 3 stress 0.04321494 
#> ... Procrustes: rmse 0.0008107163  max resid 0.003782318 
#> ... Similar to previous best
#> Run 4 stress 0.04321447 
#> ... Procrustes: rmse 0.0007233939  max resid 0.003375868 
#> ... Similar to previous best
#> Run 5 stress 0.2242596 
#> Run 6 stress 0.06230542 
#> Run 7 stress 0.07547631 
#> Run 8 stress 0.04321495 
#> ... Procrustes: rmse 0.0002615192  max resid 0.001216665 
#> ... Similar to previous best
#> Run 9 stress 0.04321349 
#> ... New best solution
#> ... Procrustes: rmse 0.0001228359  max resid 0.0005638191 
#> ... Similar to previous best
#> Run 10 stress 0.04321629 
#> ... Procrustes: rmse 0.0005130317  max resid 0.002380866 
#> ... Similar to previous best
#> Run 11 stress 0.04321436 
#> ... Procrustes: rmse 0.0002735052  max resid 0.001272397 
#> ... Similar to previous best
#> Run 12 stress 0.04321409 
#> ... Procrustes: rmse 0.000519119  max resid 0.002428009 
#> ... Similar to previous best
#> Run 13 stress 0.04321464 
#> ... Procrustes: rmse 0.0006352245  max resid 0.002958844 
#> ... Similar to previous best
#> Run 14 stress 0.06230636 
#> Run 15 stress 0.04321588 
#> ... Procrustes: rmse 0.0008283405  max resid 0.003869494 
#> ... Similar to previous best
#> Run 16 stress 0.04321437 
#> ... Procrustes: rmse 0.0002612367  max resid 0.001211465 
#> ... Similar to previous best
#> Run 17 stress 0.06230687 
#> Run 18 stress 0.04321644 
#> ... Procrustes: rmse 0.0005458192  max resid 0.002535889 
#> ... Similar to previous best
#> Run 19 stress 0.06230688 
#> Run 20 stress 0.04321489 
#> ... Procrustes: rmse 0.0006428028  max resid 0.00300134 
#> ... Similar to previous best
#> *** Solution reached
#head(summary(Env.nmds))
```

### Produce a plot

``` r
ggnmds(Env.nmds)
```

![](README-unnamed-chunk-14-1.png)

### Add a group

``` r
ggnmds(Env.nmds, group = grl) 
```

![](README-unnamed-chunk-15-1.png)

### Set a theme

``` r
ggnmds(Env.nmds, group = grl, spacol = "white") + theme_dark()
```

![](README-unnamed-chunk-16-1.png)

### Set a theme (use ggthemr packages, more themes in ggthemer)

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

### Remove the arrow

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL)
```

![](README-unnamed-chunk-18-1.png)

### Set labels

``` r
mlabs<-c("NH[4]^{`+`}" , "NO[3]^{`-`}" ,"delta^13*C","A[1]","sqrt(2*pi)","frac(x^2,2)",
         "sin(x)","hat(x)","bar(xy)","90*degree","x^{y+z}")

ggnmds(Env.nmds, group = grl, spearrow = NULL, msplabs = mlabs)
```

![](README-unnamed-chunk-19-1.png)

### Modify legend title, group color and point shape

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL) + 
  scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
  scale_shape_manual(name = "Groups",values = c(8,15,16,17))
```

![](README-unnamed-chunk-20-1.png)

### Add confidence ellipses

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL, ellipse = TRUE) +
  scale_colour_hue(l = 70, c = 300)
```

![](README-unnamed-chunk-21-1.png)

License
-------

Released under GPL-3.

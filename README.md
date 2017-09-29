-   [**ggords**](#ggords)
    -   [Installation](#installation)
    -   [Example Usage](#example-usage)
    -   [**ggpca**](#ggpca)
    -   [<img src="README-unnamed-chunk-12-1.png" style="display: block; margin: auto;" />](#section)
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

### 1. get group factor

``` r

Env.w <- hclust(dist(scale(Envs)), "ward.D")
gr <- cutree(Env.w , k=4)
grl <- factor(gr)
```

### 2. Compute PCA

``` r
Env.pca <- rda(Envs,scale = TRUE)
#head(summary(Env.pca))
```

### 3. Produce a plot

``` r
ggpca(Env.pca)
```

<img src="README-unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

### 4. Add a group

``` r
ggpca(Env.pca, group = grl) 
```

<img src="README-unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

### 5. Set a theme

``` r
ggpca(Env.pca, group = grl, spacol = "white") + theme_dark()
```

<img src="README-unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

### 6. Set a theme (use ggthemr packages, more themes in ggthemer)

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

### 7. Remove the arrow

``` r
ggpca(Env.pca, group = grl, spearrow = NULL)
```

<img src="README-unnamed-chunk-10-1.png" style="display: block; margin: auto;" />

### 8. Modify legend title, group color and point shape

``` r
ggpca(Env.pca, group = grl, spearrow = NULL) + 
  scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
  scale_shape_manual(name = "Groups",values = c(8,15,16,17))
```

<img src="README-unnamed-chunk-11-1.png" style="display: block; margin: auto;" />

### 9. Add confidence ellipses

``` r
ggpca(Env.pca, group = grl, spearrow = NULL, ellipse = TRUE) +
  scale_colour_hue(l = 70, c = 300)
```

<img src="README-unnamed-chunk-12-1.png" style="display: block; margin: auto;" />
---------------------------------------------------------------------------------

**ggpnmds**
-----------

### 1. Compute NMDS

``` r
Env.nmds <- metaMDS(Envs, distance="bray")
#> Square root transformation
#> Wisconsin double standardization
#> Run 0 stress 0.04321381 
#> Run 1 stress 0.07780163 
#> Run 2 stress 0.06230514 
#> Run 3 stress 0.04321466 
#> ... Procrustes: rmse 0.0002103701  max resid 0.0009778885 
#> ... Similar to previous best
#> Run 4 stress 0.06230674 
#> Run 5 stress 0.06972131 
#> Run 6 stress 0.0432153 
#> ... Procrustes: rmse 0.0008446036  max resid 0.003940961 
#> ... Similar to previous best
#> Run 7 stress 0.04321414 
#> ... Procrustes: rmse 0.0006445698  max resid 0.002967805 
#> ... Similar to previous best
#> Run 8 stress 0.04321403 
#> ... Procrustes: rmse 7.650093e-05  max resid 0.0003470712 
#> ... Similar to previous best
#> Run 9 stress 0.06230544 
#> Run 10 stress 0.06230512 
#> Run 11 stress 0.07053004 
#> Run 12 stress 0.04321578 
#> ... Procrustes: rmse 0.0009354304  max resid 0.004365871 
#> ... Similar to previous best
#> Run 13 stress 0.04321411 
#> ... Procrustes: rmse 4.981915e-05  max resid 0.0001769675 
#> ... Similar to previous best
#> Run 14 stress 0.06230507 
#> Run 15 stress 0.0754822 
#> Run 16 stress 0.04321399 
#> ... Procrustes: rmse 0.0006157943  max resid 0.002873897 
#> ... Similar to previous best
#> Run 17 stress 0.04321492 
#> ... Procrustes: rmse 0.0002552499  max resid 0.001191585 
#> ... Similar to previous best
#> Run 18 stress 0.04321657 
#> ... Procrustes: rmse 0.001032867  max resid 0.004800941 
#> ... Similar to previous best
#> Run 19 stress 0.06230523 
#> Run 20 stress 0.07053404 
#> *** Solution reached
#head(summary(Env.nmds))
```

### 2. Produce a plot

``` r
ggnmds(Env.nmds)
```

<img src="README-unnamed-chunk-14-1.png" style="display: block; margin: auto;" />

### 3. Add a group

``` r
ggnmds(Env.nmds, group = grl) 
```

<img src="README-unnamed-chunk-15-1.png" style="display: block; margin: auto;" />

### 4. Set a theme

``` r
ggnmds(Env.nmds, group = grl, spacol = "white") + theme_dark()
```

<img src="README-unnamed-chunk-16-1.png" style="display: block; margin: auto;" />

### 5. Set a theme (use ggthemr packages, more themes in ggthemer)

[](https://github.com/cttobin/ggthemr)

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

### 6. Remove the arrow

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL)
```

<img src="README-unnamed-chunk-18-1.png" style="display: block; margin: auto;" />

### 7. Set labels

``` r
mlabs<-c("NH[4]^{`+`}" , "NO[3]^{`-`}" ,"delta^13*C","A[1]","sqrt(2*pi)","frac(x^2,2)",
         "sin(x)","hat(x)","bar(xy)","90*degree","x^{y+z}")

ggnmds(Env.nmds, group = grl, spearrow = NULL, msplabs = mlabs)
```

<img src="README-unnamed-chunk-19-1.png" style="display: block; margin: auto;" />

### 8. Modify legend title, group color and point shape

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL) + 
  scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
  scale_shape_manual(name = "Groups",values = c(8,15,16,17))
```

<img src="README-unnamed-chunk-20-1.png" style="display: block; margin: auto;" />

### 9. Add confidence ellipses

``` r
ggnmds(Env.nmds, group = grl, spearrow = NULL, ellipse = TRUE) +
  scale_colour_hue(l = 70, c = 300)
```

<img src="README-unnamed-chunk-21-1.png" style="display: block; margin: auto;" />

License
-------

Released under GPL-3.

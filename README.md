-   [ggords](#ggords)
    -   [Installation](#installation)
    -   [Example Usage](#example-usage)
    -   [Compute NMDS](#compute-nmds)
    -   [Produce a plot](#produce-a-plot)
    -   [Add a group](#add-a-group)
    -   [Set a theme](#set-a-theme)
    -   [Set a theme (use ggthemr packages, more themes in ggthemer)](#set-a-theme-use-ggthemr-packages-more-themes-in-ggthemer)
    -   [Remove the arrow](#remove-the-arrow)
    -   [Set labels](#set-labels)
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

<table>
<colgroup>
<col width="100%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="center">ggpca</td>
</tr>
<tr class="even">
<td align="center">### Compute PCA</td>
</tr>
<tr class="odd">
<td align="center"><code>r Env.pca &lt;- rda(Envs,scale = TRUE) #head(summary(Env.pca))</code></td>
</tr>
<tr class="even">
<td align="center">### Produce a plot</td>
</tr>
<tr class="odd">
<td align="center"><code>r ggpca(Env.pca)</code></td>
</tr>
<tr class="even">
<td align="center"><img src="README-unnamed-chunk-6-1.png" style="display: block; margin: auto;" /></td>
</tr>
<tr class="odd">
<td align="center">### Add a group</td>
</tr>
<tr class="even">
<td align="center"><code>r ggpca(Env.pca, group = grl)</code></td>
</tr>
<tr class="odd">
<td align="center"><img src="README-unnamed-chunk-7-1.png" style="display: block; margin: auto;" /></td>
</tr>
<tr class="even">
<td align="center">### Set a theme</td>
</tr>
<tr class="odd">
<td align="center"><code>r ggpca(Env.pca, group = grl, spacol = &quot;white&quot;) + theme_dark()</code></td>
</tr>
<tr class="even">
<td align="center"><img src="README-unnamed-chunk-8-1.png" style="display: block; margin: auto;" /></td>
</tr>
<tr class="odd">
<td align="center">### Set a theme (use ggthemr packages, more themes in ggthemer) <a href="https://github.com/cttobin/ggthemr"></a></td>
</tr>
<tr class="even">
<td align="center">```r library(ggthemr)</td>
</tr>
<tr class="odd">
<td align="center">chalk_theme &lt;- ggthemr('chalk', set_theme = FALSE) fd_theme &lt;- ggthemr('flat dark', set_theme = FALSE)</td>
</tr>
<tr class="even">
<td align="center">p &lt;- ggpca(Env.pca, group = grl, spacol = &quot;white&quot;) p + chalk_theme$theme ```</td>
</tr>
<tr class="odd">
<td align="center"><img src="README-unnamed-chunk-9-1.png" style="display: block; margin: auto;" /></td>
</tr>
<tr class="even">
<td align="center"><code>r p + fd_theme$theme</code></td>
</tr>
<tr class="odd">
<td align="center"><img src="README-unnamed-chunk-9-2.png" style="display: block; margin: auto;" /></td>
</tr>
<tr class="even">
<td align="center">## Remove the arrow</td>
</tr>
<tr class="odd">
<td align="center"><code>r ggpca(Env.pca, group = grl, spearrow = NULL)</code></td>
</tr>
<tr class="even">
<td align="center"><img src="README-unnamed-chunk-10-1.png" style="display: block; margin: auto;" /></td>
</tr>
<tr class="odd">
<td align="center">## Modify legend title, group color and point shape</td>
</tr>
<tr class="even">
<td align="center"><code>r ggpca(Env.pca, group = grl, spearrow = NULL) + scale_color_manual(name = &quot;Groups&quot;,values = c(&quot;red2&quot;, &quot;purple1&quot;, &quot;grey20&quot;,&quot;cyan&quot;)) + scale_shape_manual(name = &quot;Groups&quot;,values = c(8,15,16,17))</code></td>
</tr>
<tr class="odd">
<td align="center"><img src="README-unnamed-chunk-11-1.png" style="display: block; margin: auto;" /></td>
</tr>
<tr class="even">
<td align="center">## Add confidence ellipses</td>
</tr>
<tr class="odd">
<td align="center"><code>r ggpca(Env.pca, group = grl, spearrow = NULL, ellipse = TRUE) + scale_colour_hue(l = 70, c = 300)</code></td>
</tr>
<tr class="even">
<td align="center"><img src="README-unnamed-chunk-12-1.png" style="display: block; margin: auto;" /></td>
</tr>
</tbody>
</table>

ggpnmds

Compute NMDS
------------

``` r
Env.nmds <- metaMDS(Envs, distance="bray")
#> Square root transformation
#> Wisconsin double standardization
#> Run 0 stress 0.04321381 
#> Run 1 stress 0.06230658 
#> Run 2 stress 0.07053414 
#> Run 3 stress 0.06230556 
#> Run 4 stress 0.04321529 
#> ... Procrustes: rmse 0.0003025622  max resid 0.001402955 
#> ... Similar to previous best
#> Run 5 stress 0.04321398 
#> ... Procrustes: rmse 4.274834e-05  max resid 0.0001708074 
#> ... Similar to previous best
#> Run 6 stress 0.04321452 
#> ... Procrustes: rmse 0.0001735734  max resid 0.0008024154 
#> ... Similar to previous best
#> Run 7 stress 0.04321547 
#> ... Procrustes: rmse 0.0003388551  max resid 0.001576776 
#> ... Similar to previous best
#> Run 8 stress 0.04321397 
#> ... Procrustes: rmse 0.0006037261  max resid 0.002792442 
#> ... Similar to previous best
#> Run 9 stress 0.04321549 
#> ... Procrustes: rmse 0.0003262406  max resid 0.001512939 
#> ... Similar to previous best
#> Run 10 stress 0.04321559 
#> ... Procrustes: rmse 0.0003580126  max resid 0.001665144 
#> ... Similar to previous best
#> Run 11 stress 0.07547583 
#> Run 12 stress 0.04321605 
#> ... Procrustes: rmse 0.0004059887  max resid 0.001888513 
#> ... Similar to previous best
#> Run 13 stress 0.04321555 
#> ... Procrustes: rmse 0.0003418451  max resid 0.001591568 
#> ... Similar to previous best
#> Run 14 stress 0.04321335 
#> ... New best solution
#> ... Procrustes: rmse 0.0003103914  max resid 0.00144304 
#> ... Similar to previous best
#> Run 15 stress 0.04321542 
#> ... Procrustes: rmse 0.0006436892  max resid 0.002997833 
#> ... Similar to previous best
#> Run 16 stress 0.04321534 
#> ... Procrustes: rmse 0.0005629089  max resid 0.002629245 
#> ... Similar to previous best
#> Run 17 stress 0.06972164 
#> Run 18 stress 0.06230484 
#> Run 19 stress 0.07053087 
#> Run 20 stress 0.07780282 
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

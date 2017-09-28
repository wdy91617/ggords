## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 5, fig.height = 4.5, fig.align = "center")

## ------------------------------------------------------------------------
library(ggords)
require(vegan)
require(ggplot2)
data(Spes)


## ------------------------------------------------------------------------
Spe.w <- hclust(dist(scale(Spes)), "ward.D")
gr <- cutree(Spe.w , k=4)
grl <- factor(gr)

## ------------------------------------------------------------------------
Spe.ca <- cca(Spes,scale = TRUE)
#head(summary(Spe.ca))

## ------------------------------------------------------------------------
ggca(Spe.ca)

## ------------------------------------------------------------------------
ggca(Spe.ca, group = grl) 

## ------------------------------------------------------------------------
ggca(Spe.ca, group = grl, spacol = "white") + theme_dark()

## ------------------------------------------------------------------------

# library(ggthemr)#https://github.com/cttobin/ggthemr
# chalk_theme <- ggthemr('chalk', set_theme = FALSE)  
# fd_theme <- ggthemr('flat dark', set_theme = FALSE)  
# p <- ggca(Spe.ca, group = grl, spacol = "white") 
# p + chalk_theme$theme
# p + fd_theme$theme

## ------------------------------------------------------------------------
ggca(Spe.ca, group = grl, spearrow = NULL)

## ------------------------------------------------------------------------
ggca(Spe.ca, group = grl, spearrow = NULL) + 
  scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
  scale_shape_manual(name = "Groups",values = c(8,15,16,17))

## ------------------------------------------------------------------------
ggca(Spe.ca, group = grl, spearrow = NULL, ellipse = TRUE) +
  scale_colour_hue(l = 70, c = 300)


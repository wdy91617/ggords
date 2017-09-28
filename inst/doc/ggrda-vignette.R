## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 5, fig.height = 4.5, fig.align = "center")

## ------------------------------------------------------------------------
library(ggords)
require(vegan)
require(ggplot2)
data(Spes)
data(Envs)

## ------------------------------------------------------------------------
# Hellinger-transform the species dataset
Spe.hel <- decostand(Spes, "hellinger")
 
Spe.w <- hclust(dist(scale(Spes)), "ward.D")
gr <- cutree(Spe.w , k=4)
grl <- factor(gr)

## ------------------------------------------------------------------------
Spe.rda <- rda(Spe.hel, Envs) 
#head(summary(Spe.rda))

## ------------------------------------------------------------------------
ggrda(Spe.rda)

## ------------------------------------------------------------------------
ggrda(Spe.rda, group = grl) 

## ------------------------------------------------------------------------
ggrda(Spe.rda, group = grl, spacol = "white") + theme_dark()

## ------------------------------------------------------------------------

# library(ggthemr)#https://github.com/cttobin/ggthemr
# chalk_theme <- ggthemr('chalk', set_theme = FALSE)  
# fd_theme <- ggthemr('flat dark', set_theme = FALSE)  
# p <- ggrda(Spe.rda, group = grl, spacol = "white") 
# p + chalk_theme$theme
# p + fd_theme$theme

## ------------------------------------------------------------------------
ggrda(Spe.rda, group = grl, spearrow = NULL)

## ------------------------------------------------------------------------
ggrda(Spe.rda, group = grl, spearrow = NULL) + 
  scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
  scale_shape_manual(name = "Groups",values = c(8,15,16,17))

## ------------------------------------------------------------------------
ggrda(Spe.rda, group = grl, spearrow = NULL, ellipse = TRUE) +
  scale_colour_hue(l = 70, c = 300)


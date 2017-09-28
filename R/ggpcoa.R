#' @title \code{"PCoA"} ordination plot
#' @description
#' Output pcoa ordination plot.
#'
#' @details Control of some parts is put in the function. Theme of figure can be set by theme of ggplot2.
#'
#' @param ord An object produced by \code{\link[stats]{cmdscale}}. 
#' @param ordata An dataframe that is provided to function \code{\link[vegan]{wascores}}. 
#' @param groups An grouping factor, its length is the same as the row number of the ordination dataframe.  
#' @param axes Axes shown. 
#' @param obslab A logical value, obslab = FALSE(The row variables are displayed as points), obslab = TRUE(The row variables are displayed as texts).
#' @param moblabs A vector of strings, rename the row variable names displayed. 
#' @param obssize The size of row variables. 
#' @param obscol The colour of row variables. 
#' @param obspch The point shape of row variables.
#' @param obsFonts The family of row variables. 
#' @param obsface The fontface of row variables.
#' 
#' @param spe A logical value, whether the column variables are displayed. 
#' @param msplabs A vector of strings, rename the col variable names displayed.  
#' @param spearrow Arrowhead length of col variables. 
#' @param spelab A logical value, spelab = FALSE(The col variables are displayed as points), spelab = TRUE(The col variables are displayed as texts).
#' @param spmapsize Numeric value, the size of col variable labels is mapped by the length of arrowhead.
#' @param spaline Type of arrowhead segment.
#' @param spalwd Numeric value, the width of arrowhead segment.
#' @param spacol The colour of arrowhead segment. 
#' @param sprotate Numeric value, rotation angle of col variable labels.
#' @param spesize Numeric value, the size of col variable labels or points.
#' @param specol The colour of col variable labels or opoints.  
#' @param spepch Type of col variable labels or points . 
#' @param speFonts The family of col variable labels. 
#' @param speface The fontface of col variable labels.
#' 
#' @param envs Dataframe fitted. 
#' @param mflabs A vector of strings, rename the fitted variable names displayed. 
#' @param farrow Arrowhead length of fitted variables. 
#' @param fmapsize Numeric value, the size of fitted variable labels is mapped by the length of arrowhead.
#' @param faline Arrowhead type of fitted variables. 
#' @param falwd Numeric value, arrowhead width of fitted variables.
#' @param facol Arrowhead colour of fitted variables.
#' @param fzoom Numeric value, scaling arrow length.
#' @param frotate Numeric value, rotation angle of fitted variable labels.
#' @param fsize Numeric value, the size of fitted variable labels or points. 
#' @param fcol The colour of fitted variable labels or opoints.  
#' @param fFonts The family of fitted variable labels. 
#' @param fface The fontface of fitted variable labels. 
#' @param ellipse A logical value, whether confidence ellipses are displayed.  
#' @param ellprob Numeric value, confidence interval.
#' @param cirline Line type of ellipse.
#' @param cirlwd Numeric value, line width of ellipse.
#' @return Returns a ggplot object.
#' @author Dongya Wang <wdy91617@163.com>
#' 
#' @export
#' 
#' @importFrom grid arrow unit
#' @import vegan 
#' @import ggplot2 
#' @importFrom stats qchisq var 
#' @import plyr 
#' 
#' @examples 
#' data(Envs)
#' library(vegan)
#' # get group factor
#' Env.w <- hclust(dist(scale(Envs)), "ward.D")
#' gr <- cutree(Env.w , k=4)
#' grl <- factor(gr)
#'
#' # Compute PCoA
#' Env.bray <- vegdist(Envs)
#' Env.pcoa <- cmdscale(Env.bray, eig=TRUE)
#' summary(Env.pcoa)
#'
#' # Produce a plot 
#' ggpcoa(Env.pcoa, ordata = Envs)
#'
#' # Add a group
#' ggpcoa(Env.pcoa, ordata = Envs, group = grl) 
#'
#' # Set a theme 
#' require(ggplot2)
#' ggpcoa(Env.pcoa, ordata = Envs, group = grl, fcol = "white", facol = "white") + theme_dark()
#'
#' # Remove the arrow
#' ggpcoa(Env.pcoa, ordata = Envs, group = grl, spearrow = NULL)
#'
#' # Modify legend title, group color and point shape
#' ggpcoa(Env.pcoa, group = grl, ordata = Envs, spearrow = NULL) + 
#'   scale_color_manual(name = "Groups",values = c("red2", "purple1", "grey20","cyan")) +
#'   scale_shape_manual(name = "Groups",values = c(8,15,16,17))
#'
#' #Add confidence ellipses
#' ggpcoa(Env.pcoa, ordata = Envs, group = grl, spearrow = NULL, ellipse = TRUE) +
#'   scale_colour_hue(l = 70, c = 300)

ggpcoa <- function(ord,ordata,groups = NULL, axes = c(1,2), obslab = FALSE, moblabs = NULL,
                  obssize = 2, obscol = "black", obspch =16, obsFonts = "serif", obsface = "plain",
                  spe = TRUE, msplabs = NULL, spearrow = 0.2, spelab = TRUE, spmapsize = NULL,
                  spaline = 1, spalwd = 0.5, spacol = "grey30", sprotate = NULL,
                  spesize = 4, specol = "red", spepch = 16, speFonts = "serif",speface = "plain",
                  envs = NULL, mflabs = NULL, farrow = 0.2, fmapsize = NULL,
                  faline = 1, falwd = 0.5, facol = "blue", fzoom = 1, frotate = NULL,
                  fsize = 5, fcol = "blue", fFonts = "serif",fface = "plain",
                  ellipse = FALSE, ellprob = 0.95, cirlwd = 1, cirline = 2){
#############################################################################################################################
# Extracting the the coordinate used for drawing
	obs <- as.data.frame(ord$points[,axes])
	names(obs)[1:2] <- paste0("PCoA", axes)
	spes <- as.data.frame(wascores(obs[,1:2], ordata))

# Extracting the proportion explained
	eigs<-eigenvals(ord)
	expvar = eigs[axes] / sum(eigs)
	xylab <- paste0("PCoA", axes, " (", round(100 * expvar, 2), "%)")

#############################################################################################################################
# plot
	p <- ggplot(obs, aes_string(x = 'PCoA1', y = 'PCoA2')) +
		labs(x=xylab[1],y=xylab[2])+
		geom_vline(xintercept = 0,linetype=2)+
		geom_hline(yintercept = 0,linetype=2)+
		theme_bw()+
		theme(text = element_text(family="serif",face="bold"),
			  axis.title=element_text(size=13),
			  panel.grid.minor = element_blank())

#############################################################################################################################
# Add row variables
	if(!is.null(moblabs)){
		oblabs <- moblabs
	} else {
		oblabs <- row.names(obs)
	}
	
	if(obslab){
		if(!is.null(groups)){
			p <- p + geom_text(aes_string(colour = "groups", label = "oblabs"), size = obssize,family=obsFonts,fontface=obsface,parse = TRUE)
			}else{
				p <- p + geom_text(aes_string(label = "oblabs"),col=obscol, size = obssize,family=obsFonts,fontface=obsface,parse = TRUE)
			}
	} else {
		if(!is.null(groups)){
			p <- p + geom_point(aes_string(colour = "groups",shape = "groups"), size = obssize)
		} else {
		  p <- p + geom_point(size = obssize,col=obscol,shape = obspch)
		}
	}

#############################################################################################################################
# Add col variables
	if(spe){
		if(!is.null(msplabs)){
			splabs <- msplabs
		} else {
			splabs <- row.names(spes)
		}
	##########################################################
		if(!is.null(sprotate)){
		  angles <- with(spes, (180/pi) * atan(PCoA2 / PCoA1))
		  hjusts <- with(spes, (1 - sprotate * sign(PCoA1)) / 2)
		} else {
		  angles<-rep(0,nrow(spes))
		  hjusts<-rep(0.5,nrow(spes))
		}
	##########################################################

	# if(!is.null(spover)){
	  # spes[spover,] <- spes[spover,]*spcut
	# }
	##########################################################

		if(!is.null(spearrow)){
		  p <- p + geom_segment(data = spes[c("PCoA1","PCoA2")]*0.9, aes_string(x = 0, y = 0, xend = 'PCoA1', yend = 'PCoA2'),
								linetype = spaline, size = spalwd, col = spacol,
								arrow = arrow(length = unit(spearrow, "cm"),type = "closed"))
		}
	##########################################################
		if(spelab){
			if(!is.null(spmapsize)){
				splong <- sqrt((spes$PCoA1)^2+(spes$PCoA2)^2) + spmapsize
				p <- p + geom_text(data = spes, aes_string(x = 'PCoA1', y = 'PCoA2', label = "splabs", size = "splong", angle = "angles", hjust = "hjusts"), 
					 parse = TRUE, col = specol, family = speFonts, fontface = speface) + guides(size=FALSE)
			} else {
				p <- p + geom_text(data = spes, aes_string(x = 'PCoA1', y = 'PCoA2', label = "splabs", angle = "angles", hjust = "hjusts"), parse = TRUE,
					 size = spesize, col = specol, family = speFonts, fontface = speface)
			}
		} else {
		  p <- p + geom_point(data = spes, aes_string(x = 'PCoA1', y = 'PCoA2'), size = spesize, col = specol, shape = spepch)
		}
	}

#############################################################################################################################
# Add fitting variables
	if(!is.null(envs)){
		fit <- envfit(ord, envs, perm = 999)
		fits <- as.data.frame(fit$vectors$arrows*sqrt(fit$vectors$r))
		fits <- fits*fzoom
		
		if(!is.null(mflabs)){
		  flabs <- mflabs
		} else {
		  flabs <- row.names(fits)
		}
		##########################################################
		if(!is.null(frotate)){
		  fangles <- with(fits, (180/pi) * atan(Dim2 / Dim1))
		  fhjusts <- with(fits, (1 - frotate * sign(Dim1)) / 2)
		} else {
		  angles<-rep(0,nrow(fits))
		  hjusts<-rep(0.5,nrow(fits))
		}
		##########################################################
		# if(!is.null(fover)){
		  # fits[fover,]<-fits[fover,]*fcut
		# }
		##########################################################
		if(!is.null(farrow))
			p <- p + geom_segment(data = fits[c("Dim1","Dim2")]*0.9, aes_string(x = 0, y = 0, xend = 'Dim1', yend = 'Dim2'),
				 linetype = faline, size = falwd, col = facol,arrow = arrow(length = unit(farrow, "cm"),type = "closed"))
		##########################################################
		if(!is.null(fmapsize)){
			flong <- sqrt((fits$Dim1)^2+(fits$Dim2)^2) + fmapsize
			p <- p + geom_text(data = fits, aes_string(x = 'Dim1', y = 'Dim2', label = "flabs", size = "flong", angle = "fangles", hjust = "fhjusts"),
				 parse = TRUE, col = fcol, family = fFonts, fontface = fface)+ guides(size=FALSE)
		} else {
		  p <- p + geom_text(data = fits, aes_string(x = 'Dim1', y = 'Dim2', label = "flabs",angle = "fangles", hjust = "fhjusts"), parse=  TRUE,
			   size = fsize, col = fcol, family = fFonts, fontface = fface)
		}

	}


#############################################################################################################################
# confidence ellipses
	if(!is.null(groups) && ellipse) {
		theta <- c(seq(-pi, pi, length = 50), seq(pi, -pi, length = 50))
		circle <- cbind(cos(theta), sin(theta))
		obs$groups <- groups
		ellxy <- ddply(obs, 'groups', function(x) {
			  if(nrow(x) <= 2) {return(NULL)}
			  sigma <- var(cbind(x$PCoA1, x$PCoA2))
			  mu <- c(mean(x$PCoA1), mean(x$PCoA2))
			  ed <- sqrt(qchisq(ellprob, df = 2))
			  data.frame(sweep(circle %*% chol(sigma) * ed, 2, mu, FUN = '+'), groups = x$groups[1])
			  })
		names(ellxy)[1:2] <- c('PCoA1', 'PCoA2')
		p <- p + geom_path(data = ellxy, aes_string(x = 'PCoA1', y = 'PCoA2', colour = "groups" ), size = cirlwd, linetype = cirline)  
	}

	return(p)

}

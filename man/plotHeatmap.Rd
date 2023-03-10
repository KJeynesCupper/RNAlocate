% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotHeatmap.R
\name{plotHeatmap}
\alias{plotHeatmap}
\title{Heatmap using hierarchical clustering}
\usage{
plotHeatmap(data, colours = NULL, dendogram = TRUE, margins = NULL)
}
\arguments{
\item{data}{Dataframe contain significant sRNA of a particular class
or type (ie. 24-nt or 21/22-nt sRNA)}

\item{colours}{The colours used to produce the heatmap image.
Defaults to heat colors from `grDevices` (heat.colors(100)).}

\item{dendogram}{logical indicating whether to include the dendrogram, and
retain clustering.}

\item{margins}{numeric vector of length 2, to state width of the heatmap
column names section and row names section, respectively.}
}
\description{
Plot a heatmap with hierarchical clustering via an rlog
transformation of FPKM data and euclidean statistics.
}
\details{
The function create a heatmap based on the hierarchical clustering
of FPKM values using euclidean statistics.
}
\examples{

## DESeq2 example: mobile 24-nt & 21/22-nt sRNA

 # plot heatmap of likely mobile 24-nt sRNA
 data("sRNA_24_mobile_DESeq2")
 p1 <-  plotHeatmap(sRNA_24_mobile_DESeq2)

 # plot heatmap of likely mobile 24-nt sRNA
 data("sRNA_2122_mobile_DESeq2")
 p2 <-  plotHeatmap(sRNA_2122_mobile_DESeq2)



## edgeR example: mobile 24-nt & 21/22-nt sRNA

 # plot heatmap of likely mobile 24-nt sRNA
 data("sRNA_24_mobile_edgeR")
 p3 <-  plotHeatmap(sRNA_24_mobile_edgeR)

 # plot heatmap of likely mobile 24-nt sRNA
 data("sRNA_2122_mobile_edgeR")
 p4 <-  plotHeatmap(sRNA_2122_mobile_edgeR)

}

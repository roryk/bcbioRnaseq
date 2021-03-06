% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/methods-plotGenesDetected.R
\docType{methods}
\name{plotGenesDetected}
\alias{plotGenesDetected}
\alias{plotGenesDetected}
\alias{plotGenesDetected,bcbioRNASeq-method}
\title{Plot Genes Detected}
\usage{
plotGenesDetected(object, ...)

\S4method{plotGenesDetected}{bcbioRNASeq}(object, interestingGroups,
  limit = 0L, minCounts = 1L, fill = scale_fill_hue(), flip = TRUE,
  title = "genes detected")
}
\arguments{
\item{object}{Object.}

\item{...}{Additional arguments.}

\item{interestingGroups}{Character vector denoting groups of interest that
define the samples. If left unset, defaults to \code{sampleName}.}

\item{limit}{Threshold to denote on the plot, using a dashed line.}

\item{minCounts}{Minimum number of counts per gene in the counts matrix.}

\item{fill}{Desired ggplot fill scale. Must supply discrete values. When set
to \code{NULL}, the default ggplot2 color palette will be used. If manual color
definitions are desired, we recommend using \code{\link[ggplot2:scale_fill_manual]{ggplot2::scale_fill_manual()}}.}

\item{flip}{Flip x and y axes.}

\item{title}{Title of plot.}
}
\value{
\code{ggplot}.
}
\description{
Plot Genes Detected
}
\examples{
plotGenesDetected(bcb_small)
}
\seealso{
Other Quality Control Functions: \code{\link{plot5Prime3PrimeBias}},
  \code{\link{plotCorrelationHeatmap}},
  \code{\link{plotCountDensity}},
  \code{\link{plotCountsPerGene}},
  \code{\link{plotDispEsts}},
  \code{\link{plotExonicMappingRate}},
  \code{\link{plotGenderMarkers}},
  \code{\link{plotGeneSaturation}},
  \code{\link{plotIntronicMappingRate}},
  \code{\link{plotMappedReads}},
  \code{\link{plotMappingRate}}, \code{\link{plotMeanSD}},
  \code{\link{plotPCACovariates}}, \code{\link{plotPCA}},
  \code{\link{plotRRNAMappingRate}},
  \code{\link{plotTotalReads}}
}
\author{
Michael Steinbaugh, Rory Kirchner, Victor Barrera
}

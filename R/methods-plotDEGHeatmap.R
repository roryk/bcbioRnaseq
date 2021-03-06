#' Differentially Expressed Gene Heatmap
#'
#' This function is a simplified version of [plotHeatmap()] that is
#' optimized for handling a `DESeqResults` object rather a gene vector. All of
#' the optional parameters for [plotHeatmap()] are also available to this
#' function.
#'
#' To adjust the annotation columns, modify the `colData` of the `counts`
#' argument, which must contain a `SummarizedExperiment` (e.g. `DESeqTransform`,
#' `DESeqDataSet`).
#'
#' @name plotDEGHeatmap
#' @family Differential Expression Functions
#' @author Michael Steinbaugh
#'
#' @inherit bcbioBase::plotHeatmap
#'
#' @inheritParams general
#' @param ... Passthrough arguments to [plotHeatmap()].
#'
#' @seealso
#' - `help("plotHeatmap", "bcbioBase")`.
#' - `findMethod("plotHeatmap", "SummarizedExperiment")`.
#'
#' @examples
#' # DESeqResults, SummarizedExperiment ====
#' plotDEGHeatmap(
#'     results = res_small,
#'     counts = rld_small
#' )
#'
#' # DESeqResults, DESeqDataSet ====
#' # This always uses normalized counts
#' # Using default ggplot2 colors
#' plotDEGHeatmap(
#'     results = res_small,
#'     counts = dds_small,
#'     color = NULL,
#'     legendColor = NULL
#' )
#'
#' # DESeqResults, bcbioRNASeq ====
#' plotDEGHeatmap(
#'     results = res_small,
#'     counts = bcb_small
#' )
NULL



# Methods ======================================================================
#' @rdname plotDEGHeatmap
#' @export
setMethod(
    "plotDEGHeatmap",
    signature(
        results = "DESeqResults",
        counts = "SummarizedExperiment"
    ),
    function(
        results,
        counts,
        alpha,
        lfcThreshold = 0L,
        title = TRUE,
        ...
    ) {
        validObject(results)
        assert_are_identical(rownames(results), rownames(counts))
        if (missing(alpha)) {
            alpha <- metadata(results)[["alpha"]]
        }
        assert_is_a_number(alpha)
        assert_is_a_number(lfcThreshold)
        assert_all_are_non_negative(lfcThreshold)

        # Title
        if (isTRUE(title)) {
            title <- contrastName(results)
        } else if (!is_a_string(title)) {
            title <- NULL
        }

        deg <- significants(results, padj = alpha, fc = lfcThreshold)

        # Early return if there are no DEGs
        if (!length(deg)) {
            return(invisible())
        }

        # Subset the counts to only contain DEGs
        counts <- counts[deg, , drop = FALSE]

        # SummarizedExperiment method
        plotHeatmap(
            object = counts,
            title = title,
            ...
        )
    }
)



#' @rdname plotDEGHeatmap
#' @export
setMethod(
    "plotDEGHeatmap",
    signature(
        results = "DESeqResults",
        counts = "DESeqDataSet"
    ),
    function(
        results,
        counts,
        ...
    ) {
        validObject(counts)
        message("Using normalized counts")
        rse <- as(counts, "RangedSummarizedExperiment")
        assay(rse) <- counts(counts, normalized = TRUE)
        plotDEGHeatmap(
            results = results,
            counts = rse,
            ...
        )
    }
)



#' @rdname plotDEGHeatmap
#' @export
setMethod(
    "plotDEGHeatmap",
    signature(
        results = "DESeqResults",
        counts = "bcbioRNASeq"
    ),
    function(
        results,
        counts,
        normalized = c("rlog", "vst", "tmm", "tpm"),
        ...
    ) {
        validObject(counts)
        normalized <- match.arg(normalized)
        message(paste("Using", normalized, "counts"))
        rse <- as(counts, "RangedSummarizedExperiment")
        assay(rse) <- counts(counts, normalized = normalized)
        plotDEGHeatmap(
            results = results,
            counts = rse,
            ...
        )
    }
)

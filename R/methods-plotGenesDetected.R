#' Plot Genes Detected
#'
#' @name plotGenesDetected
#' @family Quality Control Functions
#' @author Michael Steinbaugh, Rory Kirchner, Victor Barrera
#'
#' @inheritParams general
#'
#' @return `ggplot`.
#'
#' @examples
#' plotGenesDetected(bcb_small)
NULL



# Methods ======================================================================
#' @rdname plotGenesDetected
#' @export
setMethod(
    "plotGenesDetected",
    signature("bcbioRNASeq"),
    function(
        object,
        interestingGroups,
        limit = 0L,
        minCounts = 1L,
        fill = scale_fill_hue(),
        flip = TRUE,
        title = "genes detected"
    ) {
        validObject(object)
        if (missing(interestingGroups)) {
            interestingGroups <- bcbioBase::interestingGroups(object)
        }
        assertIsAnImplicitInteger(limit)
        assert_all_are_non_negative(limit)
        assertIsAnImplicitInteger(minCounts)
        assert_all_are_in_range(minCounts, lower = 1L, upper = Inf)
        assert_all_are_non_negative(minCounts)
        assertIsFillScaleDiscreteOrNULL(fill)
        assert_is_a_bool(flip)
        assertIsAStringOrNULL(title)

        metrics <- metrics(object) %>%
            uniteInterestingGroups(interestingGroups)
        counts <- counts(object, normalized = FALSE)

        p <- ggplot(
            data = metrics,
            mapping = aes_(
                x = ~sampleName,
                y = colSums(counts >= minCounts),
                fill = ~interestingGroups
            )
        ) +
            geom_bar(
                color = "black",
                stat = "identity"
            ) +
            labs(
                title = title,
                x = "sample",
                y = "gene count",
                fill = paste(interestingGroups, collapse = ":\n")
            )

        if (is_positive(limit)) {
            p <- p + .qcLine(limit)
        }

        if (is(fill, "ScaleDiscrete")) {
            p <- p + fill
        }

        if (isTRUE(flip)) {
            p <- p + coord_flip()
        }

        if (identical(interestingGroups, "sampleName")) {
            p <- p + guides(fill = FALSE)
        }

        p
    }
)

treaty_premiums_analysis <- function(..., class = character(0)) {
  structure(
    list(...),
    class = c(class, "treaty_premiums_analysis")
  )
}

#' Apply Treaty to Premiums
#'
#' @param treaty A `treaty` object.
#' @param premiums A data frame with a `premium` column.
#' @export
treaty_apply_premiums <- function(treaty, premiums) {
  UseMethod("treaty_apply_premiums")
}

treaty_claims_analysis <- function(..., class = character(0)) {
  structure(
    list(...),
    class = c(class, "treaty_claims_analysis")
  )
}

#' Apply Treaty to Claims
#'
#' @param treaty A `treaty` object.
#' @param claims A data frame with a `loss` column.
#' @export
treaty_apply_claims <- function(treaty, claims) {
  UseMethod("treaty_apply_claims")
}

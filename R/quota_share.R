#' Quota Share Treaty
#'
#' @param ceded Ceded proportion.
#' @param ceding_commission Ceding commission rate.
#' @export
quota_share <- function(ceded, ceding_commission) {
  structure(
    list(
      ceded = ceded,
      ceding_commission = ceding_commission
    ),
    class = "treaty_quota_share"
  )
}

#' @export
print.treaty_quota_share <- function(x, ...) {
  ceded_pct <- scales::percent(x$ceded)
  ceding_commission_pct <- scales::percent(x$ceding_commission)
  out <- glue::glue(
    "A Quota Share treaty with
      - Ceding percentage of {ceded_pct}
      - Ceding commission of {ceding_commission_pct}
    "
  )
  print(out)
}

#' @importFrom dplyr .data
#' @export
treaty_apply_premiums.treaty_quota_share <- function(treaty, premiums) {
  ceded <- treaty$ceded
  ceding_commission_rate <- treaty$ceding_commission

  result <- premiums %>%
    dplyr::mutate(
      premium_retained = .data$premium * (1 - !!ceded),
      premium_ceded = .data$premium * !!ceded,
      ceding_commission = .data$premium_ceded * !!ceding_commission_rate
    )

  premiums_retained <- sum(result$premium_retained)
  premiums_ceded <- sum(result$premium_ceded)
  ceding_commission <- sum(result$ceding_commission)

  treaty_premiums_analysis(
    premiums_retained = premiums_retained,
    premiums_ceded = premiums_ceded,
    ceding_commission = ceding_commission,
    class = "quota_share_premiums_analysis"
  )
}

#' @export
print.quota_share_premiums_analysis <- function(x, ...) {
  out <- glue::glue(
    "Quota Share premium analysis
      - Premiums retained: {x$premiums_retained}
      - Premiums ceded: {x$premiums_ceded}
      - Ceding commission: {x$ceding_commission}
    "
  )
  print(out)
}

#' @export
treaty_apply_claims.treaty_quota_share <- function(treaty, claims) {
  ceded <- treaty$ceded

  result <- claims %>%
    dplyr::mutate(
      ceded_loss = .data$loss * !!ceded,
      retained_loss = .data$loss - .data$ceded_loss
    )

  treaty_claims_analysis(
    total_claims = sum(result$loss),
    ceded_losses = sum(result$ceded_loss),
    retained_losses = sum(result$retained_loss),
    class = "quota_share_claims_analysis"
  )
}

#' @export
print.quota_share_claims_analysis <- function(x, ...) {
  out <- glue::glue(
    "Quota Share claims analysis
      - Total claims: {scales::dollar(x$total_claims, prefix = '')}
      - Ceded losses: {scales::dollar(x$ceded_losses, prefix = '')}
      - Retained losses: {scales::dollar(x$retained_losses, prefix = '')}
    "
  )
  print(out)
}

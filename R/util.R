format_currency <- function(x, prefix = "") {
  scales::dollar(x, prefix = prefix)
}

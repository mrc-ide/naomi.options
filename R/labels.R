#' Map calibration option ID to JSON calibration option labels
#'
#' @param options Key-value (calibration option name - calibration option ID)
#' list of model options to be mapped.
#'
#' @return Mapped key-value (calibration option name - calibration option label)
#' list of model options
#' @export
get_calibration_option_labels <- function(options) {
  calibration_options <- c(get_calibration_options(),
                           get_age_stratification_options(),
                           get_calibrate_method_options())
  ids <- vapply(calibration_options, "[[", character(1), "id")
  labels <- vapply(calibration_options, "[[", character(1), "label")
  map_option <- function(control_name) {
    match <- ids == options[[control_name]]
    if (sum(match) != 1) { ## i.e. there is 1 match
      stop(t_("CALIBRATION_LABEL_FAILED", list(
        control_name = control_name, value = options[[control_name]])))
    }
    labels[match]
  }
  as.list(vapply(names(options), map_option, character(1), USE.NAMES = TRUE))
}

#' Take a vector of labels and translate
#'
#' @param labels Vector of labels, the translation keys
#' @param lang Language to return output in
#'
#' @return Translated labels for current language
#' @export
translate_labels <- function(labels, lang = traduire::translator()$language()) {
  translated <- c()
  for (label in labels) {
    translated <- c(translated, t_(label, language = lang))
  }
  translated
}

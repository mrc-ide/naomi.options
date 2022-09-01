build_test_options <- function(iso3, type, additional_values) {
  if (type == "model") {
    controls <- get_model_controls()
  } else {
    controls <- get_calibration_controls()
  }
  default_values <- read_hardcoded_defaults(iso3, controls)
  options <- lapply(names(default_values), function(name) {
    if (!has_options(controls[[name]])) {
      ## NULL options if numeric type
      return(NULL)
    }
    vals <- default_values[[name]]
    opts <- list()
    if (all(nzchar(vals))) {
      for (val in vals) {
        opts <- c(opts, list(list(
          id = val,
          label = val
        )))
      }
    }
    additional_value <- additional_values[[name]]
    if (!is.null(additional_value)) {
      opts <- c(opts, list(list(
        id = additional_value,
        label = additional_value
      )))
    }
    opts
  })
  names(options) <- names(default_values)
  options[!vapply(options, is.null, logical(1))]
}

get_control <- function(options_json, name) {
  for (control_section in options_json$controlSection) {
    for (control_group in control_section$controlGroups) {
      for (control in control_group$controls) {
        if (control$name == name) {
          return(control)
        }
      }
    }
  }
  stop(paste0("Failed to find control with name ", name))
}

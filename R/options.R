#' Get the options JSON
#'
#' This gets the JSON for the model or calibration options for a particular
#' country. The control info will be filled in in this order of precedence
#' 1. hardcoded default values from `default_options.csv`
#' 2. `fallback_values` arg (if set)
#'
#' @param type The type of options to get, model or calibration
#' @param iso3 The iso3 of the country to get options for
#' @param options A named list of options to override those in JSON
#' template. Must be in the format of a list of control options i.e.
#' list(
#'   control_id = list(
#'     list(
#'       id = "1",
#'       label = "one"
#'     ),
#'     list(
#'       id = "2",
#'       label = "two"
#'     )
#'   ),
#'   ...
#' )
#' @param fallback_values A list of names values to use as fallbacks if
#' hardcoded defaults are invalid.
#' @param config Additional configuration options for returned JSON. If
#' type is 'model' can set boolean 'include_art' and 'include_anc' to
#' include options for ART and ANC controls. You can also pass
#' `additional_control_groups` which will be appended to the top of the controls
#' JSON. `additional_control_groups` must be a list representing a valid
#' control group object. No affect for 'calibration' type.
#'
#' @return The complete controls JSON
#' @export
get_controls_json <- function(type, iso3, options, fallback_values,
                              config = list()) {
  ## TODO: Assert inputs are sensible
  switch(type,
         "model" = build_model_controls(iso3, options, fallback_values, config),
         "calibration" = build_calibration_controls(iso3, options,
                                                    fallback_values),
         stop(t_("OPTIONS_UNKNOWN_TYPE", list(type = type))))
}

build_model_controls <- function(iso3, options, fallback_values, config) {
  include_art <- config$include_art
  if (!isTRUE(config$include_art)) {
    include_art <- FALSE
  }
  include_anc <- config$include_anc
  if (!isTRUE(config$include_anc)) {
    include_anc <- FALSE
  }

  template <- build_model_template(include_art, include_anc,
                                   config$additional_control_groups)

  controls <- get_model_controls(include_art, include_anc)
  controls <- set_options(controls, options)

  defaults <- read_hardcoded_defaults(iso3, controls)
  controls <- set_values(controls, defaults, fallback_values)

  build_json(template, controls)
}

build_calibration_controls <- function(iso3, options, fallback_values) {
  template <- read_template("calibration_options.json")

  controls <- get_calibration_controls()
  controls <- set_options(controls, options)

  defaults <- read_hardcoded_defaults(iso3, controls)
  controls <- set_values(controls, defaults, fallback_values)

  build_json(template, controls)
}

build_model_template <- function(include_art, include_anc,
                                 additional_control_groups = NULL) {
  template <- read_template("model_options.json")
  if (!is.null(additional_control_groups)) {
    build_single_group <- function(group) {
      control_group <- list(
        label = group$label,
        controls = lapply(group$controls, as_control)
      )
      to_json(recursive_scalar(control_group))
    }
    additional_control_groups <- lapply(additional_control_groups,
                                        build_single_group)
    additional_control_groups <- paste(additional_control_groups,
                                       collapse = ",")
    if (nzchar(additional_control_groups)) {
      additional_control_groups <- paste0(additional_control_groups, ",")
    }
  } else {
    additional_control_groups <- ""
  }

  optional_controls <- list()
  if (include_anc) {
    optional_controls <- c(optional_controls, read_template("anc_options.json"))
  }
  if (include_art) {
    optional_controls <- c(optional_controls, read_template("art_options.json"))
  }
  optional_controls <- paste(optional_controls, collapse = ",")
  if (nzchar(optional_controls)) {
    optional_controls <- paste0(optional_controls, ",")
  }
  ## This is kind of gross but we want a way to have the template be
  ## valid JSON and also have the ability to not include any additional
  ## controls if users do not upload ANC or ART data. So we match and replace
  ## the trailing ,
  glue::glue(template, .open = '"<~', .close = '~>",')
}

read_template <- function(file_name) {
  template <- paste(readLines(system_file(file_name)),
                    collapse = "\n")
  traduire::translator()$replace(template)
}

has_options <- function(control) {
  !is.null(control) && control$type %in% c("select", "multiselect")
}

missing_required_options <- function(control) {
  control$required && (is.null(control$options) || length(control$options) == 0)
}

set_options <- function(controls, options) {
  for (id in names(controls)) {
    if (has_options(controls[[id]])) {
      if (!is.null(options[[id]])) {
        controls[[id]]$options <- options[[id]]
      }
      if (missing_required_options(controls[[id]])) {
        stop(t_("FAILED_TO_SET_OPTIONS", list(control = controls[[id]]$name)))
      }
    }
  }
  controls
}

set_values <- function(controls, defaults, fallback_values) {
  for (control_id in names(controls)) {
    get_value <- switch(controls[[control_id]]$type,
                        "select" = set_select_value,
                        "multiselect" = set_multiselect_value,
                        "number" = set_number_value,
                        stop("Unknown control type"))
    controls[[control_id]]$value <- get_value(controls[[control_id]],
                                              defaults[[control_id]],
                                              fallback_values[[control_id]])
  }
  recursive_scalar(controls)
}

set_select_value <- function(control, default, fallback) {
  possible_ids <- lapply(control$options, "[[", "id")
  ## Valid if not set (e.g. empty string) or it is a possible ID
  is_valid <- function(x) {
    !is.na(x) && !is.null(x) && (x == "" || x %in% possible_ids)
  }
  if (is_valid(default)) {
    value <- default
  } else if (is_valid(fallback[[1]])) {
    value <- fallback[[1]]
  } else {
    value <- NULL
  }
  value
}

set_multiselect_value <- function(control, default, fallback) {
  possible_ids <- lapply(control$options, "[[", "id")
  ## Valid if empty string or each item is in list of possible IDs
  is_single_valid <- function(y) {
    length(y) == 1 && y %in% possible_ids
  }
  is_valid <- function(x) {
    !is.null(x) && (
      !any(nzchar(x)) || all(vapply(x, is_single_valid, logical(1))))
  }
  if (is_valid(default)) {
    value <- default
  } else if (is_valid(fallback)) {
    value <- fallback
  } else {
    value <- NULL
  }
  value
}

set_number_value <- function(control, default, fallback) {
  ## For number type, valid as long as not NULL or NA
  is_valid <- function(x) !is.null(x) && !is.na(x)
  if (is_valid(default)) {
    value <- default
  } else if (is_valid(fallback[[1]])) {
    value <- fallback[[1]]
  } else {
    value <- NULL
  }
  value
}

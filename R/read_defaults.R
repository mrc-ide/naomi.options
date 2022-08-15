read_hardcoded_defaults <- function(iso3, controls) {
  data <- utils::read.csv(system_file("default_options.csv"))
  if (!(iso3 %in% data$iso3)) {
    stop(t_("FAILED_DEFAULT_OPTIONS_ISO3", list(iso3 = iso3)))
  }
  data <- data[data$iso3 == iso3, ]
  data$iso3 <- NULL
  data <- data[, colnames(data) %in% names(controls)]
  data <- as.list(data)
  data <- convert_types(data, controls)
  data
}

convert_types <- function(data, controls) {
  for (control_id in names(data)) {
    convert_type <- switch(controls[[control_id]]$type,
                   "select" = as_select,
                   "multiselect" = as_multiselect,
                   "number" = as.numeric)
    data[[control_id]] <- convert_type(data[[control_id]])
  }
  data
}

as_select <- function(value) {
  if (is.na(value)) {
    return("")
  }
  as.character(value)
}

as_multiselect <- function(value) {
  if (is.na(value) || value == "") {
    return("")
  }
  strsplit(as.character(value), "; *")[[1]]
}

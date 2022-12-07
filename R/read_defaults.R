read_hardcoded_defaults <- function(iso3, controls) {
  data <- read_default_options()
  if (!(iso3 %in% data$iso3)) {
    iso3 <- "fallback"
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

read_default_options <- function() {
  ## We read the table and convert columns here because otherwise excel likes
  ## change types after opening and saving which can lead to problems.
  ## TODO: convert these types by inspecting the type of the control
  default <- data.table::fread(
    system_file("default_options.csv"),
    colClasses = "character",
    data.table = FALSE,
    nThread = 1
  )
  integer_cols <- c(
    "area_level", "anc_clients_year2", "anc_clients_year2_num_months",
    "anc_prevalence_year1", "anc_prevalence_year2", "anc_art_coverage_year1",
    "anc_art_coverage_year2", "max_iterations", "no_of_samples", "rng_seed",
    "artattend_log_gamma_offset", "deff_prev", "deff_artcov", "deff_recent",
    "deff_vls")
  truthy_cols <- c(
    "use_survey_aggregate", "include_art_t1", "include_art_t2", "artattend",
    "artattend_t2", "output_aware_plhiv", "permissive", "use_kish_prev",
    "use_kish_artcov", "use_kish_recent", "use_kish_vls", "rho_paed_x_term",
    "rho_paed_15to49f_ratio", "alpha_xst_term", "adjust_area_growth",
    "anchor_home_district")

  for (column in integer_cols) {
    default[[column]] <- as.integer(default[[column]])
  }
  for (column in truthy_cols) {
    # The actual values we want to match here are "true", "false" as strings
    # so convert truthy cols into lower case
    default[[column]] <- tolower(default[[column]])
  }
  default
}

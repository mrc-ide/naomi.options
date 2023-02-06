control <- function(name, type, required, label = NULL, help_text = NULL,
                    options = NULL, min = NULL, max = NULL, value = NULL) {
  assert_scalar_character(name)
  assert_scalar_character(type)
  assert_scalar_logical(required)
  if (!is.null(label)) {
    assert_scalar_character(label)
    label <- t_(label)
  }
  if (!is.null(help_text)) {
    assert_scalar_character(help_text)
    help_text <- t_(help_text)
  }
  if (!is.null(options)) {
    if (!is.null(min) || !is.null(max)) {
      stop("Control can specify either 'options' or 'min' and 'max' not both")
    }
    if (!is.list(options) || !all(vlapply(options, is.list))) {
      stop("'options' must be a list of lists")
    }
    for (option in options) {
      if (!setequal(names(option), c("id", "label"))) {
        props <- paste(sprintf("'%s'", names(option)), collapse = ", ")
        stop(sprintf(paste0(
          "'options' has option with properties %s, ",
          "must be 'id' and 'label' only"),
          props))
      }
    }
  }
  if (!is.null(min)) {
    assert_scalar_numeric(min)
  }
  if (!is.null(max)) {
    assert_scalar_numeric(max)
  }
  control <- list(
    name = name,
    type = type,
    required = required
  )
  control$label <- label
  control$helpText <- help_text
  control$options <- options
  control$min <- min
  control$max <- max
  control$value <- value
  class(control) <- "control"
  control
}

is_control <- function(obj) {
  inherits(obj, "naomi_control")
}

as_control <- function(obj) {
  if (!is_control(obj)) {
    obj <- control(obj$name, obj$type, obj$required, obj$label, obj$help_text,
                   obj$options, obj$min, obj$max, obj$value)
  }
  obj
}

get_calibration_options <- function() {
  list(
    list(
      id = "none",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_NONE")
    ),
    list(
      id = "national",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_NATIONAL")
    ),
    list(
      id = "subnational",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_SUBNATIONAL")
    )
  )
}

get_age_stratification_options <- function() {
  list(
    list(
      id = "age_coarse",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_AGE_COARSE_LABEL")
    ),
    list(
      id = "sex_age_coarse",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_SEX_AGE_COARSE_LABEL")
    ),
    list(
      id = "age_group",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_AGE_GROUP_LABEL")
    ),
    list(
      id = "sex_age_group",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_SEX_AGE_GROUP_LABEL")
    )
  )
}

get_calibrate_method_options <- function() {
  list(
    list(
      id = "logistic",
      label = t_("OPTIONS_CALIBRATE_METHOD_LOGISTIC_LABEL")
    ),
    list(
      id = "proportional",
      label = t_("OPTIONS_CALIBRATE_METHOD_PROPORTIONAL_LABEL")
    )
  )
}

get_model_controls <- function(include_art, include_anc) {
  yes_no_options <- list(
    list(
      id = "true",
      label = t_("OPTIONS_YES_LABEL")
    ),
    list(
      id = "false",
      label = t_("OPTIONS_NO_LABEL")
    )
  )

  month_options <- list(
    list(
      id = "12",
      label = t_("OPTIONS_12_MONTHS")
    ),
    list(
      id = "11",
      label = t_("OPTIONS_11_MONTHS")
    ),
    list(
      id = "10",
      label = t_("OPTIONS_10_MONTHS")
    ),
    list(
      id = "9",
      label = t_("OPTIONS_9_MONTHS")
    ),
    list(
      id = "8",
      label = t_("OPTIONS_8_MONTHS")
    ),
    list(
      id = "7",
      label = t_("OPTIONS_7_MONTHS")
    ),
    list(
      id = "6",
      label = t_("OPTIONS_6_MONTHS")
    ),
    list(
      id = "5",
      label = t_("OPTIONS_5_MONTHS")
    ),
    list(
      id = "4",
      label = t_("OPTIONS_4_MONTHS")
    ),
    list(
      id = "3",
      label = t_("OPTIONS_3_MONTHS")
    ),
    list(
      id = "2",
      label = t_("OPTIONS_2_MONTHS")
    ),
    list(
      id = "1",
      label = t_("OPTIONS_1_MONTHS")
    )
  )

  projection_quarter_options <- list(
    list(
      id = "CY2020Q1",
      label = paste(t_("MONTH_MARCH"), "2020")
    ),
    list(
      id = "CY2020Q2",
      label = paste(t_("MONTH_JUNE"), "2020")
    ),
    list(
      id = "CY2020Q3",
      label = paste(t_("MONTH_SEPTEMBER"), "2020")
    ),
    list(
      id = "CY2020Q4",
      label = paste(t_("MONTH_DECEMBER"), "2020")
    ),
    list(
      id = "CY2021Q1",
      label = paste(t_("MONTH_MARCH"), "2021")
    ),
    list(
      id = "CY2021Q2",
      label = paste(t_("MONTH_JUNE"), "2021")
    ),
    list(
      id = "CY2021Q3",
      label = paste(t_("MONTH_SEPTEMBER"), "2021")
    ),
    list(
      id = "CY2021Q4",
      label = paste(t_("MONTH_DECEMBER"), "2021")
    ),
    list(
      id = "CY2022Q1",
      label = paste(t_("MONTH_MARCH"), "2022")
    ),
    list(
      id = "CY2022Q2",
      label = paste(t_("MONTH_JUNE"), "2022")
    ),
    list(
      id = "CY2022Q3",
      label = paste(t_("MONTH_SEPTEMBER"), "2022")
    ),
    list(
      id = "CY2022Q4",
      label = paste(t_("MONTH_DECEMBER"), "2022")
    ),
    list(
      id = "CY2023Q1",
      label = paste(t_("MONTH_MARCH"), "2023")
    ),
    list(
      id = "CY2023Q2",
      label = paste(t_("MONTH_JUNE"), "2023")
    ),
    list(
      id = "CY2023Q3",
      label = paste(t_("MONTH_SEPTEMBER"), "2023")
    ),
    list(
      id = "CY2023Q4",
      label = paste(t_("MONTH_DECEMBER"), "2023")
    ),
    list(
      id = "CY2024Q1",
      label = paste(t_("MONTH_MARCH"), "2024")
    ),
    list(
      id = "CY2024Q2",
      label = paste(t_("MONTH_JUNE"), "2024")
    ),
    list(
      id = "CY2024Q3",
      label = paste(t_("MONTH_SEPTEMBER"), "2024")
    ),
    list(
      id = "CY2024Q4",
      label = paste(t_("MONTH_DECEMBER"), "2024")
    ),
        list(
      id = "CY2025Q1",
      label = paste(t_("MONTH_MARCH"), "2025")
    ),
    list(
      id = "CY2025Q2",
      label = paste(t_("MONTH_JUNE"), "2025")
    ),
    list(
      id = "CY2025Q3",
      label = paste(t_("MONTH_SEPTEMBER"), "2025")
    ),
    list(
      id = "CY2025Q4",
      label = paste(t_("MONTH_DECEMBER"), "2025")
    )
  )

  controls <- list(
    area_scope = control(
      name = "area_scope",
      type = "multiselect",
      required = TRUE
    ),
    area_level = control(
      name = "area_level",
      type = "select",
      required = TRUE
    ),
    calendar_quarter_t1 = control(
      name = "calendar_quarter_t1",
      type = "select",
      required = TRUE
    ),
    calendar_quarter_t2 = control(
      name = "calendar_quarter_t2",
      type = "select",
      required = TRUE
    ),
    calendar_quarter_t3 = control(
      name = "calendar_quarter_t3",
      type = "select",
      required = TRUE,
      help_text = "OPTIONS_OUTPUT_PROJECTION_QUARTER_HELP",
      options = projection_quarter_options
    ),
    calendar_quarter_t4 = control(
      name = "calendar_quarter_t4",
      label = "COP_Y1_END_LABEL",
      type = "select",
      required = TRUE,
      options = projection_quarter_options
    ),
    calendar_quarter_t5 = control(
      name = "calendar_quarter_t5",
      label = "COP_Y2_END_LABEL",
      type = "select",
      required = TRUE,
      options = projection_quarter_options
    ),
    survey_prevalence = control(
      name = "survey_prevalence",
      type = "multiselect",
      required = TRUE
    ),
    survey_art_coverage = control(
      name = "survey_art_coverage",
      type = "multiselect",
      required = FALSE
    ),
    spectrum_population_calibration = control(
      name = "spectrum_population_calibration",
      type = "select",
      help_text = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_POPULATION_HELP",
      required = TRUE,
      options = get_calibration_options()
    ),
    output_aware_plhiv = control(
      name = "output_aware_plhiv",
      type = "select",
      help_text = "OPTIONS_ADVANCED_OUTPUT_AWARE_HELP",
      required = TRUE,
      options = yes_no_options
    ),
    max_iterations = control(
      name = "max_iteration",
      type = "number",
      help_text = "OPTIONS_ADVANCED_MAX_ITERATIONS_HELP",
      required = TRUE
    ),
    no_of_samples = control(
      name = "no_of_samples",
      type = "number",
      help_text = "OPTIONS_ADVANCED_NO_OF_SIMULATIONS_HELP",
      required = TRUE
    ),
    rng_seed = control(
      name = "rng_seed",
      type = "number",
      help_text = "OPTIONS_ADVANCED_SIMULATION_SEED_HELP",
      required = FALSE
    ),
    artattend_log_gamma_offset = control(
      name = "artattend_log_gamma_offset",
      type = "number",
      help_text = "OPTIONS_ADVANCED_LOGIT_HELP",
      required = TRUE
    ),
    anchor_home_district = control(
      name = "anchor_home_district",
      type = "select",
      help_text = "OPTIONS_ADVANCED_ANCHOR_ART_ATTEND_HELP",
      required = TRUE,
      options = yes_no_options
    ),
    rho_paed_x_term = control(
      name = "rho_paed_x_term",
      type = "select",
      required = TRUE,
      options = yes_no_options
    ),
    rho_paed_15to49f_ratio = control(
      name = "rho_paed_15to49f_ratio",
      type = "select",
      required = TRUE,
      options = yes_no_options
    ),
    alpha_xst_term = control(
      name = "alpha_xst_term",
      type = "select",
      required = TRUE,
      options = yes_no_options
    ),
    adjust_area_growth = control(
      name = "adjust_area_growth",
      type = "select",
      help_text = "OPTIONS_USE_SURVEY_AGGREGATE_HELP",
      required = TRUE,
      options = yes_no_options
    ),
    use_survey_aggregate = control(
      name = "use_survey_aggregate",
      type = "select",
      required = TRUE,
      options = yes_no_options
    ),
    survey_recently_infected = control(
      name = "survey_recently_infected",
      type = "multiselect",
      required = FALSE
    ),
    use_kish_prev = control(
      name = "use_kish_prev",
      label = "OPTIONS_ADVANCED_USE_KISH_LABEL",
      type = "select",
      required = TRUE,
      help_text = "OPTIONS_ADVANCED_USE_KISH_HELP",
      options = yes_no_options
    ),
    deff_prev = control(
      name = "deff_prev",
      label = "OPTIONS_ADVANCED_ESS_SCALING_LABEL",
      type = "number",
      required = TRUE,
      help_text = "OPTIONS_ADVANCED_DEFF_PREVALENCE_HELP"
    ),
    use_kish_artcov = control(
      name = "use_kish_artcov",
      label = "OPTIONS_ADVANCED_USE_KISH_LABEL",
      type = "select",
      required = TRUE,
      help_text = "OPTIONS_ADVANCED_USE_KISH_HELP",
      options = yes_no_options
    ),
    deff_artcov = control(
      name = "deff_artcov",
      label = "OPTIONS_ADVANCED_ESS_SCALING_LABEL",
      type = "number",
      required = TRUE,
      help_text = "OPTIONS_ADVANCED_DEFF_ART_COVERAGE_HELP"
    ),
    use_kish_recent = control(
      name = "use_kish_recent",
      label = "OPTIONS_ADVANCED_USE_KISH_LABEL",
      type = "select",
      required = TRUE,
      help_text = "OPTIONS_ADVANCED_USE_KISH_HELP",
      options = yes_no_options
    ),
    deff_recent = control(
      name = "deff_recent",
      label = "OPTIONS_ADVANCED_ESS_SCALING_LABEL",
      type = "number",
      required = TRUE,
      help_text = "OPTIONS_ADVANCED_DEFF_PROPORTION_RECENT_HELP"
    ),
    psnu_level = control(
      name = "psnu_level",
      type = "select",
      required = FALSE
    )
  )

  if (include_anc) {
    controls <- c(
      controls,
      list(
        anc_clients_year2 = control(
          name = "anc_clients_year2",
          label = "OPTIONS_T2_LABEL",
          type = "select",
          help_text = "OPTIONS_T2_HELP",
          required = FALSE
        ),
        anc_clients_year2_num_months = control(
          name = "anc_clients_year2_num_months",
          label = "OPTIONS_T2_LABEL",
          type = "select",
          help_text = "OPTIONS_ANC_MONTHS_HELP",
          required = TRUE,
          options = month_options
        ),
        anc_prevalence_year1 = control(
          name = "anc_prevalence_year1",
          label = "OPTIONS_T1_LABEL",
          type = "select",
          help_text = "OPTIONS_T1_HELP",
          required = FALSE
        ),
        anc_prevalence_year2 = control(
          name = "anc_prevalence_year2",
          label = "OPTIONS_T2_LABEL",
          type = "select",
          help_text = "OPTIONS_T2_HELP",
          required = FALSE
        ),
        anc_art_coverage_year1 = control(
          name = "anc_art_coverage_year1",
          label = "OPTIONS_T1_LABEL",
          type = "select",
          help_text = "OPTIONS_T1_HELP",
          required = FALSE
        ),
        anc_art_coverage_year2 = control(
          name = "anc_art_coverage_year2",
          label = "OPTIONS_T2_LABEL",
          type = "select",
          help_text = "OPTIONS_T2_HELP",
          required = FALSE
        )
      )
    )
  }
  if (include_art) {
    controls <- c(
      controls,
      list(
        include_art_t1 = control(
          name = "include_art_t1",
          label = "OPTIONS_T1_LABEL",
          type = "select",
          help_text = "OPTIONS_T1_HELP",
          required = TRUE,
          options = yes_no_options
        ),
        include_art_t2 = control(
          name = "include_art_t2",
          label = "OPTIONS_T2_LABEL",
          type = "select",
          help_text = "OPTIONS_T2_HELP",
          required = TRUE,
          options = yes_no_options
        ),
        artattend = control(
          name = "artattend",
          type = "select",
          help_text = "OPTIONS_ART_NEIGHBOURING_DISTRICT_HELP",
          required = TRUE,
          options = yes_no_options
        ),
        artattend_t2 = control(
          name = "artattend_t2",
          type = "select",
          help_text = "OPTIONS_ART_TIME_VARYING_ART_ATTEND_HELP",
          required = TRUE,
          options = yes_no_options
        )
      )
    )
  }
  controls
}

get_calibration_controls <- function() {
  calibration_level_opts <- get_calibration_options()
  age_strat_opts <- get_age_stratification_options()

  list(
    spectrum_plhiv_calibration_level = control(
      name = "spectrum_plhiv_calibration_level",
      label = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_LEVEL_LABEL",
      type = "select",
      required = TRUE,
      options = calibration_level_opts,
      help_text = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_PLHIV_HELP"
    ),

    spectrum_plhiv_calibration_strat = control(
      name = "spectrum_plhiv_calibration_strat",
      label = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_STRATIFICATION_LABEL",
      type = "select",
      required = TRUE,
      options = age_strat_opts,
      help_text = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_PLHIV_HELP"
    ),

    spectrum_artnum_calibration_level = control(
      name = "spectrum_artnum_calibration_level",
      label = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_LEVEL_LABEL",
      type = "select",
      required = TRUE,
      options = calibration_level_opts,
      help_text = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_ART_HELP"
    ),

    spectrum_artnum_calibration_strat = control(
      name = "spectrum_artnum_calibration_strat",
      label = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_STRATIFICATION_LABEL",
      type = "select",
      required = TRUE,
      options = age_strat_opts,
      help_text = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_ART_HELP"
    ),

    spectrum_aware_calibration_level = control(
      name = "spectrum_aware_calibration_level",
      label = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_LEVEL_LABEL",
      type = "select",
      required = TRUE,
      options = calibration_level_opts,
      help_text = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_AWARE_HELP"
    ),

    spectrum_aware_calibration_strat = control(
      name = "spectrum_aware_calibration_strat",
      label = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_STRATIFICATION_LABEL",
      type = "select",
      required = TRUE,
      options = age_strat_opts,
      help_text = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_AWARE_HELP"
    ),

    spectrum_infections_calibration_level = control(
      name = "spectrum_infections_calibration_level",
      label = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_LEVEL_LABEL",
      type = "select",
      required = TRUE,
      options = calibration_level_opts,
      help_text = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_INFECTIONS_HELP"
    ),

    spectrum_infections_calibration_strat = control(
      name = "spectrum_infections_calibration_strat",
      label = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_STRATIFICATION_LABEL",
      type = "select",
      required = TRUE,
      options = age_strat_opts,
      help_text = "OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_INFECTIONS_HELP"
    ),

    calibrate_method = control(
      name = "calibrate_method",
      type = "select",
      required = TRUE,
      options = get_calibrate_method_options()
    )
  )
}

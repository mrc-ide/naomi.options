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

get_model_controls <- function() {
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

  list(
    area_scope = list(
      name = "area_scope",
      type = "multiselect",
      required = TRUE
    ),
    area_level = list(
      name = "area_level",
      type = "select",
      required = TRUE
    ),
    calendar_quarter_t1 = list(
      name = "calendar_quarter_t1",
      type = "select",
      required = TRUE
    ),
    calendar_quarter_t2 = list(
      name = "calendar_quarter_t2",
      type = "select",
      required = TRUE,
      value = "CY2021Q4"
    ),
    calendar_quarter_t3 = list(
      name = "calendar_quarter_t3",
      type = "select",
      required = TRUE,
      value = "CY2022Q3",
      helpText = t_("OPTIONS_OUTPUT_PROJECTION_QUARTER_HELP"),
      options = list(
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
        )
      )
    ),
    survey_prevalence = list(
      name = "survey_prevalence",
      type = "multiselect",
      required = TRUE
    ),
    survey_art_coverage = list(
      name = "survey_art_coverage",
      type = "multiselect",
      required = FALSE
    ),
    include_art_t1 = list(
      name = "include_art_t1",
      label = t_("OPTIONS_T1_LABEL"),
      type = "select",
      help_text = t_("OPTIONS_T1_HELP"),
      required = TRUE,
      options = yes_no_options
    ),
    include_art_t2 = list(
      name = "include_art_t2",
      label = t_("OPTIONS_T2_LABEL"),
      type = "select",
      help_text = t_("OPTIONS_T2_HELP"),
      required = TRUE,
      options = yes_no_options
    ),
    artattend = list(
      name = "artattend",
      type = "select",
      help_text = t_("OPTIONS_ART_NEIGHBOURING_DISTRICT_HELP"),
      required = TRUE,
      options = yes_no_options,
      value = "true"
    ),
    artattend_t2 = list(
      name = "artattend_t2",
      type = "select",
      help_text = t_("OPTIONS_ART_TIME_VARYING_ART_ATTEND_HELP"),
      required = TRUE,
      options = yes_no_options,
      value = "true"
    ),
    anc_clients_year2 = list(
      name = "anc_clients_year2",
      label = t_("OPTIONS_T2_LABEL"),
      type = "select",
      help_text = t_("OPTIONS_T2_HELP"),
      required = FALSE
    ),
    anc_clients_year2_num_months = list(
      name = "anc_clients_year2_num_months",
      label = t_("OPTIONS_T2_LABEL"),
      type = "select",
      help_text = t_("OPTIONS_ANC_MONTHS_HELP"),
      required = TRUE,
      options = month_options,
      value = "12"
    ),
    anc_prevalence_year1 = list(
      name = "anc_prevalence_year1",
      label = t_("OPTIONS_T1_LABEL"),
      type = "select",
      help_text = t_("OPTIONS_T1_HELP"),
      required = FALSE
    ),
    anc_prevalence_year2 = list(
      name = "anc_prevalence_year2",
      label = t_("OPTIONS_T2_LABEL"),
      type = "select",
      help_text = t_("OPTIONS_T2_HELP"),
      required = FALSE
    ),
    anc_art_coverage_year1 = list(
      name = "anc_art_coverage_year1",
      label = t_("OPTIONS_T1_LABEL"),
      type = "select",
      help_text = t_("OPTIONS_T1_HELP"),
      required = FALSE
    ),
    anc_art_coverage_year2 = list(
      name = "anc_art_coverage_year2",
      label = t_("OPTIONS_T2_LABEL"),
      type = "select",
      help_text = t_("OPTIONS_T2_HELP"),
      required = FALSE
    ),
    spectrum_population_calibration = list(
      name = "spectrum_population_calibration",
      type = "select",
      help_text = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_POPULATION_HELP"),
      required = TRUE,
      options = get_calibration_options(),
      value = "subnational"
    ),
    output_aware_plhiv = list(
      name = "output_aware_plhiv",
      type = "select",
      help_text = t_("OPTIONS_ADVANCED_OUTPUT_AWARE_HELP"),
      required = TRUE,
      options = yes_no_options,
      value = "true"
    ),
    max_iterations = list(
      name = "max_iteration",
      type = "number",
      helpText = t_("OPTIONS_ADVANCED_MAX_ITERATIONS_HELP"),
      required = TRUE
    ),
    no_of_samples = list(
      name = "no_of_samples",
      type = "number",
      helpText = t_("OPTIONS_ADVANCED_NO_OF_SIMULATIONS_HELP"),
      required = TRUE
    ),
    rng_seed = list(
      name = "rng_seed",
      type = "number",
      helpText = t_("OPTIONS_ADVANCED_SIMULATION_SEED_HELP"),
      required = FALSE
    ),
    artattend_log_gamma_offset = list(
      name = "artattend_log_gamma_offset",
      type = "number",
      helpText = t_("OPTIONS_ADVANCED_LOGIT_HELP"),
      required = TRUE
    ),
    rho_paed_x_term = list(
      name = "rho_paed_x_term",
      type = "select",
      required = TRUE,
      options = yes_no_options,
      value = "false"
    ),
    rho_paed_15to49f_ratio = list(
      name = "rho_paed_15to49f_ratio",
      type = "select",
      required = TRUE,
      options = yes_no_options,
      value = "true"
    ),
    alpha_xst_term = list(
      name = "alpha_xst_term",
      type = "select",
      required = TRUE,
      options = yes_no_options,
      value = "false"
    ),
    adjust_area_growth = list(
      name = "adjust_area_growth",
      type = "select",
      helpText = t_("OPTIONS_USE_SURVEY_AGGREGATE_HELP"),
      required = TRUE,
      options = yes_no_options,
      value = "false"
    ),
    use_survey_aggregate = list(
      name = "use_survey_aggregate",
      type = "select",
      required = TRUE,
      options = yes_no_options,
      value = "false"
    ),
    survey_recently_infected = list(
      name = "survey_recently_infected",
      type = "multiselect",
      required = FALSE
    ),
    use_kish_prev = list(
      name = "use_kish_prev",
      label = t_("OPTIONS_ADVANCED_USE_KISH_LABEL"),
      type = "select",
      required = TRUE,
      helpText = t_("OPTIONS_ADVANCED_USE_KISH_HELP"),
      options = yes_no_options,
      value = "true"
    ),
    deff_prev = list(
      name = "deff_prev",
      label = t_("OPTIONS_ADVANCED_ESS_SCALING_LABEL"),
      type = "number",
      required = TRUE,
      helpText = t_("OPTIONS_ADVANCED_DEFF_PREVALENCE_HELP")
    ),
    use_kish_artcov = list(
      name = "use_kish_artcov",
      label = t_("OPTIONS_ADVANCED_USE_KISH_LABEL"),
      type = "select",
      required = TRUE,
      helpText = t_("OPTIONS_ADVANCED_USE_KISH_HELP"),
      options = yes_no_options,
      value = "true"
    ),
    deff_artcov = list(
      name = "deff_artcov",
      label = t_("OPTIONS_ADVANCED_ESS_SCALING_LABEL"),
      type = "number",
      required = TRUE,
      helpText = t_("OPTIONS_ADVANCED_DEFF_ART_COVERAGE_HELP")
    ),
    use_kish_recent = list(
      name = "use_kish_recent",
      label = t_("OPTIONS_ADVANCED_USE_KISH_LABEL"),
      type = "select",
      required = TRUE,
      helpText = t_("OPTIONS_ADVANCED_USE_KISH_HELP"),
      options = yes_no_options,
      value = "true"
    ),
    deff_recent = list(
      name = "deff_recent",
      label = t_("OPTIONS_ADVANCED_ESS_SCALING_LABEL"),
      type = "number",
      required = TRUE,
      helpText = t_("OPTIONS_ADVANCED_DEFF_PROPORTION_RECENT_HELP")
    )
  )
}

get_calibration_controls <- function() {
  calibration_level_opts <- get_calibration_options()

  age_strat_opts <- list(
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

  list(
    spectrum_plhiv_calibration_level = list(
      name = "spectrum_plhiv_calibration_level",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_LEVEL_LABEL"),
      type = "select",
      required = TRUE,
      options = calibration_level_opts,
      helpText = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_PLHIV_HELP")
    ),

    spectrum_plhiv_calibration_strat = list(
      name = "spectrum_plhiv_calibration_strat",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_STRATIFICATION_LABEL"),
      type = "select",
      required = TRUE,
      options = age_strat_opts,
      helpText = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_PLHIV_HELP")
    ),

    spectrum_artnum_calibration_level = list(
      name = "spectrum_artnum_calibration_level",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_LEVEL_LABEL"),
      type = "select",
      required = TRUE,
      options = calibration_level_opts,
      helpText = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_ART_HELP")
    ),

    spectrum_artnum_calibration_strat = list(
      name = "spectrum_artnum_calibration_strat",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_STRATIFICATION_LABEL"),
      type = "select",
      required = TRUE,
      options = age_strat_opts,
      helpText = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_ART_HELP")
    ),

    spectrum_aware_calibration_level = list(
      name = "spectrum_aware_calibration_level",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_LEVEL_LABEL"),
      type = "select",
      required = TRUE,
      options = calibration_level_opts,
      helpText = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_AWARE_HELP")
    ),

    spectrum_aware_calibration_strat = list(
      name = "spectrum_aware_calibration_strat",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_STRATIFICATION_LABEL"),
      type = "select",
      required = TRUE,
      options = age_strat_opts,
      helpText = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_AWARE_HELP")
    ),

    spectrum_infections_calibration_level = list(
      name = "spectrum_infections_calibration_level",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_LEVEL_LABEL"),
      type = "select",
      required = TRUE,
      options = calibration_level_opts,
      helpText = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_INFECTIONS_HELP")
    ),

    spectrum_infections_calibration_strat = list(
      name = "spectrum_infections_calibration_strat",
      label = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_STRATIFICATION_LABEL"),
      type = "select",
      required = TRUE,
      options = age_strat_opts,
      helpText = t_("OPTIONS_CALIBRATION_ADJUST_TO_SPECTRUM_INFECTIONS_HELP")
    ),

    calibrate_method = list(
      name = "calibrate_method",
      type = "select",
      required = TRUE,
      options = list(
        list(
          id = "logistic",
          label = t_("OPTIONS_CALIBRATE_METHOD_LOGISTIC_LABEL")
        ),
        list(
          id = "proportional",
          label = t_("OPTIONS_CALIBRATE_METHOD_PROPORTIONAL_LABEL")
        )
      )
    )
  )
}

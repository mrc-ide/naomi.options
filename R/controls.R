get_model_controls <- function() {
  yes_no_options <- list(
    list(
      id = "true",
      label = t("OPTIONS_YES_LABEL")
    ),
    list(
      id = "false",
      label = t("OPTIONS_NO_LABEL")
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
          label = paste(t_("MONTH_JUN"), "2021")
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
    max_iterations = list(
      name = "max_iteration",
      type = "number",
      helpText = t_("OPTIONS_ADVANCED_MAX_ITERATIONS_HELP"),
      required = TRUE
    )
  )
}

get_calibration_controls <- function() {
  calibration_level_opts <- list(
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

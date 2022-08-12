get_model_controls <- function() {
  list(
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
    survey_prevalence = list(
      name = "survey_prevalence",
      type = "multiselect",
      required = TRUE
    ),
    survey_art_coverage = list(
      name = "survey_art_coverage",
      type = "multiselect",
      required = TRUE
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

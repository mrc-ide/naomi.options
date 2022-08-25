build_test_options <- function(iso3, type, additional_values) {
  if (type == "model") {
    controls <- get_model_controls()
  } else {
    controls <- get_calibration_controls()
  }
  default_values <- read_hardcoded_defaults(iso3, controls)
  options <- lapply(names(default_values), function(name) {
    val <- default_values[[name]]
    opts <- list()
    if (nzchar(val)) {
      opts <- c(opts, list(list(
        id = default_values[[name]],
        label = default_values[[name]]
      )))
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
  options
}

mwi_options <- list(
  area_level = list(
    list(
      id = "1",
      label = "1"
    ),
    list(
      id = "2",
      label = "2"
    ),
    list(
      id = "3",
      label = "3"
    ),
    list(
      id = "4",
      label = "4"
    ),
    list(
      id = "5",
      label = "5"
    )
  ),
  calendar_quarter_t1 = list(
    list(
      id = "CY2016Q1",
      label = "CY2016Q1"
    )
  ),
  survey_prevalence = list(
    list(
      id = "MWI2016PHIA",
      label = "MWI2016PHIA"
    ),
    list(
      id = "test",
      label = "test"
    )
  ),
  survey_art_coverage = list(
    list(
      id = "MWI2016PHIA",
      label = "MWI2016PHIA"
    ),
    list(
      id = "test",
      label = "test"
    )
  ),
  survey_recently_infected = list(
    list(
      id = "MWI2016PHIA",
      label = "MWI2016PHIA"
    ),
    list(
      id = "test",
      label = "test"
    )
  )
)

cmr_options <- list(
  area_level = list(
    list(
      id = "1",
      label = "1"
    ),
    list(
      id = "2",
      label = "2"
    ),
    list(
      id = "3",
      label = "3"
    )
  ),
  calendar_quarter_t1 = list(
    list(
      id = "CY2017Q3",
      label = "CY2017Q3"
    )
  ),
  survey_prevalence = list(
    list(
      id = "CMR2018DHS",
      label = "CMR2018DHS"
    ),
    list(
      id = "CMR2017PHIA",
      label = "CMR2017PHIA"
    )
  ),
  survey_art_coverage = list(
    list(
      id = "CMR2018DHS",
      label = "CMR2018DHS"
    ),
    list(
      id = "CMR2017PHIA",
      label = "CMR2017PHIA"
    )
  ),
  survey_recently_infected = list(
    list(
      id = "CMR2018DHS",
      label = "CMR2018DHS"
    ),
    list(
      id = "CMR2017PHIA",
      label = "CMR2017PHIA"
    )
  )
)

ago_options <- list(
  area_level = list(
    list(
      id = "1",
      label = "1"
    ),
    list(
      id = "2",
      label = "2"
    )
  ),
  calendar_quarter_t1 = list(
    list(
      id = "CY2015Q4",
      label = "CY2015Q4"
    )
  ),
  survey_prevalence = list(
    list(
      id = "AGO2015DHS",
      label = "AGO2015DHS"
    ),
    list(
      id = "test",
      label = "test"
    )
  ),
  survey_art_coverage = list(
    list(
      id = "AGO2015DHS",
      label = "AGO2015DHS"
    ),
    list(
      id = "test",
      label = "test"
    )
  ),
  survey_recently_infected = list(
    list(
      id = "AGO2015DHS",
      label = "AGO2015DHS"
    ),
    list(
      id = "test",
      label = "test"
    )
  )
)

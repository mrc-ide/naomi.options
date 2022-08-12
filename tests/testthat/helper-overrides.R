## Simplest overrides which we can use to get set of model options
## expect this will have to change as our default options csv changes
mwi_overrides <- list(
  area_level = list(
    options = list(
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
    )
  ),
  calendar_quarter_t1 = list(
    options = list(
      list(
        id = "CY2016Q1",
        label = "CY2016Q1"
      )
    )
  ),
  survey_prevalence = list(
    options = list(
      list(
        id = "MWI2016PHIA",
        label = "MWI2016PHIA"
      ),
      list(
        id = "test",
        label = "test"
      )
    ),
    value = "test"
  ),
  survey_art_coverage = list(
    options = list(
      list(
        id = "MWI2016PHIA",
        label = "MWI2016PHIA"
      ),
      list(
        id = "test",
        label = "test"
      )
    ),
    value = "test"
  ),
  survey_recently_infected = list(
    options = list(
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
)

cmr_overrides <- list(
  area_level = list(
    options = list(
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
    )
  ),
  calendar_quarter_t1 = list(
    options = list(
      list(
        id = "CY2017Q3",
        label = "CY2017Q3"
      )
    )
  ),
  survey_prevalence = list(
    options = list(
      list(
        id = "CMR2018DHS",
        label = "CMR2018DHS"
      ),
      list(
        id = "CMR2017PHIA",
        label = "CMR2017PHIA"
      )
    ),
    value = "CMR2017PHIA"
  ),
  survey_art_coverage = list(
    options = list(
      list(
        id = "CMR2018DHS",
        label = "CMR2018DHS"
      ),
      list(
        id = "CMR2017PHIA",
        label = "CMR2017PHIA"
      )
    ),
    value = "CMR2017PHIA"
  ),
  survey_recently_infected = list(
    options = list(
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
)

ago_overrides <- list(
  area_level = list(
    options = list(
      list(
        id = "1",
        label = "1"
      ),
      list(
        id = "2",
        label = "2"
      )
    )
  ),
  calendar_quarter_t1 = list(
    options = list(
      list(
        id = "CY2015Q4",
        label = "CY2015Q4"
      )
    )
  ),
  survey_prevalence = list(
    options = list(
      list(
        id = "AGO2015DHS",
        label = "AGO2015DHS"
      ),
      list(
        id = "test",
        label = "test"
      )
    ),
    value = "AGO2015DHS"
  ),
  survey_art_coverage = list(
    options = list(
      list(
        id = "AGO2015DHS",
        label = "AGO2015DHS"
      ),
      list(
        id = "test",
        label = "test"
      )
    ),
    value = "AGO2015DHS"
  ),
  survey_recently_infected = list(
    options = list(
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
)

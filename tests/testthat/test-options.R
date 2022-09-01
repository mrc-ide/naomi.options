test_that("can get calibration options JSON", {
  json <- get_controls_json("calibration", "MWI", list(), list())
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  expect_length(out, 1)
  expect_equal(out$controlSections[[1]]$label, "Calibration options")
  expect_equal(out$controlSections[[1]]$controlGroups[[1]]$label,
               "Adjust to Spectrum PLHIV")
})

test_that("get_controls_json returns useful error if type unknown", {
  expect_error(get_controls_json("test", "MWI", list(), list()),
               "Failed to get options for type 'test'")
})

test_that("get_controls_json returns useful error if country unknown", {
  expect_error(get_controls_json("calibration", "123", list(), list()),
               "Failed to get default options for iso3 '123'")
})

test_that("get_controls_json returns useful error when options are missing", {
  expect_error(get_controls_json("model", "MWI", list(), list()),
               paste0("Failed to find any valid options for control ",
                      "'area_scope' speak to a system administrator"))
})

test_that("can get model options JSON", {
  mwi_values <- list(
    area_scope = "test"
  )
  mwi_options <- build_test_options("MWI", "model", mwi_values)
  json <- get_controls_json("model", "MWI", mwi_options, mwi_values)
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## template text is translated
  expect_equal(out$controlSections[[1]]$label, "General")

  ## options come from input
  control <- get_control(out, "area_scope")
  expect_equal(control$options, mwi_options[[control$name]])

  ## value comes from csv (not from fallbacks)
  expect_equal(control$name, "area_scope")
  expect_true(!is.null(mwi_values[["area_scope"]]))
  expect_true(control$value != mwi_values[["area_scope"]])
})

test_that("empty default value is returned even when fallback provided", {
  ago_values <- list(
    survey_prevalence = "AGO2015DHS",
    survey_art_coverage = "AGO2015DHS"
  )
  ago_options <- build_test_options("AGO", "model", ago_values)
  json <- get_controls_json("model", "AGO", ago_options, ago_values)
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  control <- get_control(out, "survey_art_coverage")
  expect_equal(control$value, "")
})

test_that("fallback values used if defaults are invalid", {
  mwi_values <- list(
    area_level = "1",
    survey_prevalence = "test"
  )
  options <- build_test_options("MWI", "model", mwi_values)
  options$area_level <- list(
    list(
      id = "1",
      label = "1"
    )
  )
  options$survey_prevalence <- list(
    list(
      id = "test",
      label = "test"
    )
  )

  json <- get_controls_json("model", "MWI", options, mwi_values)
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## select value comes from fallback
  area_level <- get_control(out, "area_level")
  expect_equal(area_level$value, "1")

  ## multiselect value comes from fallback
  survey_prevalence <- get_control(out, "survey_prevalence")
  expect_equal(survey_prevalence$value, "test")
})

test_that("hardcoded fallback used if defaults and data fallback are invalid", {
  xxx_values <- list(
    adjust_area_growth = "invalid",
    use_survey_aggregate = "invalid"
  )
  options <- build_test_options("XXX", "model", xxx_values)
  yes_no <- list(
    list(
      id = "true",
      label = "yes"
    ),
    list(
      id = "false",
      label = "no"
    )
  )
  options$adjust_area_growth <- yes_no
  options$use_survey_aggregate <- yes_no

  ## No example of multiselect where a default value is set in the controls
  ## so mock it
  controls <- get_model_controls()
  controls$use_survey_aggregate$type <- "multiselect"
  mock_get_model_controls <- mockery::mock(controls)

  with_mock(
    "naomi.options:::get_model_controls" = mock_get_model_controls, {
      json <- get_controls_json("model", "XXX", options, xxx_values)
  })
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## select value comes from fallback
  adjust_area_growth <- get_control(out, "adjust_area_growth")
  expect_equal(adjust_area_growth$value, "false")

  ## multiselect value comes from fallback
  use_survey_aggregate <- get_control(out, "use_survey_aggregate")
  expect_equal(use_survey_aggregate$value, "false")
})

test_that("fallback to no value if defaults and fallback values are invalid", {
  mwi_values <- list(
    area_level = "test",
    survey_prevalence = "test"
  )
  options <- build_test_options("MWI", "model", mwi_values)
  options$area_level <- list(
    list(
      id = "invalid",
      label = "invalid"
    )
  )
  options$survey_prevalence <- list(
    list(
      id = "invalid",
      label = "invalid"
    )
  )

  json <- get_controls_json("model", "MWI", options, mwi_values)
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## select value not in JSON
  area_level <- get_control(out, "area_level")
  expect_true(!("value" %in% names(area_level)))

  ## multiselect value not in JSON
  survey_prevalence <- get_control(out, "survey_prevalence")
  expect_true(!("value" %in% names(survey_prevalence)))
})

test_that("options JSON can get multiselect default", {
  xxx_options <- build_test_options("XXX", "model", NULL)
  json <- get_controls_json("model", "XXX", xxx_options, list())
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## multiselect value from csv
  survey_prevalence <- get_control(out, "survey_prevalence")
  expect_length(survey_prevalence$value, 2)
})

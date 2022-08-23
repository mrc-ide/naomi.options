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
                      "'area_level' speak to a system administrator"))
})

test_that("can get model options JSON", {
  mwi_values <- list(
    survey_prevalence = "test",
    survey_art_coverage = "test"
  )
  json <- get_controls_json("model", "MWI", mwi_options, mwi_values)
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## template text is translated
  expect_equal(out$controlSections[[1]]$label, "Survey")

  ## options come from input
  control_1 <- out$controlSections[[1]]$controlGroups[[1]]$controls[[1]]
  expect_equal(control_1$options, mwi_options[[control_1$name]])

  ## value comes from csv (not from fallbacks)
  control_3 <- out$controlSections[[1]]$controlGroups[[3]]$controls[[1]]
  expect_equal(control_3$name, "survey_prevalence")
  expect_true(!is.null(mwi_values[["survey_prevalence"]]))
  expect_true(control_3$value != mwi_values[["survey_prevalence"]])
})

test_that("empty default value is returned in JSON", {
  ago_values <- list(
    survey_prevalence = "AGO2015DHS",
    survey_art_coverage = "AGO2015DHS"
  )
  json <- get_controls_json("model", "AGO", ago_options, ago_values)
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  control_4 <- out$controlSections[[1]]$controlGroups[[4]]$controls[[1]]
  expect_equal(control_4$name, "survey_art_coverage")
  expect_equal(control_4$value, "")
})

test_that("fallback values used if defaults are invalid", {
  options <- mwi_options
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

  values <- list(
    area_level = "1",
    survey_prevalence = "test",
    number_type = 10
  )

  controls <- get_model_controls()
  controls$number_type <- list(
    name = "number_type",
    type = "number",
    helpText = "help123",
    required = TRUE
  )

  mock_get_model_controls <- mockery::mock(controls)
  mock_build_json <- mockery::mock(TRUE)

  with_mock(
    "naomi.options:::build_json" = mock_build_json,
    "naomi.options:::get_model_controls" = mock_get_model_controls, {
      json <- get_controls_json("model", "MWI", options, values)
    })

  mockery::expect_called(mock_build_json, 1)
  mockery::expect_called(mock_get_model_controls, 1)
  out <- mockery::mock_args(mock_build_json)[[1]][[2]]

  ## select value comes from fallback
  expect_equal(out$area_level$value, scalar("1"))

  ## multiselect value comes from fallback
  expect_equal(out$survey_prevalence$value, scalar("test"))

  ## number value comes from fallback
  expect_equal(out$number_type$value, scalar(10))
})

test_that("fallback to no value if defaults and fallback values are invalid", {
  options <- mwi_options
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

  values <- list(
    area_level = "test",
    survey_prevalence = "test"
  )

  controls <- get_model_controls()
  controls$number_type <- list(
    name = "number_type",
    type = "number",
    helpText = "help123",
    required = TRUE
  )

  mock_get_model_controls <- mockery::mock(controls)
  mock_build_json <- mockery::mock(TRUE)

  with_mock(
    "naomi.options:::build_json" = mock_build_json,
    "naomi.options:::get_model_controls" = mock_get_model_controls, {
      json <- get_controls_json("model", "MWI", options, values)
    })

  mockery::expect_called(mock_build_json, 1)
  mockery::expect_called(mock_get_model_controls, 1)
  out <- mockery::mock_args(mock_build_json)[[1]][[2]]

  ## select value not in JSON
  expect_true(!("value" %in% names(out$area_level)))

  ## multiselect value not in JSON
  expect_true(!("value" %in% names(out$survey_prevalence)))

  ## number value not in JSON
  expect_true(!("value" %in% names(out$number_type)))
})

test_that("options JSON can get multiselect default", {
  json <- get_controls_json("model", "CMR", cmr_options, list())
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## multiselect value from csv
  control_3 <- out$controlSections[[1]]$controlGroups[[3]]$controls[[1]]
  expect_equal(control_3$name, "survey_prevalence")
  expect_length(control_3$value, 2)
})

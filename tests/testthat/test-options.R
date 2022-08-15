test_that("can get calibration options JSON", {
  json <- get_controls_json("calibration", "MWI", list())
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  expect_length(out, 1)
  expect_equal(out$controlSections[[1]]$label, "Calibration options")
  expect_equal(out$controlSections[[1]]$controlGroups[[1]]$label,
               "Adjust to Spectrum PLHIV")
})

test_that("get_controls_json returns useful error if type unknown", {
  expect_error(get_controls_json("test", "MWI", list()),
               "Failed to get options for type 'test'")
})

test_that("get_controls_json returns useful error if country unknown", {
  expect_error(get_controls_json("calibration", "123", list()),
               "Failed to get default options for iso3 '123'")
})

test_that("get_controls_json returns useful error when options are missing", {
  expect_error(get_controls_json("model", "MWI", list()),
               paste0("Failed to find any valid options for control ",
                      "'area_level' speak to a system administrator"))
})

test_that("can get model options JSON", {
  json <- get_controls_json("model", "MWI", mwi_overrides)
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## template text is translated
  expect_equal(out$controlSections[[1]]$label, "Survey")

  ## options come from overrides
  control_1 <- out$controlSections[[1]]$controlGroups[[1]]$controls[[1]]
  expect_equal(control_1$options, mwi_overrides[[control_1$name]]$options)

  ## value comes from csv (not from overrides)
  control_3 <- out$controlSections[[1]]$controlGroups[[3]]$controls[[1]]
  expect_equal(control_3$name, "survey_prevalence")
  expect_true(!is.null(mwi_overrides[["survey_prevalence"]]$value))
  expect_true(control_3$value != mwi_overrides[["survey_prevalence"]]$value)
})

test_that("empty default value is returned in JSON", {
  json <- get_controls_json("model", "AGO", ago_overrides)
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  control_4 <- out$controlSections[[1]]$controlGroups[[4]]$controls[[1]]
  expect_equal(control_4$name, "survey_art_coverage")
  expect_equal(control_4$value, "")
})

test_that("fallback to overrides if defaults are invalid", {
  overrides <- mwi_overrides
  overrides$area_level <- list(
    options = list(
      list(
        id = "1",
        label = "1"
      )
    ),
    value = "1"
  )
  overrides$survey_prevalence <- list(
    options = list(
      list(
        id = "test",
        label = "test"
      )
    ),
    value = "test"
  )
  json <- get_controls_json("model", "MWI", overrides)
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## select value comes from overrides
  control_1 <- out$controlSections[[1]]$controlGroups[[1]]$controls[[1]]
  expect_equal(control_1$value, "1")

  ## multiselect value comes from overrides
  control_3 <- out$controlSections[[1]]$controlGroups[[3]]$controls[[1]]
  expect_equal(control_3$name, "survey_prevalence")
  expect_equal(control_3$value, "test")
})

test_that("fallback to no value if overrides and defaults are invalid", {
  overrides <- mwi_overrides
  overrides$area_level <- list(
    options = list(
      list(
        id = "invalid",
        label = "invalid"
      )
    ),
    value = "test"
  )
  overrides$survey_prevalence <- list(
    options = list(
      list(
        id = "invalid",
        label = "invalid"
      )
    ),
    value = "test"
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
    "build_json" = mock_build_json,
    "get_model_controls" = mock_get_model_controls, {
      json <- get_controls_json("model", "MWI", overrides)
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

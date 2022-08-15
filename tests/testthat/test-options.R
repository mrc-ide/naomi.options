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

test_that("read_hardcoded_defaults sets types from controls", {
  controls <- get_model_controls(TRUE, TRUE)
  defaults <- read_hardcoded_defaults("CMR", controls)

  expect_type(defaults, "list")
  expect_type(defaults$area_level, "character")
  expect_type(defaults$calendar_quarter_t1, "character")
  expect_type(defaults$survey_prevalence, "character")
  expect_type(defaults$survey_art_coverage, "character")
  expect_type(defaults$max_iterations, "double")
  expect_equal(defaults$survey_prevalence, c("CMR2018DHS", "CMR2017PHIA"))
})

test_that("read_hardcoded_defaults filters defaults to set of controls", {
  controls <- get_calibration_controls()
  defaults <- read_hardcoded_defaults("MWI", controls)

  expect_type(defaults, "list")
  expect_setequal(names(defaults), c(
    "spectrum_plhiv_calibration_level", "spectrum_plhiv_calibration_strat",
    "spectrum_artnum_calibration_level", "spectrum_artnum_calibration_strat",
    "spectrum_aware_calibration_level", "spectrum_aware_calibration_strat",
    "spectrum_infections_calibration_level",
    "spectrum_infections_calibration_strat", "calibrate_method"))
  expect_type(defaults$spectrum_plhiv_calibration_level, "character")
})

test_that("read_hardcoded_defaults sets NA columns to empty string", {
  controls <- get_model_controls(TRUE, TRUE)
  defaults <- read_hardcoded_defaults("AGO", controls)

  expect_equal(defaults$survey_art_coverage, "")
})

test_that("as_select converts as expected", {
  expect_equal(as_select(2), "2")
  expect_equal(as_select(NA), "")
  expect_equal(as_select("test"), "test")
  expect_equal(as_select(""), "")
})

test_that("as_multiselect works as expected", {
  expect_equal(as_multiselect(2), "2")
  expect_equal(as_multiselect(NA), "")
  expect_equal(as_multiselect("test"), "test")
  expect_equal(as_multiselect(""), "")
  expect_equal(as_multiselect("test;test2"), c("test", "test2"))
  expect_equal(as_multiselect("test; test2"), c("test", "test2"))
  expect_equal(as_multiselect("test;     test2"), c("test", "test2"))
})

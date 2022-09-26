test_that("can get model calibration options label from ID", {
  options <- list(spectrum_population_calibration_level = "subnational",
                  spectrum_plhiv_calibration_strat = "sex_age_group",
                  spectrum_artnum_calibration_level = "none",
                  spectrum_artnum_calibration_strat = "age_coarse",
                  spectrum_aware_calibration_level = "none",
                  spectrum_aware_calibration_strat = "age_coarse",
                  spectrum_infections_calibration_level = "none",
                  spectrum_infections_calibration_strat = "age_coarse",
                  calibrate_method = "logistic")
  options_map <- get_calibration_option_labels(options)

  expect_length(options_map, length(options))
  expect_equal(options_map, list(
    spectrum_population_calibration_level = "Subnational",
    spectrum_plhiv_calibration_strat = "Sex and 5-year age group",
    spectrum_artnum_calibration_level = "None",
    spectrum_artnum_calibration_strat = "Age <15 / 15+",
    spectrum_aware_calibration_level = "None",
    spectrum_aware_calibration_strat = "Age <15 / 15+",
    spectrum_infections_calibration_level = "None",
    spectrum_infections_calibration_strat = "Age <15 / 15+",
    calibrate_method = "Logistic"))
})

test_that("get_calibration_option_labels throws error if cannot be mapped", {
  expect_error(
    get_calibration_option_labels(list(test = "value")),
    "Failed to find calibration option label with name 'test' and id 'value'.")
})

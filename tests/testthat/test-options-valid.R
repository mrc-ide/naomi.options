test_that("default options produce valid JSON", {
  validator <- jsonvalidate::json_validator(
    system_file("schema", "ModelRunOptions.schema.json"))
  countries <- read.csv(system_file("default_options.csv"))$iso3
  types <- c("model", "calibration")
  for (country in countries) {
    for (type in types) {
      options <- build_test_options(country, type, NULL)
      model_options <- get_controls_json(type, country, options, NULL)
      expect_valid(validator(model_options, error = TRUE))
    }
  }
})

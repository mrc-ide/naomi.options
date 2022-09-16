test_that("default options produce valid JSON", {
  validator <- jsonvalidate::json_validator(
    system_file("schema", "ModelRunOptions.schema.json"))
  countries <- read.csv(system_file("default_options.csv"))$iso3
  types <- c("model", "calibration")
  for (country in countries) {
    for (type in types) {
      withCallingHandlers({
        options <- build_test_options(country, type, NULL)
        model_options <- get_controls_json(
          type, country, options, NULL,
          list(include_art = TRUE, include_anc = TRUE))
        expect_true(validator(model_options, error = TRUE))
      },
      error = function(e) {
        e$message <- sprintf(
          "Failed to validate '%s' options for country '%s'\n  %s",
          type, country, e$message)
        stop(e)
      })
    }
  }
})

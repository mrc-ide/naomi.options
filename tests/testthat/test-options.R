test_that("can get calibration options JSON", {
  json <- get_controls_json("calibration", "MWI", list(), list(),
                            list(include_art = TRUE, include_anc = TRUE))
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

test_that("get_controls_json returns useful error when options are missing", {
  expect_error(get_controls_json("model", "MWI", list(), list()),
               paste0("Failed to find any valid options for control ",
                      "'area_scope' speak to a system administrator"))
})

describe("can get model options JSON", {
  mwi_values <- list(
    area_scope = "test"
  )
  mwi_options <- build_test_options("MWI", "model", mwi_values)
  json <- get_controls_json("model", "MWI", mwi_options, mwi_values,
                            list(include_art = TRUE, include_anc = TRUE))
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)
  control <- get_control(out, "area_scope")

  it("translates template text", {
    expect_equal(out$controlSections[[1]]$label, "General")
  })

  it("includes options from input param", {
    expect_equal(control$options, mwi_options[[control$name]])
  })

  it("uses values from overrides not csv", {
    csv_values <- read_hardcoded_defaults("MWI", list(area_scope = list()))
    expect_equal(control$name, "area_scope")
    expect_equal(control$value, mwi_values[["area_scope"]])
    expect_true(control$value != csv_values[[1]])
  })

  it("includes ANC options", {
    expect_true(!is.null(get_control(out, "anc_prevalence_year1")))
  })

  it("includes ART options", {
    expect_true(!is.null(get_control(out, "include_art_t1")))
  })
})

test_that("empty default value is returned only when no override provided", {
  ago_values <- list(
    survey_prevalence = "AGO2015DHS"
  )
  ago_options <- build_test_options("AGO", "model", ago_values)
  json <- get_controls_json("model", "AGO", ago_options, ago_values,
                            list(include_art = TRUE, include_anc = TRUE))
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  control <- get_control(out, "survey_art_coverage")
  expect_equal(control$value, "")
})

test_that("default values used if overrides are invalid", {
  mwi_values <- list(
    area_level = "invalid",
    survey_prevalence = "invalid"
  )
  options <- build_test_options("MWI", "model", mwi_values)
  options$area_level <- options$area_level[1]
  options$survey_prevalence <- options$survey_prevalence[1]

  json <- get_controls_json("model", "MWI", options, mwi_values,
                            list(include_art = TRUE, include_anc = TRUE))
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## select value comes from defaults
  area_level <- get_control(out, "area_level")
  expect_true(area_level$value != "invalid")

  ## multiselect value comes from defaults
  survey_prevalence <- get_control(out, "survey_prevalence")
  expect_true(survey_prevalence$value != "invalid")
})

test_that("fallback to no value if defaults and override values are invalid", {
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

  json <- get_controls_json("model", "MWI", options, mwi_values,
                            list(include_art = TRUE, include_anc = TRUE))
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
  json <- get_controls_json("model", "XXX", xxx_options, list(),
                            list(include_art = TRUE, include_anc = TRUE))
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  ## multiselect value from csv
  survey_prevalence <- get_control(out, "survey_prevalence")
  expect_length(survey_prevalence$value, 2)
})

describe("model options can exclude ANC and ART options", {
  mwi_values <- list(
    area_scope = "test"
  )
  mwi_options <- build_test_options("MWI", "model", mwi_values)
  json <- get_controls_json("model", "MWI", mwi_options, mwi_values,
                            list(include_art = FALSE, include_anc = FALSE))
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  it("excludes ANC options", {
    expect_error(get_control(out, "anc_prevalence_year1"),
                 "Failed to find control with name anc_prevalence_year1")
  })

  it("excludes ART options", {
    expect_error(get_control(out, "include_art_t1"),
                 "Failed to find control with name include_art_t1")
  })
})

describe("model options can include ANC and exclude ART options", {
  mwi_values <- list(
    area_scope = "test"
  )
  mwi_options <- build_test_options("MWI", "model", mwi_values)
  json <- get_controls_json("model", "MWI", mwi_options, mwi_values,
                            list(include_art = FALSE, include_anc = TRUE))
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  it("includes ANC options", {
    expect_true(!is.null(get_control(out, "anc_prevalence_year1")))
  })

  it("excludes ART options", {
    expect_error(get_control(out, "include_art_t1"),
                 "Failed to find control with name include_art_t1")
  })
})

describe("model options can exclude ANC and include ART options", {
  mwi_values <- list(
    area_scope = "test"
  )
  mwi_options <- build_test_options("MWI", "model", mwi_values)
  json <- get_controls_json("model", "MWI", mwi_options, mwi_values,
                            list(include_art = TRUE, include_anc = FALSE))
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  it("excludes ANC options", {
    expect_error(get_control(out, "anc_prevalence_year1"),
                 "Failed to find control with name anc_prevalence_year1")
  })

  it("includes ART options", {
    expect_true(!is.null(get_control(out, "include_art_t1")))
  })
})


describe("when getting controls for unknown country", {
  data_values <- list(
    area_scope = "SSD"
  )
  options <- build_test_options("MWI", "model", data_values)
  json <- get_controls_json("model", "UNK", options, data_values)
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  it("returns data", {
    expect_true(length(out) > 0)
  })

  it("has override defaults for non country specific options", {
    calendar_quarter_t2 <- get_control(out, "calendar_quarter_t2")
    expect_equal(calendar_quarter_t2$value, "CY2023Q4")
  })

  it("has no value for country specific options", {
    area_scope <- get_control(out, "area_scope")
    expect_equal(area_scope$value, "SSD")
  })
})

test_that("setting select values works", {
  control <- list(
    name = "name",
    type = "select",
    required = TRUE,
    options = list(
      list(
        id = "op1",
        label = "op1"
      ),
      list(
        id = "op2",
        label = "op2"
      )
    )
  )
  expect_equal(
    set_select_value(control, "op1", ""),
    "")
  expect_equal(
    set_select_value(control, NA, "op1"),
    "op1")
  expect_equal(
    set_select_value(control, NA, "other"),
    NULL)
  expect_equal(
    set_select_value(control, NULL, "op1"),
    "op1")
  expect_equal(
    set_select_value(control, "op1", "op2"),
    "op2")
  expect_null(
    set_select_value(control, "another", "123"))
  expect_equal(
    set_select_value(control, NA, c("op1", "op2")),
    "op1")
})

test_that("setting multiselect values works", {
  control <- list(
    name = "name",
    type = "multiselect",
    required = TRUE,
    options = list(
      list(
        id = "op1",
        label = "op1"
      ),
      list(
        id = "op2",
        label = "op2"
      )
    )
  )
  expect_equal(
    set_multiselect_value(control, "op1", ""),
    "")
  expect_equal(
    set_multiselect_value(control, NA, "op1"),
    "op1")
  expect_equal(
    set_multiselect_value(control, NA, "other"),
    NULL)
  expect_equal(
    set_multiselect_value(control, NULL, "op1"),
    "op1")
  expect_equal(
    set_multiselect_value(control, NULL, "other"),
    NULL)
  expect_equal(
    set_multiselect_value(control, NULL, c("op1", "op2")),
    c("op1", "op2"))
  expect_equal(
    set_multiselect_value(control, "op1", "op2"),
    "op2")
  expect_equal(
    set_multiselect_value(control, "op1", c("op1", "op2")),
    c("op1", "op2"))
  expect_null(
    set_multiselect_value(control, "another", "123"))
})

test_that("setting number values works", {
  control <- list(
    name = "name",
    type = "number",
    required = TRUE
  )
  expect_equal(
    set_number_value(control, 1, NA),
    1)
  expect_equal(
    set_number_value(control, NA, c(1, 2)),
    1)
  expect_equal(
    set_number_value(control, 1, 2),
    2)
  expect_null(
    set_number_value(control, NA, NA))
})

test_that("get_controls_json can include additional options for model", {
  mwi_values <- list(
    area_scope = "test"
  )
  mwi_options <- build_test_options("MWI", "model", mwi_values)
  mock_model_control_group <- list(
    list(
      label = "Trigger mock model error",
      controls = list(
        list(
          name = "mock_model_trigger_error",
          type = "select",
          help_text = "Set TRUE to force the model fit to error",
          required = TRUE,
          options = list(list(id = "true", label = "Yes"),
                         list(id = "false", label = "No")),
          value = "false"
        )
      )
    ),
    list(
      label = "Additional number control",
      controls = list(
        list(
          name = "number_control_1",
          type = "number",
          help_text = "Number control help",
          required = FALSE,
          value = 2
        )
      )
    )
  )
  json <- get_controls_json(
    "model", "MWI", mwi_options, mwi_values,
    list(include_art = TRUE, include_anc = TRUE,
         additional_control_groups = mock_model_control_group))
  out <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  control <- get_control(out, "mock_model_trigger_error")
  expect_equal(control, list(
    name = "mock_model_trigger_error",
    type = "select",
    required = TRUE,
    helpText = "Set TRUE to force the model fit to error",
    options = list(list(id = "true", label = "Yes"),
                   list(id = "false", label = "No")),
    value = "false"
  ))

  control <- get_control(out, "number_control_1")
  expect_equal(control, list(
    name = "number_control_1",
    type = "number",
    required = FALSE,
    helpText = "Number control help",
    value = 2
  ))
})

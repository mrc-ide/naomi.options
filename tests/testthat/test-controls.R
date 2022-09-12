test_that("control must be well formed", {
  expect_equal(control("name", "type", TRUE),
               list(name = "name",
                    type = "type",
                    required = TRUE))
  expect_error(control(1, "type", TRUE),
               "'name' must be character")
  expect_error(control("name", 1, TRUE),
               "'type' must be character")
  expect_error(control("name", "type", 1),
               "'required' must be logical")
  expect_error(
    control("name", "type", TRUE, pies = "tasty"),
    "unused argument (pies = \"tasty\")", fixed = TRUE)
  expect_error(control("name", "type", TRUE, options = "test"),
               "'options' must be a list of lists")
  expect_error(control("name", "type", TRUE, options = list(list(x = "y"))),
               paste0("'options' has option with properties 'x', must be",
                      " 'id' and 'label' only"))
  expect_error(control("name", "type", TRUE, options = list(list(x = "y")),
                       min = 2, max = 4),
               paste0("Control can specify either 'options' or 'min' and ",
                      "'max' not both"))
  expect_error(control("name", "type", TRUE, min = TRUE),
               "'min' must be numeric")
  expect_error(control("name", "type", TRUE, max = TRUE),
               "'max' must be numeric")
  expect_equal(control("name", "type", TRUE,
                       label = "label",
                       help_text = "help text",
                       options = list(
                         list(id = "1", label = "one"),
                         list(id = "2", label = "two")
                       )),
               list(name = "name",
                    type = "type",
                    required = TRUE,
                    label = "label",
                    helpText = "help text",
                    options = list(
                      list(id = "1", label = "one"),
                      list(id = "2", label = "two")
                    )))
  expect_equal(control("name", "type", TRUE,
                       label = "label",
                       help_text = "help text",
                       min = 1,
                       max = 10),
               list(name = "name",
                    type = "type",
                    required = TRUE,
                    label = "label",
                    helpText = "help text",
                    min = 1,
                    max = 10))
})

test_that("can recursively convert to scalar", {
  expect_equal(recursive_scalar(2), list(scalar(2)))
  expect_equal(recursive_scalar(c(1, 2)), list(scalar(1), scalar(2)))
  expect_equal(recursive_scalar(list(x = "foo",
                                     y = "bar")),
               list(x = scalar("foo"),
                    y = scalar("bar")))
  expect_equal(recursive_scalar(list(x = "foo",
                                     y = list(y1 = "bar1", y2 = "bar2"))),
               list(x = scalar("foo"),
                    y = list(y1 = scalar("bar1"), y2 = scalar("bar2"))))
  expect_null(recursive_scalar(NULL))
  expect_equal(recursive_scalar(list(x = "foo", y = NULL)),
               list(x = scalar("foo"), y = NULL))
  expect_equal(recursive_scalar(list(x = 1)),
               list(x = scalar(1)))
})

test_that("can check valid numeric", {
  expect_true(valid_numeric(2))
  expect_true(valid_numeric(3.14))
  expect_true(valid_numeric("2"))
  expect_true(valid_numeric("3.14"))
  expect_false(valid_numeric(""))
  expect_false(valid_numeric("two"))
  expect_false(valid_numeric(NULL))
})

test_that("can build JSON from template", {
  json <- build_json("test \"<+param1+>\"",
                     list(param1 = scalar("test string")))
  expect_equal(json, 'test "test string"')

  json <- build_json("\"<+param1+>\" test, \"<+param_2+>\"",
                     list(param1 = scalar("x"), param_2 = scalar("y")))
  expect_equal(json, '"x" test, "y"')

  json <- build_json('{"options": \"<+options+>\", "test": \"<+test+>\"}',
                     list(options = c(scalar("MWI"),
                                      scalar("MWI_1_1"),
                                      scalar("MWI_1_2")),
                          test = scalar("test_value")))
  expect_equal(json,
               '{"options": ["MWI","MWI_1_1","MWI_1_2"], "test": "test_value"}')

  json <- build_json(paste0('{"options": \"<+options+>\", "test": ",
                            "\"<+test+>\", "text": "Age < 5"}'),
                     list(options = list(
                       list(id = scalar("MWI"),
                            label = scalar("Malawi")),
                       list(id = scalar("MWI_1_1"),
                            label = scalar("Northern")),
                       list(id = scalar("MWI_1_2"),
                            label = scalar("Central"))),
                       test = scalar("test_value")))
  expect_equal(json,
               paste0('{"options": [{"id":"MWI","label":"Malawi"},',
                      '{"id":"MWI_1_1","label":"Northern"},',
                      '{"id":"MWI_1_2","label":"Central"}],',
                      'test": "test_value", "text": "Age < 5"}'))

  ## Additional params are ignored
  json <- build_json("test \"<+param+>\"",
                     list(param = scalar("test"), param2 = scalar("test2")))
  expect_equal(json, 'test "test"')

  ## Null params
  json <- build_json('{"options": \"<+param+>\"}', list(param = scalar(NULL)))
  expect_equal(json, '{"options": {}}')
})

test_that("JSON build fails if params are missing", {
  expect_error(build_json('{"options": \"<+param+>\"}', list(value = "test")),
               "Failed to construct model options from template and params:
object 'param' not found")
})

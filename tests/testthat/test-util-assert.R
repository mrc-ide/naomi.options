test_that("assert_scalar", {
  expect_error(assert_scalar(NULL), "must be a scalar")
  expect_error(assert_scalar(numeric(0)), "must be a scalar")
  expect_error(assert_scalar(1:2), "must be a scalar")
})

test_that("assert_character", {
  expect_silent(assert_character("a"))
  expect_error(assert_character(1), "must be character")
  expect_error(assert_character(TRUE), "must be character")
})

test_that("assert_numeric", {
  expect_silent(assert_numeric(1))
  expect_error(assert_numeric("one"), "must be numeric")
  expect_error(assert_numeric(TRUE), "must be numeric")
})

test_that("assert_logical", {
  expect_silent(assert_logical(TRUE))
  expect_error(assert_logical(1), "must be logical")
  expect_error(assert_logical("true"), "must be logical")
})

test_that("assert_scalar_character", {
  expect_silent(assert_scalar_character("test"))
  expect_error(assert_scalar_character(character(0)),
               "must be a scalar")
  expect_error(assert_scalar_character(c("one", "two")),
               "must be a scalar")
  expect_error(assert_scalar_character(1),
               "must be character")
})

test_that("assert_scalar_numeric", {
  expect_silent(assert_scalar_numeric(1))
  expect_error(assert_scalar_numeric(numeric(0)),
               "must be a scalar")
  expect_error(assert_scalar_numeric(c(1, 2)),
               "must be a scalar")
  expect_error(assert_scalar_numeric("one"),
               "must be numeric")
})

test_that("assert_scalar_logical", {
  expect_silent(assert_scalar_logical(TRUE))
  expect_error(assert_scalar_logical(logical(0)),
               "must be a scalar")
  expect_error(assert_scalar_logical(c(TRUE, FALSE)),
               "must be a scalar")
  expect_error(assert_scalar_logical("one"),
               "must be logical")
})

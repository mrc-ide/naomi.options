system_file <- function(...) {
  tryCatch({
    system.file(..., mustWork = TRUE, package = "naomi.options")
  }, error = function(e) {
    stop(sprintf("Failed to locate file from args\n%s",
                 paste(list(...), collapse = " ")))
  })
}

scalar <- function(val) {
  if (inherits(val, "scalar")) {
    val
  } else {
    jsonlite::unbox(val)
  }
}

recursive_scalar <- function(x) {
  if (is.null(x)) {
    return(NULL)
  }
  lapply(x, function(item) {
    if (length(item) > 1 || is.list(item)) {
      out <- recursive_scalar(item)
    } else {
      out <- scalar(item)
    }
    out
  })
}

#' Build JSON from template and a set of params
#'
#' @param options_template Template JSON of model run options
#' @param params List of named key value pairs for substituting from template.
#'
#' @return JSON built from template and params.
#' @keywords internal
#'
build_json <- function(options_template, params) {
  param_env <- list2env(params, parent = .GlobalEnv)
  tryCatch(
    glue::glue(options_template, .envir = param_env, .open = '"<+',
               .close = '+>"', .transformer = json_transformer),
    error = function(e) {
      e$message <- t_("MODEL_OPTIONS_FAIL", list(message = e$message))
      stop(e)
    }
  )
}

json_transformer <- function(text, envir) {
  res <- get(text, envir = envir, inherits = FALSE)
  to_json(res)
}

to_json <- function(x) {
  jsonlite::toJSON(x, json_verbatim = TRUE, na = "null")
}

vlapply <- function(X, FUN) {
  vapply(X, FUN, logical(1))
}

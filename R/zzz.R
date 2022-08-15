##' @importFrom traduire t_
.onLoad <- function(...) {
  init_traduire() # nocov
}

init_traduire <- function() {
  root <- system.file("traduire", package = "naomi.options", mustWork = TRUE)
  pattern <- sprintf("%s/{language}-{namespace}.json", root)
  languages <- c("en")
  namespaces <- "translation"
  traduire::translator_register(resources = NULL,
                                language = languages[[1]],
                                default_namespace = namespaces[[1]],
                                resource_pattern = pattern,
                                namespaces = namespaces,
                                fallback = "en",
                                languages = languages)
}

translator_unregister <- function() {
  traduire::translator_unregister()
}

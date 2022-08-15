% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{build_json}
\alias{build_json}
\title{Build JSON from template and a set of params}
\usage{
build_json(options_template, params)
}
\arguments{
\item{options_template}{Template JSON of model run options}

\item{params}{List of named key value pairs for substituting from template.}
}
\value{
JSON built from template and params.
}
\description{
This wraps params in quotes and collapses any arrays into a single comma
separated list. Therefore only substitutes in string types for the time
being.
}
\keyword{internal}
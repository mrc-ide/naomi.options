# naomi.options

<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R build status](https://github.com/mrc-ide/naomi.options/workflows/R-CMD-check/badge.svg)](https://github.com/mrc-ide/naomi.options/actions)
[![codecov.io](https://codecov.io/github/mrc-ide/naomi.options/coverage.svg?branch=main)](https://codecov.io/github/mrc-ide/naomi.options?branch=main)
<!-- badges: end -->

## Installation

To install `naomi.options`:

```r
remotes::install_github("mrc-ide/naomi.options", upgrade = FALSE)
```

## Terms

* control - the set of metadata describing one drop down or numeric entry in the options form, this includes info about the name, label, whether it is a required control, the options for the control, a default value etc. There are 3 types of controls, select (for a drop down with 1 value), multiselect (a dropdown with multiple values), numeric for a number
* options - the individual options for select and multiselect controls (i.e. the set of all possible values the control can take)
* fallback - a backup default value for a control which can be used if the hardcoded default in the defaults csv is invalid

## Usage

![](diagram/logic.png?raw=true)

There are 2 possible sources for default values, in order of precedence
* `default_options.csv`
* `fallback_values` coming from the data

When building the options from hintr the way this works is
1. hintr receives a request to return options with paths to files
1. hintr reads files and pulls out options and default values from the data
1. hintr calls naomi.options `get_controls_json` with the `iso3` the `options` from the data and `fallback_values` from the data. Note the `options` and `fallback_values` can be empty and indeed are for calibrate options
1. naomi.options reads the controls from `controls.R` for this type, and adds any `options` passed as an arg into this list for each `control`
1. naomi.options reads the default values from `default_options.csv` 
1. For each control, naomi.options checks if csv value is valid and if it is sets this as the `value` for the control. If it is invalid it checks if there is a default in the `fallback_values` if not uses an empty default `value`
1. naomi.options takes the completed set of controls, serializes them to JSON and embeds them in the options json from `inst/model_options.json` or `inst/calibration_options.json` and returns to hintr
1. hintr returns json back as response

### Notes

* To set an empty value you can use "" or just empty in the `default_options.csv`
* To set multiple default values for multiselect controls separate the values with a `;` and any amount of whitespace e.g. `CMR2018DHS; CMR2017PHIA` or `CMR2018DHS;CMR2017PHIA` will work

## License

MIT © Imperial College of Science, Technology and Medicine

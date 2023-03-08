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
* override - a default value for a control which will be used used for the control, even if there is a hardcoded default value

## Usage

![](diagram/logic.png?raw=true)

There are 2 possible sources for default values, in order of precedence
* `override_values` coming from the data
* `default_options.csv`

When building the options from hintr the way this works is
1. hintr receives a request to return options with paths to files
1. hintr reads files and pulls out options and default values from the data
1. hintr calls naomi.options `get_controls_json` with the `iso3` the `options` from the data and `override_values` from the data. Note the `options` and `override_values` can be empty and indeed are for calibrate options
1. naomi.options reads the controls from `controls.R` for this type, and adds any `options` passed as an arg into this list for each `control`
1. naomi.options reads the default values from `default_options.csv` 
1. For each control, naomi.options checks if an `override_value` exists and is valid. If it is sets this as the `value` for the control. If it is invalid it checks if there is a default in the `default_options,csv` whcih is valid. If not uses an empty default `value`
1. naomi.options takes the completed set of controls, serializes them to JSON and embeds them in the options json from `inst/model_options.json` or `inst/calibration_options.json` and returns to hintr
1. hintr returns json back as response

## Change the default value of a control

Update the `inst/default_options.csv`. There is a row for each country and a column with the ID of the control. Note
* To set an empty value you can use "" or just empty in the `default_options.csv`
* To set multiple default values for multiselect controls separate the values with a `;` and any amount of whitespace e.g. `CMR2018DHS; CMR2017PHIA` or `CMR2018DHS;CMR2017PHIA` will work
* To set a value to use the default from the data overrides set the cell to `NA`

After making any changes run the tests, this will check that the value added is valid and of the correct value for the type.

## Add a new control

To add a new control requires a few steps
1. Add the control to the list of controls in either `get_model_controls()` or `get_calibration_controls()` in `R/controls.R`. Adding it as a `control()` will validate that the control specification is well formed
1. Add it into the json template. This sets where the control is shown on the options page relative to the other controls. Add it to either `inst/anc_options.json`, `inst/art_options.json`, `inst/model_options.json` or `inst/calibration_options.json`. You may need to add a new label or control group. To add the control itself use the name added in step 1 as `"<+control_name+>"`. This string then gets matched and replaced with the control specification from step 1. Comparing this JSON to the options in the app is often the easiest way to see what the different labels and descriptions do but ask Rob if any questions.
1. Set default value, add a new column to `inst/default_options.csv` and set values for each country.
1. Add traduire strings for any label, description or help text added
1. If the new control is a "select" or "multiselect" type where the possible options come from the data then this data will need to be prepared and sent in call to `naomi.options`. Talk to Rob and ask him to do this.

## Update schema for testing

The package validates that the options for every country produces valid options. To do this we re-use the schema from hintr. This will need to be updated periodically if the schema changes by running the script

```
./scripts/copy_schemas
```

## License

MIT © Imperial College of Science, Technology and Medicine

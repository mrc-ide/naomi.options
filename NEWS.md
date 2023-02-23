# naomi.options 1.1.0

* Rename `fallback_values` arg to `override_values` in `get_controls_json` as any `override_values` now take precedence over hardcoded values from the defaults csv.

# naomi.options 1.0.6

* Add `translate_labels` helper function for returning translated labels.

# naomi.options 1.0.5

* Change default calibration `spectrum_plhiv_calibration_strat` to `sex_age_coarse` for all countries, aligned to other calibrations.

# naomi.options 1.0.4

* UGA: 
  - `alpha_xst_term` to TRUE.
  - `spectrum_plhiv_calibration_strat` to `sex_age_coarse` aligned to other calibrations.

# naomi.options 1.0.3

* Added a `NEWS.md` file to track changes to the package.
* Update default survey and T1 options for countries that we know have new survey data for 2023.
  - LSO, MOZ, MWI, SWZ, UGA, ZMB, ZWE

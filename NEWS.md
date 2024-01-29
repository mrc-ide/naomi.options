# naomi.options 1.2.1

* Update default calibration options:
  - "national", except for three countries (Kenya, Zimbabwe, Ethiopia) to subnational.
  - Change stratification to "sex_age_group"
  
  
# naomi.options 1.2.0

* Update defaults for 2024 HIV estimates
  - Extends calendar quarter model options drop downs from `December 2025` to `December 2027`
  - Updates T2, T3, T4, and T5 defaults all 1-year ahead
  - Updates default 'current' ANC input year to 2023
  - Updates TZA defaults to 2022 PHIA survey


# naomi.options 1.1.0

* Rename `fallback_values` arg to `override_values` in `get_controls_json` as any `override_values` now take precedence over hardcoded values from the defaults csv.

# naomi.options 1.0.7

* NAM: change defual psnu_level to 1.

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

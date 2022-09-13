#!/usr/bin/env python3
import requests

schema_url = "https://raw.githubusercontent.com/mrc-ide/hintr/master/inst/schema/ModelRunOptions.schema.json"

r = requests.get(schema_url)
r.raise_for_status()

with open("inst/schema/ModelRunOptions.schema.json", "w") as file:
  file.write(r.text)

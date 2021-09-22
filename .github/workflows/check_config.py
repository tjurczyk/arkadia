import re
import json

with open('config.md', 'r') as file:
    data = file.readlines()

readme_vars = []
schema_vars = []

for line in data:
    variable = re.search("## `(.*)`", line)
    if variable:
        readme_vars.append(variable.group(1))

with open('config_schema.json') as schema_file:
  schema = json.load(schema_file)

for schema_entry in schema["fields"]:
    schema_vars.append(schema_entry["name"])

not_covered = [item for item in schema_vars if item not in readme_vars]
if(len(not_covered) > 0):
    print("Config keys not present in config.md")
    for name in not_covered:
        print(name)
    exit(1)

not_covered = [item for item in readme_vars if item not in schema_vars]
if(len(not_covered) > 0):
    print("Config key not present anymore")
    for name in not_covered:
        print(name)
    exit(1)
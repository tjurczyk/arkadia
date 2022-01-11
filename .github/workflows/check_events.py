import re
import os

mudlet_events = ["mapOpenEvent"]

with open('events.md', 'r') as file:
    data = file.readlines()

events = []
raise_events = []

for line in data:
    variable = re.search("## `(.*)`", line)
    if variable:
        events.append(variable.group(1))

path = os.walk(".")
for root, directories, files in path:
    for file in files:
        if file.endswith(".lua"):
            with open(root + "/" + file) as luas:
                data = luas.readlines()
                for line in data:
                    variable = re.search("raise(?:Global)?Event\(\"(.*?)\"(?:\s*,.*)*\)", line)
                    if variable:
                        raise_events.append(variable.group(1))


not_covered = [item for item in raise_events if item not in events and item not in mudlet_events and not item.startswith("gmcp.")]
if(len(not_covered) > 0):
    print("Events not present in events.md")
    for name in not_covered:
        print(name)
    exit(1)

not_covered = [item for item in events if item not in raise_events]
if(len(not_covered) > 0):
    print("Events not thrown anymore")
    for name in not_covered:
        print(name)
    exit(1)
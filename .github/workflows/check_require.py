import re
import os

exempts = ["short_installer", "installer", "skrypty/utils/installer/recovery_script_content"]

with open('scriptsList.lua', 'r') as file:
    data = file.readlines()

requires = []
lua_files = []


for line in data:
    variable = re.search("\"(.*)\"", line)
    if variable:
        requires.append(variable.group(1))

path = os.walk(".")
for root, directories, files in path:
    for file in files:
        if file.endswith(".lua"):
            prefix = ""
            if root != ".":
                prefix = root[2:] + "/"
            lua_files.append(prefix + file[:-4])
            with open(root + "/" + file) as lua:
                data = lua.readlines()
                for line in data:
                    variable = re.search("require\(\"(.*)\"\)", line)
                    if variable:
                        requires.append(variable.group(1).replace(".", "/"))



not_covered = [item for item in lua_files if item not in requires and item not in exempts]
if(len(not_covered) > 0):
    print("File is never required")
    for name in not_covered:
        print(name)
    exit(1)

not_covered = [item for item in requires if item not in lua_files]
if(len(not_covered) > 0):
    print("File is required but does not exist")
    for name in not_covered:
        print(name)
    exit(1)

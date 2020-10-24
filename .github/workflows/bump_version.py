import re

with open('skrypty.lua', 'r') as file:
    data = file.readlines()

print(data[0])
version = re.search("\D*(\d+)\.(\d+).*", data[0])
versionLine = version.group(0)
major = version.group(1)
minor = int(version.group(2)) + 1

newVersionLine = re.sub("\"((?:\d+\.?)*)\"", '"{0}.{1}"'.format(major, minor), versionLine)
data[0] = newVersionLine + "\n"


with open('skrypty.lua', 'w') as file:
    file.writelines( data )
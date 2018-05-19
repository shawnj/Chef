import os
import json
import sys

file = sys.argv[1]
buildsite = sys.argv[2]
buildnum = sys.argv[3]

with open(file, "r") as jsonFile:
    data = json.load(jsonFile)

tmp = data["default_attributes"]["IPS_Sites"][buildsite.upper()]["BUILD"]

print(data)

data["default_attributes"]["IPS_Sites"][buildsite.upper()]["BUILD"] = buildnum

with open(file, "w") as jsonFile:
    json.dump(data, jsonFile)

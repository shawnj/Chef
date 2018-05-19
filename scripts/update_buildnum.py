import os
import json
import sys

file = sys.argv[1]
buildsite = sys.argv[2]
buildnum = sys.argv[3]
fileid = sys.argv[4]


with open(file, "r") as jsonFile:
    data = json.load(jsonFile)

if fileid is not "":
    data["default_attributes"]["IPS_Sites"][buildsite.upper()]["BUILD"] = str(buildnum) + "." + str(fileid)
else:
    data["default_attributes"]["IPS_Sites"][buildsite.upper()]["BUILD"] = str(buildnum)

with open(file, "w") as jsonFile:
    json.dump(data, jsonFile)
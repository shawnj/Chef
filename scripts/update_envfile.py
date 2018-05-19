import os
import json
import sys

in_file = sys.argv[1]
out_file = sys.argv[2]
chef_env = sys.argv[3]


with open(in_file, "r") as inFile:
    data = json.load(inFile)

with open(out_file, "r") as outFile:
    new_data = json.load(outFile)

new_data["default_attributes"]["IPS_Sites"] = data["default_attributes"]["IPS_Sites"]

with open(out_file, "w") as outFile:
    json.dump(new_data, outFile)
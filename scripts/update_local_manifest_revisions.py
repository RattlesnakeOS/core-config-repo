#!/usr/bin/python3

import xml.etree.ElementTree as ET 
import glob
import sys

if len(sys.argv) != 3:
    print("missing arguments: '<local manifest dir>/*.xml' 'projectname1=revision,projectname2=revision'")
    exit(1)

directory = sys.argv[1]
project_revisions = sys.argv[2].split(",")

for project_revision in project_revisions:
    project = project_revision.split("=")[0]
    revision = project_revision.split("=")[1]
    for filepath in glob.iglob(directory):
        tree = ET.parse(filepath) 
        root = tree.getroot() 
        for p in root.iter('project'):
            if p.get('name') == project:
                print("adding revision='{}' to project '{}' in manifest file '{}'".format(revision, project, filepath))
                p.set('revision', revision)
        tree.write(filepath) 

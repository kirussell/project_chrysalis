import os
import subprocess
import argparse
import flutter.new_project

def parseArgs():
    parser = argparse.ArgumentParser(description='Create flutter project')
    parser.add_argument('project_name', metavar='NAME', type=str,
                        help='project name')
    args = parser.parse_args()
    return args


args = parseArgs()
project_name = args.project_name
project_dir = os.path.join("./", project_name)

flutter.new_project.newFlutterProject(project_name, project_dir)

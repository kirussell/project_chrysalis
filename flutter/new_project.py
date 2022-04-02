import subprocess
import os

#TODO ensure flutter is available 

def flutterCreate(project_name, project_dir):
    print("Creating flutter project %s..." % project_name)
    screenshots_dirs = os.path.join(project_dir, "screenshots")
    subprocess.run(["flutter", "create", project_dir, "--project-name", project_name, "--platforms", "android,ios"])
    subprocess.run(["mkdir", screenshots_dirs])
    subprocess.run(["mkdir", os.path.join(screenshots_dirs, "google_play")])
    subprocess.run(["mkdir", os.path.join(screenshots_dirs, "apple_store")])

def gitInitialCommit(project_name, project_dir):
    print("Initiating local git repo for %s..." % project_name)
    root_dir = os.getcwd()
    os.chdir(project_dir)
    subprocess.run(["git", "init"])
    subprocess.run(["git", "branch", "-m", "main"])
    subprocess.run(["git", "add", "--all"])
    subprocess.run(["git", "commit", "-m", "Initial commit"])
    print("Creating project %s on Github..." % project_name)
    subprocess.run(["gh", "repo", "create", project_name, "--private", "--source=.", "--remote=upstream"])
    subprocess.run(["git", "push", "--set-upstream", "upstream", "main"])
    subprocess.run(["cd", ".."])
    os.chdir(root_dir)

def newFlutterProject(project_name, project_dir):
    flutterCreate(project_name, project_dir)

    #TODO ensure git is available 
    #TODO ensure gh is available 
    gitInitialCommit(project_name, project_dir)

    #TODO create CI/CD project and wire it up
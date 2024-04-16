import os
import json

def get_changed_files():
    changed_files = []
    with open(os.environ['GITHUB_EVENT_PATH'], 'r') as f:
        event = json.load(f)
        for file in event['pull_request']['files']:
            if file['filename'].endswith('.sql'):
                changed_files.append(file['filename'])
    return changed_files

def check_sql_files():
    changed_files = get_changed_files()
    found_staging = False
    for file in changed_files:
        with open(file, "r") as f:
            lines = f.readlines()
            for line in lines:
                if "basedosdados-staging" in line:
                    found_staging = True
                    print(f"Found 'basedosdados-staging' in {file}")
                    break
            if found_staging:
                break
    
    if found_staging:
        exit(1)
    else:
        print("No occurrences of 'basedosdados-staging' found in SQL files.")

if __name__ == "__main__":
    check_sql_files()

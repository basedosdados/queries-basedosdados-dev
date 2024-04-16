import os

def check_sql_files():
    found_staging = False
    for root, dirs, files in os.walk("."):
        for file in files:
            if file.endswith(".sql"):
                with open(os.path.join(root, file), "r") as f:
                    lines = f.readlines()
                    for line in lines:
                        if "basedosdados-staging" in line:
                            found_staging = True
                            print(f"Found 'basedosdados-staging' in {os.path.join(root, file)}")
                            break
                    if found_staging:
                        break
        if found_staging:
            break
    
    if found_staging:
        exit(1)
    else:
        print("No occurrences of 'basedosdados-staging' found in SQL files.")

if __name__ == "__main__":
    check_sql_files()

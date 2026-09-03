import os

count = 0

path_folder = r"C:\QA-test-\TestSuite"

for root, dirs, files in os.walk(path_folder):

    for file in files:

        if file.endswith(".robot"):

            file_path = os.path.join(root, file)

            with open(file_path, "r", encoding="utf-8") as f:

                inside_test_cases = False

                for line in f:

                    stripped = line.rstrip()

                    # Entrer dans la section Test Cases
                    if stripped.strip() == "*** Test Cases ***":
                        inside_test_cases = True
                        continue

                    # Sortir si nouvelle section
                    if inside_test_cases and stripped.strip().startswith("***"):
                        inside_test_cases = False
                        continue

                    # Compter uniquement les noms des tests
                    if inside_test_cases:

                        # ignorer lignes vides
                        if not stripped.strip():
                            continue

                        # ignorer metadata
                        if stripped.strip().startswith("["):
                            continue

                        # ignorer commentaires
                        if stripped.strip().startswith("#"):
                            continue

                        # Un test case commence sans indentation
                        if not line.startswith((" ", "\t")):
                            count += 1

print(f"Total Test Cases : {count}")
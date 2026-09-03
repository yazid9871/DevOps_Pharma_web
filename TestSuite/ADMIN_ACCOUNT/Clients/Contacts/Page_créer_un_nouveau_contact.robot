*** Settings ***
Documentation     Tests fonctionnels de la page " Créer un nouveau contact"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Créer un nouveau contact

*** Variables ***

${SPAN_LOCATOR}  xpath=//*[@id="root"]/div[4]/div[2]/div/div[2]/table/tfoot/tr[2]/td/span/span
${SPAN_LOCATOR}  xpath=//*[@id="root"]/div[4]/div[2]/div/div[2]/table/tfoot/tr[2]/td/span/span
${PREVIOUS_BUTTON}  xpath=//*[@id="root"]/div[4]/div[2]/div/div[2]/table/tfoot/tr[2]/td/span/button[1]
${NEXT_BUTTON}  xpath=/html/body/div/div[4]/div[2]/div/div[2]/table/tfoot/tr[2]/td/span/button[2]
${INPUT_FRSTNAME}    xpath=//*[@id="first_name"]
${INPUT_LASTNAME}    xpath=//*[@id="last_name"]
${INPUT_PPV}    xpath=//*[@id="sale_price"]
${INPUT_PPH}    xpath=//*[@id="purchase_price"]
${SUBMIT}    xpath=/html/body/div/div[4]/div/div/div[2]/button
*** Test Cases ***
Aller à la page de création d'un nouveau contact
     Accéder à la page    Customers/contacts
    Aller à la page de création d'un nouveau contact

Vérifier que la soumission du formulaire réussit avec des données valides
     Vérifier que la soumission du formulaire réussit avec des données valides
Vérifier la redirection vers la page contact
    Rediriger vers la page contact




*** Keywords ***

Aller à la page de liste des contacts
    [Documentation]    Navigate to the contact listing page after login in.
    Go To    ${BASE_URL}/Customers/contacts
    Wait Until Element Is Visible      xpath=//*[@data-testid="créer"]     timeout=30s

Aller à la page de création d'un nouveau contact
     click element     xpath=//*[@data-testid="créer"]
      Wait Until Element Is Visible     ${INPUT_FRSTNAME}    5s
      Définir le zoom du navigateur    70
       sleep    2s
Vérifier que les champs obligatoires sont vides
    ${NAME}     get value     ${INPUT_FRSTNAME}
    ${LASTNAME}     get value     ${INPUT_LASTNAME}
    ${pph}     get value     ${INPUT_PPH}
    ${PPV}     get value     ${INPUT_PPV}

    should be empty     ${NAME}
    should be empty     ${LASTNAME}
    should be empty     ${pph}
    should be empty     ${ppv}

Soumettre et vérifier le message d'erreur
  click element     ${SUBMIT}
  wait until page contains      Ce champ est requis     5s
Définir le zoom du navigateur
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"
Vérifier que la soumission du formulaire réussit avec des données valides

 #Informations générales
    # FIRST Name input
    Input Text    ${INPUT_FRSTNAME}      This is a test contact created
    # LAST Name input
    Input Text    ${INPUT_LASTNAME}        by automation.
    #  title  input
    Input Text    xpath=//*[@id="title"]      tester
    # email
    Input Text   xpath=//*[@id="email"]       test@gmail.com
    # tele input
    Input Text   xpath=//*[@id="phone"]         0509876756
      # Date de naissance input
    Input Text   xpath=//*[@id="birthdate"]      2026-05-21
      # mobile input
    Input Text   xpath=//*[@id="mobile"]      0697859876

      # Type   dropdown
      click element     id=relationship_type_id
    Wait Until Element Is Visible   css=.sob-v2-select-clearable > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)    5s
    click element    css=.sob-v2-select__option:nth-child(2)
     sleep    3s
  # customer    pop up
     click element     id=customer_name
     wait until element is visible     css=tr.zoom:nth-child(1)     10s
     click element      css=tr.zoom:nth-child(1)


  #Informations générales
       # Description input

       Input Text   xpath=//*[@id="description"]      500

      wait until element is visible     xpath=//*[@data-testid="sauvegarder"]   15s
    click element      xpath=//*[@data-testid="sauvegarder"]

    wait until page contains      Le contact a été créé avec succès     10s
Rediriger vers la page contact
     wait until page contains    This is a test contact created by automation.     10s

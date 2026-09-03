*** Settings ***
Documentation     Tests fonctionnels de la page " Créer un nouveau client"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Créer un nouveau client

*** Variables ***
${INPUT_NOM}    xpath=//*[@id="name"]
${INPUT_CIN}    xpath=//*[@id="cin"]
${INPUT_CNSS}    xpath=//*[@id="cnss"]
${SUBMIT}    xpath=//*[@data-testid="sauvegarder"]

*** Test Cases ***
Aller à la page de création d'un nouveau client
     Accéder à la page    customers
    Aller à la page de création d'un nouveau client

Vérifier que la soumission du formulaire réussit avec des données valides
     Vérifier que la soumission du formulaire réussit avec des données valides
#Vérifier la redirection vers la page client
 #   Rediriger vers la page client

*** Keywords ***

Aller à la page de liste des clients
    [Documentation]    Navigate to the customer listing page after login in.
    Go To    ${BASE_URL}/customers
    Wait Until Element Is Visible      xpath=//*[@data-testid="créer"]     timeout=30s

Aller à la page de création d'un nouveau client
     click element     xpath=//*[@data-testid="créer"]
      Wait Until Element Is Visible     ${INPUT_NOM}    5s
      Définir le zoom du navigateur    70
       sleep    2s

Définir le zoom du navigateur
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Vérifier que la soumission du formulaire réussit avec des données valides
      sleep     2s
 #Informations générales
    # Nom input
    Input Text    ${INPUT_NOM}      This is a test client created by automation.
    #  CIN  input
    Input Text    ${INPUT_CIN}      tester
    # CNSS input
    Input Text   ${INPUT_CNSS}       123456
    # email
    Input Text   xpath=//*[@id="email"]       test@gmail.com
    # tele input
    Input Text   xpath=//*[@id="phone"]         0509876756
      # Date de naissance input
    Input Text   xpath=//*[@id="birthdate"]      2026-05-21

      # Genre   dropdown
      click element     id=gender
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(2)    5s
    click element    css=.sob-v2-select__option:nth-child(2)
     sleep    3s

      # Médecin  pop up
      click element     id=doctor_name
     wait until element is visible     css=tr.zoom:nth-child(1)     10s
     click element      css=tr.zoom:nth-child(1)



 # Assurance Maladie Obligatoire (AMO)

 # complementary_payer dropdown

      click element  id=payer_id
    Wait Until Element Is Visible   css=div.sob-v2-container:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)    5s
    click element    css=.sob-v2-select__option:nth-child(2)
    sleep     2s

       # Numéro d'immatriculation input
    #Input Text   xpath=//*[@id="payer_registration_number"]     1245
      # Numéro d'affiliation input
    Input Text   xpath=//*[@id="payer_affiliation_number"]       324

  # complementary_payer dropdown

      click element  id=complementary_payer_id
    Wait Until Element Is Visible   css=div.sob-v2-container:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)    5s
    click element    css=.sob-v2-select__option:nth-child(2)
    sleep     2s

       # Numéro d'immatriculation input
   # Input Text   xpath=//*[@id="complementary_payer_registration_number"]     12
      # Numéro d'affiliation input
    Input Text   xpath=//*[@id="complementary_payer_affiliation_number"]    123
  #Adresse
     # address input
    Input Text   xpath=//*[@id="address"]      El Khatabi، Wifakq
     # postal_code input
    Input Text   xpath=//*[@id="postal_code"]     2000
      # city input
    Input Text   xpath=//*[@id="city"]       rabat
      # country dropdown
      Input Text   xpath=//*[@id="country"]       Maroc
    Wait Until Element Is Visible   css=div.sob-v2-container:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)    5s
    click element       css=.sob-v2-select__option:nth-child(1)
    sleep     2s

        # Descriptioninput
    Input Text    xpath=//*[@id="description"]  This is a test Customer created by automation.
     Execute Javascript    window.scrollTo(0, 0);
     sleep    5s

      wait until element is visible     ${SUBMIT}   15s
    click element      ${SUBMIT}

    ${is_duplicate}=    Run Keyword And Return Status    Wait Until Page Contains    Ce client existe déjà ?    5s
    IF    ${is_duplicate}
        click element      xpath=//*[@data-testid="créer_un_nouveau_client"]
    END

Rediriger vers la page client
     wait until page contains    This is a test client created by automation.     10s

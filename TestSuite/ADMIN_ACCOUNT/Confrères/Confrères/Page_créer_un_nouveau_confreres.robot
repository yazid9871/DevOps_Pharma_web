*** Settings ***
Documentation     Tests fonctionnels de la page " Créer un nouveau Confrères"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Créer un nouveau Confrères

*** Variables ***
${INPUT_NOM}    xpath=//*[@id="name"]
${INPUT_CIN}    xpath=//*[@id="cin"]
${INPUT_CNSS}    xpath=//*[@id="cnss"]
${SUBMIT}    xpath=//*[@data-testid="sauvegarder"]

*** Test Cases ***
Aller à la page de création d'un nouveau Confrères
     Accéder à la page    colleagues
    Aller à la page de création d'un nouveau Confrères

Vérifier que la soumission du formulaire réussit avec des données valides
     Vérifier que la soumission du formulaire réussit avec des données valides

Vérifier la redirection vers la page Confrères
    Rediriger vers la page Confrères

*** Keywords ***

Aller à la page de liste des Confrères
    [Documentation]    Navigate to the colleague listing page after login in.
    Go To    ${BASE_URL}/colleagues
    Wait Until Element Is Visible      xpath=//*[@data-testid="créer"]     timeout=30s

Aller à la page de création d'un nouveau Confrères
     click element     xpath=//*[@data-testid="créer"]
      Wait Until Element Is Visible     ${INPUT_NOM}    5s
      Définir le zoom du navigateur    70
       sleep    2s

Définir le zoom du navigateur
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Vérifier que la soumission du formulaire réussit avec des données valides

 #Informations générales
    # Nom input
    Input Text    ${INPUT_NOM}      This is a test confrere created by automation.
    #  CIN  input
    Input Text    ${INPUT_CIN}      tester
    # CNSS input
    Input Text   ${INPUT_CNSS}       123456
    # email
    Input Text   xpath=//*[@id="email"]       confrere@gmail.com
    # tele input
    Input Text   xpath=//*[@id="phone"]         0611223344

  #Adresse
     # address input
    Input Text   xpath=//*[@id="address"]      El Khatabi، Wifakq
     # postal_code input
    Input Text   xpath=//*[@id="postal_code"]     2000
      # city input
    Input Text   xpath=//*[@id="city"]       rabat
      # country dropdown
      Input Text   css=#country input       Maroc
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(1)    5s
    click element       css=.sob-v2-select__option:nth-child(1)
    sleep     2s

        # Descriptioninput
    Input Text    xpath=//*[@id="description"]  This is a test confrere created by automation.
     Execute Javascript    window.scrollTo(0, 0);
     sleep    2s

      wait until element is visible     ${SUBMIT}   15s
    click element      ${SUBMIT}

    wait until page contains      Le confrère a été créé avec succès     10s

Rediriger vers la page Confrères
     wait until page contains    This is a test confrere created by automation.     10s

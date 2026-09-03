*** Settings ***
Documentation     Tests fonctionnels de la page " Modifier un client"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Modifier un client

*** Variables ***
${INPUT_NOM}    xpath=//*[@id="name"]
${INPUT_CIN}    xpath=//*[@id="cin"]
${SUBMIT}    xpath=//*[@data-testid="sauvegarder"]

*** Test Cases ***
Aller à la page de modification d'un client
     Accéder à la page    customers
    Aller à la page de modification d'un client

Vérifier que la soumission du formulaire de modification réussit avec des données valides
     Vérifier que la soumission du formulaire de modification réussit avec des données valides

Vérifier la redirection vers la page client
    Rediriger vers la page client

*** Keywords ***

Aller à la page de liste des clients
    [Documentation]    Navigate to the customer listing page after login in.
    Go To    ${BASE_URL}/customers
    Wait Until Element Is Visible      xpath=//*[@data-testid="créer"]     timeout=30s

Aller à la page de modification d'un client
     click element     ${EDIT_ICON}
      Wait Until Element Is Visible     ${INPUT_NOM}    5s
      Définir le zoom du navigateur    70
       sleep    2s

Définir le zoom du navigateur
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Vérifier que la soumission du formulaire de modification réussit avec des données valides
      sleep     2s
 #Informations générales
    #  CIN  input
    Input Text    ${INPUT_CIN}      testerUPDATED

      wait until element is visible     ${SUBMIT}   15s
    click element      ${SUBMIT}

    wait until page contains      Le client a été modifié avec succès     10s

Rediriger vers la page client
     wait until page contains    This is a test client created by automation.     10s

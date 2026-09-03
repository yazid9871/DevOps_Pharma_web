*** Settings ***
Documentation     Tests fonctionnels de la page " Modifier un Confrères"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Modifier un Confrères

*** Variables ***
${INPUT_NOM}    xpath=//*[@id="name"]
${INPUT_CIN}    xpath=//*[@id="cin"]
${SUBMIT}    xpath=//*[@data-testid="sauvegarder"]

*** Test Cases ***
Aller à la page de modification d'un Confrères
     Accéder à la page    colleagues
    Aller à la page de modification d'un Confrères

Vérifier que la soumission du formulaire de modification réussit avec des données valides
     Vérifier que la soumission du formulaire de modification réussit avec des données valides

Vérifier la redirection vers la page Confrères
    Rediriger vers la page Confrères

*** Keywords ***

Aller à la page de liste des Confrères
    [Documentation]    Navigate to the colleague listing page after login in.
    Go To    ${BASE_URL}/colleagues
    Wait Until Element Is Visible      xpath=//*[@data-testid="créer"]     timeout=30s

Aller à la page de modification d'un Confrères
     Wait Until Element Is Visible     ${EDIT_ICON}    15s
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

    wait until page contains      Le confrère a été modifié avec succès     10s

Rediriger vers la page Confrères
     wait until page contains    This is a test confrere created by automation.     10s

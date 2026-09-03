*** Settings ***
Documentation     Tests fonctionnels de la page " Modifier un contact"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Modifier un contact

*** Variables ***
${INPUT_NOM}    xpath=//*[@id="last_name"]
${INPUT_TITLE}    xpath=//*[@id="title"]
${SUBMIT}    xpath=//*[@data-testid="sauvegarder"]

*** Test Cases ***
Aller à la page de modification d'un contact
     Accéder à la page     suppliers/contacts
    Aller à la page de modification d'un contact

Vérifier que la soumission du formulaire de modification réussit avec des données valides
     Vérifier que la soumission du formulaire de modification réussit avec des données valides

Vérifier la redirection vers la page contact
    Rediriger vers la page contact

*** Keywords ***

Aller à la page de modification d'un contact
    wait until element is visible        ${EDIT_ICON}    20s
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
    Input Text    ${INPUT_TITLE}      testerUPDATED

      wait until element is visible     ${SUBMIT}   15s
    click element      ${SUBMIT}

    wait until page contains      Le contact a été modifié avec succès     10s

Rediriger vers la page contact
     wait until page contains    This is a test contact created by automation.     10s

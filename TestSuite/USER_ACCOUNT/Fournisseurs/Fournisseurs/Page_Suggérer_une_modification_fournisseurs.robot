*** Settings ***
Documentation     Tests fonctionnels de la page " Suggérer une modification"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Suggérer une modification

*** Variables ***
${SUPPLIER_ID}       supplier/3966/table
${INPUT_NOM}    xpath=//*[@id="name"]
${INPUT_FAX}    xpath=//*[@id="fax"]
${SUBMIT}    xpath=//*[@data-testid="sauvegarder"]

*** Test Cases ***
Aller à la page de création d'une nouvelle Suggérer une modification
    Aller à la page de liste des Suggérer une modification
    Aller à la page Suggérer une modification

Vérifier que la soumission du formulaire réussit avec des données valides
     Vérifier que la soumission du formulaire réussit avec des données valides

Vérifier la redirection vers la page Suggérer une modification
    Rediriger vers la page Suggérer une modification

*** Keywords ***

Aller à la page de liste des Suggérer une modification
    [Documentation]    Navigate to the supplier detail page after login in.
    Go To    ${BASE_URL}/${SUPPLIER_ID}
    Wait Until Element Is Visible      xpath=//*[@data-testid="suggérer_une_modification"]     timeout=30s

Aller à la page Suggérer une modification
     click element      xpath=//*[@data-testid="suggérer_une_modification"]
      Wait Until Element Is Visible     ${INPUT_NOM}    5s
      Définir le zoom du navigateur    70
       sleep    2s

Définir le zoom du navigateur
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Vérifier que la soumission du formulaire réussit avec des données valides

 #Informations générales
    # le formulaire est pré-rempli avec les données actuelles du fournisseur
    ${nom_actuel}=    Get Value    ${INPUT_NOM}
    Should Not Be Empty    ${nom_actuel}
    #  Fax  input
    Input Text    ${INPUT_FAX}      0522334456UPDATED

    Execute JavaScript    window.scrollTo(0, 0);
    sleep    1s

      wait until element is visible     ${SUBMIT}   15s
      click element      ${SUBMIT}

    wait until page contains      Votre suggestion de modification de fournisseur a été crée avec succès.     10s

Rediriger vers la page Suggérer une modification
     wait until page contains    Fournis_Test     10s

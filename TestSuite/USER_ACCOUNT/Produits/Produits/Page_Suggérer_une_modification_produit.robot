*** Settings ***
Documentation     Tests fonctionnels de la page " Suggérer produit"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Suggérer produit

*** Variables ***
${PRODUCT_ID}       product/176297/table
${INPUT_NOM}    xpath=//*[@id="name"]
${INPUT_PRESENTATION}    xpath=//*[@id="presentation"]
${SUBMIT}    xpath=//*[@data-testid="sauvegarder"]

*** Test Cases ***
Aller à la page de création d'une nouvelle Suggérer produit
    Aller à la page de liste des Suggérer produit
    Aller à la page Suggérer produit

Vérifier que la soumission du formulaire réussit avec des données valides
     Vérifier que la soumission du formulaire réussit avec des données valides

Vérifier la redirection vers la page Suggérer produit
    Rediriger vers la page Suggérer produit

*** Keywords ***

Aller à la page de liste des Suggérer produit
    [Documentation]    Navigate to the product detail page after login in.
    Go To    ${BASE_URL}/${PRODUCT_ID}
    Wait Until Element Is Visible      xpath=//*[@data-testid="suggérer_une_modification"]     timeout=30s

Aller à la page Suggérer produit
     click element      xpath=//*[@data-testid="suggérer_une_modification"]
      Wait Until Element Is Visible     ${INPUT_NOM}    5s
      Définir le zoom du navigateur    70
       sleep    2s

Définir le zoom du navigateur
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Vérifier que la soumission du formulaire réussit avec des données valides

 #Informations générales
    # le formulaire est pré-rempli avec les données actuelles du produit
    ${nom_actuel}=    Get Value    ${INPUT_NOM}
    Should Not Be Empty    ${nom_actuel}
    #  Présentation  input
    Input Text    ${INPUT_PRESENTATION}      Boite de 20 comprimés UPDATED

    Execute JavaScript    window.scrollTo(0, 0);
    sleep    1s

      wait until element is visible     ${SUBMIT}   15s
      click element      ${SUBMIT}

    wait until page contains      La suggestion de modification de produit a été transmise avec succès.     10s

Rediriger vers la page Suggérer produit
     wait until page contains    Suggestions des produits     10s

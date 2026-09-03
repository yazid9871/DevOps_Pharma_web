*** Settings ***
Documentation     Tests fonctionnels de la page " Modifier produit"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Modifier produit

*** Variables ***
${INPUT_PPH}    xpath=//*[@id="purchase_price"]
${INPUT_STOCK_MIN}    xpath=//*[@id="min_stock"]
${SUBMIT}    xpath=//*[@data-testid="sauvegarder"]

*** Test Cases ***
Aller à la page de création d'une nouvelle Modifier produit
    Aller à la page de liste des Modifier produit
    Aller à la page Modifier produit

Vérifier que la soumission du formulaire réussit avec des données valides
     Vérifier que la soumission du formulaire réussit avec des données valides

Vérifier la redirection vers la page Modifier produit
    Rediriger vers la page Modifier produit

*** Keywords ***

Aller à la page de liste des Modifier produit
    [Documentation]    Navigate to the products listing page after login in.
    Go To    ${BASE_URL}/products
    Wait Until Element Is Visible      ${EDIT_ICON}     timeout=30s

Aller à la page Modifier produit
     click element      ${EDIT_ICON}
      Wait Until Element Is Visible     ${INPUT_PPH}    5s
      Définir le zoom du navigateur    70
       sleep    2s

Définir le zoom du navigateur
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Vérifier que la soumission du formulaire réussit avec des données valides

 #Informations du stock
    # le formulaire est pré-rempli avec les données actuelles du produit
    ${pph_actuel}=    Get Value    ${INPUT_PPH}
    Should Not Be Empty    ${pph_actuel}
    #  Stock min  input
    Input Text    ${INPUT_STOCK_MIN}      5

    Execute JavaScript    window.scrollTo(0, 0);
    sleep    1s

      wait until element is visible     ${SUBMIT}   15s
      click element      ${SUBMIT}

    wait until page contains      Le produit a été mis à jour avec succès     10s

Rediriger vers la page Modifier produit
     wait until page contains    Informations générales     10s

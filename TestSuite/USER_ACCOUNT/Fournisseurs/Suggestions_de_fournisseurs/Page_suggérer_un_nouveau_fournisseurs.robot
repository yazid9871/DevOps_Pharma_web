*** Settings ***
Documentation     Tests fonctionnels de la page " Suggérer fournisseurs"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page Suggérer fournisseurs

*** Variables ***
${INPUT_NOM}    xpath=//*[@id="name"]
${INPUT_TELEPHONE}    xpath=//*[@id="phone"]
${INPUT_VILLE}    xpath=//*[@id="city"]
${SUBMIT}    xpath=//*[@data-testid="sauvegarder"]
${SUPPLIER_NAME}    test suggestion fournisseur automation

*** Test Cases ***
Aller à la page de création d'une nouvelle Suggérer fournisseurs
     Accéder à la page    suppliers/suggestions
    Aller à la page de création d'une nouvelle Suggérer fournisseurs

Vérifier que la soumission du formulaire réussit avec des données valides
     Vérifier que la soumission du formulaire réussit avec des données valides

Vérifier la redirection vers la page Suggérer fournisseurs
    Rediriger vers la page Suggérer fournisseurs

*** Keywords ***

Aller à la page de liste des Suggérer fournisseurs
    [Documentation]    Navigate to the supplier suggestions listing page after login in.
    Go To    ${BASE_URL}/suppliers/suggestions
    Wait Until Element Is Visible      xpath=//*[@data-testid="suggérer_un_nouveau_fournisseur"]     timeout=30s

Aller à la page de création d'une nouvelle Suggérer fournisseurs
     click element     xpath=//*[@data-testid="suggérer_un_nouveau_fournisseur"]
      Wait Until Element Is Visible     ${INPUT_NOM}    5s
      Définir le zoom du navigateur    70
       sleep    2s

Définir le zoom du navigateur
    [Arguments]    ${zoom_percentage}
    Execute JavaScript    document.body.style.zoom="${zoom_percentage}%"

Vérifier que la soumission du formulaire réussit avec des données valides

 #Informations générales
    # Nom input
    Input Text    ${INPUT_NOM}      ${SUPPLIER_NAME}
    #  E-mail  input
    Input Text    id=email      fournisseur@gmail.com
    #  Téléphone  input
    Input Text    ${INPUT_TELEPHONE}      0522334455
    #  Fax  input
    Input Text    id=fax      0522334456
    #  Site internet  input
    Input Text    id=website      https://test-fournisseur.ma

    Execute JavaScript    window.scrollBy(0, 400);
    sleep    1s

  #Adresse
     # address input
    Input Text    id=address      El Khatabi، Wifakq
     # Ville input
    Input Text    ${INPUT_VILLE}       rabat
     # postal_code input
    Input Text    id=postal_code     2000
      # Pays dropdown
      Input Text   css=#country input       Maroc
    Wait Until Element Is Visible   css=.sob-v2-select__option:nth-child(1)    5s
    click element       css=.sob-v2-select__option:nth-child(1)
    sleep     2s

    Execute JavaScript    window.scrollBy(0, 400);
    sleep    1s

        # Description input
    Input Text    id=description  This is a test supplier suggestion created by automation.

     Execute Javascript    window.scrollTo(0, 0);
     sleep    2s

      wait until element is visible     ${SUBMIT}   15s
    click element      ${SUBMIT}

    wait until page contains      Le fournisseur que vous avez suggéré a été crée avec succès.     10s

Rediriger vers la page Suggérer fournisseurs
     wait until page contains    Suggestions de fournisseurs     10s
     wait until page contains    ${SUPPLIER_NAME}     10s

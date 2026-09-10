*** Settings ***
Documentation     Tests fonctionnels de la page "Page de création de vente v1 : Alerte aux interactions "
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Page de création de vente v1 : Alerte aux interactions

*** Variables ***


${draft_button}      xpath=//*[@data-testid="brouillon"]

${SEARCH_FIELD_ZONE}      id=zone_id.q
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="barcode"]
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="barcode"]
${SEARCH_FIELD_DCI}     id=product_dci_id.q
${continuer_BUTTON}        xpath=//*[@data-testid="continuer"]
${Gestionnaire}        css=.sob-v2-navbar-user-fullName
*** Test Cases ***
go to create devis page
    Go To devis Listing Page      invoice/create?source=invoices
    go to create devis page
valide le compte user par ecurity_code
     valide le compte user par ecurity_code      ${PASSWORD2}
Verify pop up Interaction :Utiliser avec précaution
    Select Products    PROPRANOLOL
     Select Products    VILDAGLIPTINE
    Verify pop up Utiliser avec précaution
    delete product from product list
Verify pop up Interaction : À prendre en compte
    Select Products    ACEBUTOLOL
     Select Products    ATENOLOL
    Verify pop up À prendre en compte
    delete product from product list
Verify pop up Interaction : Association déconseillée
    Select Products    APIXABAN
     Select Products    VORICONAZOLE
    Verify pop up Association déconseillée
    delete product from product list
Verify pop up Interaction : Contre-indication
    Select Products    SIMVASTATINE
     Select Products    VORICONAZOLE
    Verify pop up Contre-indication
    delete product from product list

#verify edit pop up
  #  edit product
  #  verify results
*** Keywords ***

Go To devis Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
go to create devis page
     Wait Until Element Is Visible   ${draft_button}  timeout=30s









Select Products
     [Arguments]     ${product1}
    Input Text    ${SEARCH_FIELD_DCI}    ${product1}
    Press Keys    ${SEARCH_FIELD_DCI}    RETURN
    sleep    2s
    Wait Until Element Is Visible    xpath=${table}    30s
    Click Element    xpath=${table}

Verify pop up Utiliser avec précaution
    wait until page contains    À utiliser avec précaution     15s
    click element    ${continuer_BUTTON}

Verify pop up À prendre en compte
    wait until page contains   À prendre en compte    15s
    click element    ${continuer_BUTTON}

Verify pop up Association déconseillée
    wait until page contains   Association déconseillée   15s
    click element    ${continuer_BUTTON}

Verify pop up Contre-indication
    wait until page contains    Contre-indication    15s
    click element    ${continuer_BUTTON}


delete product from product list
      click element   id=delete
       sleep    1s
       click element   id=delete
       sleep    1s
       Reload Page
       sleep     2s
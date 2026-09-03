*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports Ventes par mois par laboratoire"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports Ventes par mois par laboratoire

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       03/2026
${TITRE_PAGE}        Ventes par mois par laboratoire
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
      [Documentation]    Vérifier affichage du rapport
      Accéder à la page    reports/salesbymonth
    wait until page contains    ${TITRE_PAGE}    10s


UC02 -choise produit
    [Documentation]
     Click Button     ${refresh}
     wait until element is visible      id=product_name    10s
     sleep    2s
   click element     id=product_name
   wait until element is visible      id=q      10s
   input text     id=q      3 CLAVELES 10 LIMES CORINDON 11CM REF 80180
     Press Keys    id=q    ENTER
     sleep   2s
   wait until element is visible         css=div.table__container:nth-child(3) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(1)      10s
   click element       css=div.table__container:nth-child(3) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(1)

    Wait Until Element Is Visible    xpath=//table      10s
UC03 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_year     ${DATE_START}
    Wait Until Element Is Visible    css=.sob-v2-table




UC04 choise Fournisseur
    [Documentation]
     sleep    2s
     wait until element is visible      xpath=//input[@id='laboratory_supplier_id']      10s
      Click Element    xpath=//input[@id='laboratory_supplier_id']
      Input Text       xpath=//input[@id='laboratory_supplier_id']    sobrus
      Press Keys       xpath=//input[@id='laboratory_supplier_id']    ENTER
       Press Keys       xpath=//input[@id='laboratory_supplier_id']    ENTER
      sleep     2s
    Wait Until Element Is Visible    xpath=//table

UC05 -choise DCI
    [Documentation]
   click element     id=product_dci_id
   wait until element is visible    css=.sob-v2-select__input-container
  # click element        css=.sob-v2-select__option:nth-child(1)
    Wait Until Element Is Visible    xpath=//table

UC06 -choise Tout Classe thérapeutique
    [Documentation]
   click element     id=product_therapeutic_class_id
   wait until element is visible    css=div.sob-v2-col:nth-child(3) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)
  # click element      css=.sob-v2-select__option:nth-child(2)
    Wait Until Element Is Visible    xpath=//table

UC07 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table

UC8 - verify button csv and print
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    wait until element is visible     xpath=//button[@data-testid="imprimer_"]

UC09 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau

    Page Should Contain    Produit
    Page Should Contain     Laboratoire
    Page Should Contain    Disponible
    Page Should Contain    Juil
    Page Should Contain    Août
    Page Should Contain     Sept
    Page Should Contain      Oct
    Page Should Contain     Nov
    Page Should Contain     Déc
    Page Should Contain     Janv
    Page Should Contain     Févr
    Page Should Contain     Mars
    Page Should Contain      Avr
    Page Should Contain     Mai
    Page Should Contain     Juin
    Page Should Contain     Total






*** Settings ***
Documentation     Tests fonctionnels de la page "Rapport sur stock par produit"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Rapport sur stock par produit

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}       Rapport sur stock par produit
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page    reports/stockbyproduct
    wait until page contains    ${TITRE_PAGE}    10s



UC02 -choise produit
    [Documentation]
     Click Button     ${refresh}
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
    Input Text     id=date     ${DATE_START}
    Wait Until Element Is Visible    css=.sob-v2-table

UC04 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table


UC06 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau

    Page Should Contain    Produit
    Page Should Contain    Quantité totale
    Page Should Contain    % Quantité
    Page Should Contain    Total PPV
    Page Should Contain    % PPV
    Page Should Contain     Total PPH
    Page Should Contain      % PPH





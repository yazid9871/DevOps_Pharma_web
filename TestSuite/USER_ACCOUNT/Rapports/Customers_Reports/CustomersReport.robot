
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports sur clients"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports sur clients

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${TITRE_PAGE}     Rapports sur clients
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page  reports/customersmain
    wait until page contains    ${TITRE_PAGE}    10s


UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=date     ${DATE_START}
    Wait Until Element Is Visible    css=.sob-v2-table

UC03 - Vérifier affichage des cards
    [Documentation]    Vérifier des cards
     sleep    2s
    Page Should Contain     Nombre de clients
    Page Should Contain    Solde
    Page Should Contain     Total crédit
    Page Should Contain    Total Avoir

    ${value}=    Get Text    css=div.RapportCard:nth-child(1) > div:nth-child(2)
    Should Not Be Empty    ${value}
     ${value2}=    Get Text    css=div.RapportCard:nth-child(2) > div:nth-child(2) > div:nth-child(1)
    Should Not Be Empty    ${value2}
     ${value3}=    Get Text    css=div.RapportCard:nth-child(3) > div:nth-child(2) > div:nth-child(1)
    Should Not Be Empty    ${value3}
     ${value4}=    Get Text    css=div.RapportCard:nth-child(4) > div:nth-child(2) > div:nth-child(1)
    Should Not Be Empty    ${value4}
UC03 -choise Statut des clients
    [Documentation]
   click element     id=status
   wait until element is visible    css=div.sob-v2-row:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)
   click element      css=.sob-v2-select__option:nth-child(2)
    Wait Until Element Is Visible    xpath=//table
UC03 -choise Type de clients
    [Documentation]
   click element     id=has_ice
   wait until element is visible    css=div.sob-v2-col:nth-child(2) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)
   click element      css=.sob-v2-select__option:nth-child(2)
    Wait Until Element Is Visible    xpath=//table
UC05 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table

UC05 - Vérifier bouton imprimer
    [Documentation]    Vérifier bouton imprimer
    wait until element is visible      xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/button
    Click Button         xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/button
UC06 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain    Nom
    Page Should Contain    Dernier achat
    Page Should Contain   Date du dernier paiement
    Page Should Contain    Crédit
    Page Should Contain    Avoir
    Page Should Contain    Solde




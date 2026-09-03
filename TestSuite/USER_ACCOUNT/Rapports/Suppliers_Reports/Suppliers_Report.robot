
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapport sur paiements fournisseurs"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Rapport sur paiements fournisseurs

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}   Rapports sur fournisseurs
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
      [Documentation]    Vérifier affichage du rapport
      Accéder à la page     reports/suppliersmain
    wait until page contains    ${TITRE_PAGE}    10s





UC02 - Vérifier affichage des cards
    [Documentation]    Vérifier des cards
     sleep    2s
    Page Should Contain      Nombre de fournisseurs
    Page Should Contain     Solde
    Page Should Contain     Total crédit
    Page Should Contain     Total Avoir
    ${value}=    Get Text    css=div.RapportCard:nth-child(1) > div:nth-child(2)
    Should Not Be Empty    ${value}
     ${value2}=    Get Text    css=div.RapportCard:nth-child(2) > div:nth-child(2) > div:nth-child(1)
    Should Not Be Empty    ${value2}
    Page Should Contain     Total Avoir
    ${value3}=    Get Text    css=div.RapportCard:nth-child(3) > div:nth-child(2) > div:nth-child(1)
    Should Not Be Empty    ${value3}
     ${value4}=    Get Text    css=div.RapportCard:nth-child(4) > div:nth-child(2) > div:nth-child(1)
    Should Not Be Empty    ${value4}



UC03 - Vérifier bouton imprimer
    [Documentation]    Vérifier bouton imprimer
    wait until element is visible      xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/button
    Click Button         xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/button

UC04 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain    Nom
    Page Should Contain    Date dernier achat
    Page Should Contain    Date du dernier paiement
    Page Should Contain    Crédit
    Page Should Contain    Avoir
    Page Should Contain     Solde





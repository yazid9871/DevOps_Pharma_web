*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Droits de timbre"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports Droits de timbre

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}    Droits de timbre
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page  reports/stampduty


UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Wait Until Element Is Visible    css=.sob-v2-table

UC03 - Vérifier affichage des cards
    [Documentation]    Vérifier des cards
     sleep    2s
    Page Should Contain      Montant total Espèces
    Page Should Contain      Droits de timbre
    ${value}=    Get Text    css=div.RapportCard:nth-child(1) > div:nth-child(2) > div:nth-child(1)
    Should Not Be Empty    ${value}
     ${value2}=    Get Text    css=div.RapportCard:nth-child(2) > div:nth-child(2) > div:nth-child(1)
    Should Not Be Empty    ${value2}


UC04 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table

UC05 - click sur Formulaire pré-rempli
    [Documentation]    Vérifier bouton imprimer
    wait until element is visible      xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/div[2]/button
    Click Button         xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/div[2]/button

UC07 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain    Date
    Page Should Contain    Type
    Page Should Contain     Droits de timbre
    Page Should Contain    Montant
    Page Should Contain     Créé par
    Page Should Contain     Créé le





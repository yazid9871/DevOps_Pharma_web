
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports sur stocks"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Rapports sur stock

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${TITRE_PAGE}        Rapports sur stock
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
     [Documentation]    Vérifier affichage du rapport
      Accéder à la page    reports/stockmain
    wait until page contains    ${TITRE_PAGE}    10s

UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=date     ${DATE_START}

UC8 - verify button csv and print
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    wait until element is visible     xpath=//button[@data-testid="imprimer_"]


UC04 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}



UC05 - Vérifier affichage des cards
    [Documentation]    Vérifier des cards
     sleep    2s
    Page Should Contain     Quantité totale
    Page Should Contain     Total PPV
    Page Should Contain      Total PPH

    ${value}=    Get Text    css=div.RapportCard:nth-child(1) > div:nth-child(2)
    Should Not Be Empty    ${value}





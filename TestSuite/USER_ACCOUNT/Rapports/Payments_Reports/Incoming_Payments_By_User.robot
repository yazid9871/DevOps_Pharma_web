*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports   Encaissements par utilisateur"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports   Encaissements par utilisateur

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}     Encaissements par utilisateur
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page    reports/incomingpaymentsbyuser
    wait until page contains    ${TITRE_PAGE}    10s



UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Wait Until Element Is Visible    css=.sob-v2-table




UC04 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table

UC05 - verify button download end print
    [Documentation]    Vérifier bouton imprimer
    wait until element is visible      xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/div[2]/button[2]
    Click Button         xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/div[2]/button[2]
    sleep    2s
    click element    xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/div[2]/button[1]

UC07 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain    Utilisateur
    Page Should Contain    Espèce
    Page Should Contain     Avoir
    Page Should Contain    Total



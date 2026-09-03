
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports   Ventes par zone
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags       Rapports  Ventes par zone

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}       Ventes par zone
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
     Open Browser  ${BASE_URL}  Firefox
      Login With Valid Credentials compt2
    Go To    ${BASE_URL}/reports/salesbyzone
    wait until page contains    ${TITRE_PAGE}    10s
    Page Should Contain Element     css=.sob-v2-table


UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Wait Until Element Is Visible    css=.sob-v2-table


UC03 -choise Zone
    [Documentation]
   click element     id=zone_id
   wait until element is visible    css=.sob-v2-select-clearable > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)
   click element      css=.sob-v2-select__option:nth-child(1)
    Wait Until Element Is Visible    xpath=//table

UC05 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table


UC06 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain     Zone
    Page Should Contain     Quantité
    Page Should Contain     %
    Page Should Contain      PPV
    Page Should Contain     %
    Page Should Contain    PPV Remisé
    Page Should Contain     %






*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports Chiffre d'affaires par catégorie"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports Chiffre d'affaires par catégorie

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/02/2026
${DATE_END}         28/02/2026
${TITRE_PAGE}           Chiffre d'affaires par catégorie
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page    reports/turnoverbycategory
    wait until page contains    ${TITRE_PAGE}    10s




UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Click Button     ${refresh}
    Wait Until Element Is Visible    css=.sob-v2-table

UC03 -choise type
    [Documentation]
   click element     id=type
   wait until element is visible    css=.sob-v2-select__input-container
   click element      css=.sob-v2-select__option:nth-child(2)
    Wait Until Element Is Visible    xpath=//table

UC04 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table


UC05 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
    Page Should Contain    Catégorie
    Page Should Contain    Marge
    Page Should Contain    Total HT
    Page Should Contain    Total TVA
    Page Should Contain    Total TTC
    Page Should Contain    Remise
    Page Should Contain    C.A Brut

UC06 - Imprimer le rapport
    [Documentation]    Vérifier bouton imprimer
    wait until element is visible      xpath=/html/body/div[1]/div/div[4]/div[2]/button
    Click Button         xpath=/html/body/div[1]/div/div[4]/div[2]/button





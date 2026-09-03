

*** Settings ***
Documentation     Tests fonctionnels de la page "Rapport d’écarts d’Inventaire"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags      Rapport d’écarts d’Inventaire

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}      Rapport d’écarts d’Inventaire
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
     [Documentation]    Vérifier affichage du rapport
      Accéder à la page     reports/stocktakesbyperiod
    wait until page contains    ${TITRE_PAGE}    10s



UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Wait Until Element Is Visible    css=.sob-v2-table




UC03 - verify button télécharger_en_csv
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    wait until element is visible     xpath=//button[@data-testid="télécharger_en_csv"]


UC034 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table


UC05 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain    Nom
    Page Should Contain    PPH
    Page Should Contain     Quantité en stock
    Page Should Contain    Quantité réelle
    Page Should Contain     Ecart
    Page Should Contain     Valeur en PPV
    Page Should Contain     Valeur en PPH


    Page Should Contain    Résumé
    Page Should Contain    Total quantité en stock
    Page Should Contain     Total quantité actuelle
    Page Should Contain    Total écart (en Quantité)
    Page Should Contain     Ecart total en PPH
    Page Should Contain     Valeur en PPV




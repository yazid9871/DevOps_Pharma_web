
*** Settings ***
Resource   ../../../../../Resources/Auth.robot
Library    SeleniumLibrary
Documentation    Tests fonctionnels pour la page Rapports sur achats

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${TITRE_PAGE}        Stock par catégorie
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
     Open Browser  ${BASE_URL}  Firefox
      Login With Valid Credentials compt2
    Go To    ${BASE_URL}/reports/stockbycategory
    wait until page contains    ${TITRE_PAGE}    10s
    Page Should Contain Element     css=.sob-v2-table


UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=date     ${DATE_START}
    Wait Until Element Is Visible    css=.sob-v2-table



UC05 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table

UC05 - verify button print
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    wait until element is visible     xpath=//button[@data-testid="imprimer_"]

UC06 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain     Catégorie
    Page Should Contain     Quantité totale
    Page Should Contain    % Quantité
    Page Should Contain    Total PPV HT
    Page Should Contain    Total PPV
    Page Should Contain     % PPV
    Page Should Contain     Total PPH HT
    Page Should Contain     Total PPH
    Page Should Contain     % PPH





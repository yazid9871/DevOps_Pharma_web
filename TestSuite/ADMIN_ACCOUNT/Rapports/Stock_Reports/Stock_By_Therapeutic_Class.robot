
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Stock par classe thérapeutique"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports  Stock par classe thérapeutique

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${TITRE_PAGE}      Stock par classe thérapeutique
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page     reports/stockbytherapeuticclass
    wait until page contains    ${TITRE_PAGE}    10s




UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=date     ${DATE_START}
    Wait Until Element Is Visible    css=.sob-v2-table


UC03 -choise Utilisateur
    [Documentation]
   click element     id=product_therapeutic_class_id
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
    Page Should Contain    Classe thérapeutique
    Page Should Contain     Quantité totale
    Page Should Contain     % Quantité
    Page Should Contain      Total PPV
    Page Should Contain     % PPV
    Page Should Contain    Total PPH
    Page Should Contain     % PPH






*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Achats par laboratoire"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports  Achats par laboratoire

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}        Achats par laboratoire
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page    reports/purchasesbylaboratory
    wait until page contains    ${TITRE_PAGE}    10s



UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Wait Until Element Is Visible    css=.sob-v2-table


UC03 choise Fournisseur
    [Documentation]
     sleep    2s
      Click Element    xpath=//input[@id='laboratory_supplier_id']
      Input Text       xpath=//input[@id='laboratory_supplier_id']    sobrus
      Press Keys       xpath=//input[@id='laboratory_supplier_id']    ENTER
       Press Keys       xpath=//input[@id='laboratory_supplier_id']    ENTER
      sleep     2s
    Wait Until Element Is Visible    xpath=//table
UC04 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table



UC05 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain      Laboratoire
    Page Should Contain      Quantité
    Page Should Contain     %
    Page Should Contain     PPH
    Page Should Contain      %
    Page Should Contain      PPH Remisé
    Page Should Contain     	%





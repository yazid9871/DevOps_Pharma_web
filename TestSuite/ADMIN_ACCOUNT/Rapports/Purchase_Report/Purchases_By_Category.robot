*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports Achats par famille tarifaire (Catégorie et TVA)"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports  Achats par famille tarifaire (Catégorie et TVA)

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}        Achat par catégorie
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page  reports/purchasesbycategory
    wait until page contains    ${TITRE_PAGE}    10s
    Page Should Contain Element     css=.sob-v2-table


UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Wait Until Element Is Visible    css=.sob-v2-table


UC03 choise Fournisseur
    [Documentation]
      Click Element    xpath=//input[@id='supplier_id']
      Input Text       xpath=//input[@id='supplier_id']    sobrus
      Press Keys       xpath=//input[@id='supplier_id']    ENTER
       Press Keys       xpath=//input[@id='supplier_id']    ENTER
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
    Page Should Contain    Catégorie
    Page Should Contain    Quantité totale
    Page Should Contain    % Quantité
    Page Should Contain     Total PPH
    Page Should Contain     Remise
    Page Should Contain     Total PPH Remisé
    Page Should Contain     % Remise PPH
     Page Should Contain     Marge






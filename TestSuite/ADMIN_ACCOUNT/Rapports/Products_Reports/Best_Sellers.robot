
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Les produits les plus vendus"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports  Les produits les plus vendus

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}     Les produits les plus vendus
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page    reports/productsbestsellers
    wait until page contains    ${TITRE_PAGE}    10s



UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Wait Until Element Is Visible    css=.sob-v2-table
UC03 -choise category
    [Documentation]
   click element     id=product_category_id
   wait until element is visible    css=.sob-v2-select__input-container
   click element      css=.sob-v2-select__option:nth-child(1)
    Wait Until Element Is Visible    xpath=//table

UC04 - Vérifier bouton Télécharger en CSV
    [Documentation]    Vérifier bouton Télécharger en CSV
    wait until element is visible      xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/a/button
    Click Button         xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/a/button


UC05 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
     Page Should Contain    Produit
    Page Should Contain     Quantité vendue
    Page Should Contain    Quantité retournée
    Page Should Contain    Quantité nette
    Page Should Contain    Date dernière vente

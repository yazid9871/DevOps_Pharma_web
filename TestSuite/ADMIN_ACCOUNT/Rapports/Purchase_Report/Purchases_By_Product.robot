
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports   Achats par produit"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports  Achats par produit

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}         Achats par produit
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
     [Documentation]    Vérifier affichage du rapport
      Accéder à la page  reports/purchasesbyproduct
    wait until page contains    ${TITRE_PAGE}    10s


UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Wait Until Element Is Visible    css=.sob-v2-table


UC03 -choise produit
    [Documentation]
     Click Button     ${refresh}
   click element     id=product_name
   wait until element is visible      id=q      10s
   input text     id=q      3 CLAVELES
     Press Keys    id=q    ENTER
   wait until element is visible        xpath=/html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr[2]  10s
   click element        xpath=/html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr[2]
      click element        xpath=/html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr[2]

    Wait Until Element Is Visible    xpath=//table      10s

UC04 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table

UC05 - verify button télécharger en csv
    wait until element is visible     xpath=//button[@data-testid="télécharger_en_csv"]

UC05 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain    Date
    Page Should Contain   Créé le
    Page Should Contain    Produit
    Page Should Contain     Quantité
    Page Should Contain     Prix d'origine
    Page Should Contain     Prix unitaire
    Page Should Contain     Disponible





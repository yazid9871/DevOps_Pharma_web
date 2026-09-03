
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Ventes par produit"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports  Ventes par produit

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}         Ventes par produit
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
      [Documentation]    Vérifier affichage du rapport
      Accéder à la page    reports/salesbyproduct
    wait until page contains    ${TITRE_PAGE}    10s




UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Wait Until Element Is Visible    css=.sob-v2-table


UC03 -choise Utilisateur
    [Documentation]
   click element     id=owner_id
   wait until element is visible    css=.sob-v2-select-clearable > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)
   click element      css=.sob-v2-select__option:nth-child(1)
    Wait Until Element Is Visible    xpath=//table

UC04 -choise produit
    [Documentation]
     Click Button     ${refresh}
   click element     id=product_name
   wait until element is visible      id=q      10s
   input text     id=q      3 CLAVELES 10 LIMES CORINDON 11CM REF 80180
     Press Keys    id=q    ENTER
     sleep   2s
   wait until element is visible         css=div.table__container:nth-child(3) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(1)      10s
   click element       css=div.table__container:nth-child(3) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(1)

    Wait Until Element Is Visible    xpath=//table      10s
UC05 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table

UC05 - verify button télécharger en csv and print
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    wait until element is visible     xpath=//button[@data-testid="télécharger_en_csv"]
    wait until element is visible     xpath=//button[@data-testid="imprimer_"]

UC06 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau

    Page Should Contain    Date
    Page Should Contain   Créé le
    Page Should Contain    Gestionnaire
    Page Should Contain    Client
    Page Should Contain    Produit
    Page Should Contain     Quantité
    Page Should Contain      PPV
    Page Should Contain     Prix d'origine
    Page Should Contain     Prix unitaire
    Page Should Contain     Disponible





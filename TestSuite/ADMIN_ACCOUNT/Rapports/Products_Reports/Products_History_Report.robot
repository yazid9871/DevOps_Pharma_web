
*** Settings ***
Documentation     Tests fonctionnels de la page " Rapport historique produits"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapport historique produits

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}    Rapport historique produits
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
   [Documentation]    Vérifier affichage du rapport
      Accéder à la page     reports/productshistory
    wait until page contains    ${TITRE_PAGE}    10s


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
UC03 choise Fournisseur
    [Documentation]
     sleep    2s
      Click Element    xpath=//input[@id='supplier_id']
      Input Text       xpath=//input[@id='supplier_id']    sobrus
      Press Keys       xpath=//input[@id='supplier_id']    ENTER
       Press Keys       xpath=//input[@id='supplier_id']    ENTER
      sleep     2s
    Wait Until Element Is Visible    xpath=//table

UC03 -choise type
    [Documentation]
   click element     id=type
   wait until element is visible    css=.sob-v2-select__value-container--has-value > div:nth-child(2)
   click element      css=.sob-v2-select__option:nth-child(1)
    Wait Until Element Is Visible    xpath=//table
UC02 - Filtrer par période
    [Documentation]    Vérifier filtre par date
    Input Text     id=start_date     ${DATE_START}
    Input Text    id=end_date       ${DATE_END}
    Wait Until Element Is Visible    css=.sob-v2-table

UC03 - Vérifier affichage des cards
    [Documentation]    Vérifier des cards
     sleep    2s
    Page Should Contain    Vente
    Page Should Contain     Retour sur vente
     Page Should Contain    Bon de Livraison
    Page Should Contain     Avoirs fournisseurs émis
    Page Should Contain    Avoir fournisseur reçu
    Page Should Contain     Sortie confrère
     Page Should Contain    Entrée confrère
    Page Should Contain     Ajustement du stock
     Page Should Contain    Inventaire
    Page Should Contain     Préparation

    ${value}=    Get Text    css=div.RapportCard:nth-child(1) > div:nth-child(2)
    Should Not Be Empty    ${value}
     ${value2}=    Get Text    css=div.RapportCard:nth-child(2) > div:nth-child(2)
    Should Not Be Empty    ${value2}
     ${value3}=    Get Text    css=div.RapportCard:nth-child(3) > div:nth-child(2)
    Should Not Be Empty    ${value3}
     ${value4}=    Get Text    css=div.RapportCard:nth-child(4) > div:nth-child(2)
    Should Not Be Empty    ${value4}
     ${value5}=    Get Text    css=div.RapportCard:nth-child(5) > div:nth-child(2)
    Should Not Be Empty    ${value5}
     ${value6}=    Get Text    css=div.RapportCard:nth-child(6) > div:nth-child(2)
    Should Not Be Empty    ${value6}
    ${value7}=    Get Text    css=div.RapportCard:nth-child(7) > div:nth-child(2)
    Should Not Be Empty    ${value7}
     ${value8}=    Get Text    css=div.RapportCard:nth-child(8) > div:nth-child(2)
    Should Not Be Empty    ${value8}
     ${value9}=    Get Text    css=div.RapportCard:nth-child(9) > div:nth-child(2)
    Should Not Be Empty    ${value9}
     ${value10}=    Get Text    css=div.RapportCard:nth-child(10) > div:nth-child(2)
    Should Not Be Empty    ${value10}


UC05 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table


UC06 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
     Page Should Contain    Date
    Page Should Contain     Produit
    Page Should Contain    PPV
    Page Should Contain    Type
    Page Should Contain    Quantité
    Page Should Contain    Stock après transaction
    Page Should Contain    Disponible



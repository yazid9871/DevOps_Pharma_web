
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Produits proches périmés "
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports Produits proches périmés

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${TITRE_PAGE}     Produits proches périmés
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page  reports/productsexpiringsoon
    wait until page contains    ${TITRE_PAGE}    10s




UC02 - Filtrer par période
    wait until element is visible      id=period
   click element     id=period
   wait until element is visible    css=div.sob-v2-select-container:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)
   click element      css=.sob-v2-select__option:nth-child(2)
    Wait Until Element Is Visible    xpath=//table



UC05 - Rafraîchir les données
    [Documentation]    Vérifier bouton refresh
    Click Button     ${refresh}
    Wait Until Element Is Visible    xpath=//table

UC05 - Vérifier bouton imprimer
    [Documentation]    Vérifier bouton imprimer
    wait until element is visible      xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/div[2]/button
    Click Button         xpath=/html/body/div[1]/div/div[4]/div/div[2]/div[1]/div[2]/button

UC06 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
     #Paiement par client
     Page Should Contain    Nom
    Page Should Contain    PPV
    Page Should Contain    Disponible
    Page Should Contain    Date de péremption
    Page Should Contain    Jours restants




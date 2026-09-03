
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Nouveaux produits"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports  Nouveaux produits

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${DATE_START}       01/03/2026
${DATE_END}         31/03/2026
${TITRE_PAGE}     Nouveaux produits
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
   [Documentation]    Vérifier affichage du rapport
      Accéder à la page     reports/productsaddedrecently
    wait until page contains    ${TITRE_PAGE}    10s





UC06 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
     Page Should Contain    Nom
    Page Should Contain    PPV
    Page Should Contain   PPH
    Page Should Contain    Catégorie
    Page Should Contain    Forme galénique
    Page Should Contain    Créé le




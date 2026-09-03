
*** Settings ***
Resource   ../../../../../Resources/Auth.robot
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${TITRE_PAGE}     Produit au stock zéro (0)
${refresh}      css=.sob-v2-btn-tertiary
*** Test Cases ***

UC01 - Consulter le rapport
    [Documentation]    Vérifier affichage du rapport
     Open Browser  ${BASE_URL}  Firefox
      Login With Valid Credentials compt2
    Go To    ${BASE_URL}/reports/stockempty
    wait until page contains    ${TITRE_PAGE}    10s
    Page Should Contain Element     css=.sob-v2-table     10s






UC05 - Vérifier affichage colonnes
    [Documentation]    Vérifier colonnes du tableau
     Execute JavaScript    document.body.style.zoom="50%"
     sleep    2s
    Page Should Contain    Produit



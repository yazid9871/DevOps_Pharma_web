*** Settings ***
Documentation     Suite de tests fonctionnels pour la page "Changer mon code de sécurité"
Library           SeleniumLibrary
Resource  ../../../Resources/Auth.robot
Suite Setup       Ouvrir Navigateur Et Se Connecter
Suite Teardown    Close All Browsers

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}    meryem.e1@sobrus.com
${PASSWORD}     qw067012@


*** Keywords ***
Ouvrir Navigateur Et Se Connecter
    [Documentation]    Ouvre le navigateur, se connecte à l'application
     Open Browser  ${BASE_URL}  Firefox
    Login With Valid Credentials compt2
    Go To    ${BASE_URL}//settings?view=theme-preferences
    wait until page contains    Changer mon code de sécurité


*** Test Cases ***
TC01 - Vérifier Le Chargement De La Page
    [Documentation]    Vérifie que la page "Changer mon code de sécurité" s'affiche avec tous les champs attendus
    [Tags]    smoke    securite
    Page Should Contain Element    ${INPUT_MOT_DE_PASSE}
    Page Should Contain Element    ${INPUT_NOUVEAU_CODE}
    Page Should Contain Element    ${INPUT_CONFIRMATION_CODE}

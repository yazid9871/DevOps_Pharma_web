
*** Settings ***
Documentation     Tests fonctionnels de la page "Changer mon code de sécurité"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags      Changer mon code de sécurité


*** Variables ***


${INPUT_EMAIL}                id=email
${INPUT_PASSWORD}             id=password
${BTN_LOGIN}                  id=login-button


${INPUT_MOT_DE_PASSE}        id=password
${INPUT_NOUVEAU_CODE}        id=security_code
${INPUT_CONFIRMATION_CODE}   id=security_code_confirm

${BTN_EYE_MOT_DE_PASSE}      css=div.sob-v2-form-group:nth-child(1) > div:nth-child(2) > svg:nth-child(2)
${BTN_EYE_NOUVEAU_CODE}       css=div.sob-v2-form-group:nth-child(2) > div:nth-child(2) > svg:nth-child(2)
${BTN_EYE_CONFIRMATION}      css=div.sob-v2-form-group:nth-child(3) > div:nth-child(2) > svg:nth-child(2)

${BTN_ENREGISTRER}            xpath=//*[@data-testid="sauvegarder"]

${MSG_CODES_NON_IDENTIQUES}   xpath=//*[contains(text(),"ne correspond") or contains(text(),"identiques")]


*** Keywords ***
Ouvrir Navigateur Et Se Connecter
    [Documentation]    Ouvre le navigateur, se connecte à l'application
    Accéder à la page    settings?view=change-security-code
    wait until page contains    Changer mon code de sécurité


Fermer Le Toast
    [Arguments]    ${locator}=xpath=//div[@class="sob-v2-toastr__close"]
    ${element}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

*** Test Cases ***
TC01 - Vérifier Le Chargement De La Page
    [Documentation]    Vérifie que la page "Changer mon code de sécurité" s'affiche avec tous les champs attendus
    [Tags]    smoke    securite
    Page Should Contain Element    ${INPUT_MOT_DE_PASSE}
    Page Should Contain Element    ${INPUT_NOUVEAU_CODE}
    Page Should Contain Element    ${INPUT_CONFIRMATION_CODE}

TC02 - Vérifier Les Champs Obligatoires (Formulaire Vide)
    [Documentation]    Vérifie qu'une erreur s'affiche si on soumet le formulaire vide
    [Tags]    validation    negatif
    Click Element    ${BTN_ENREGISTRER}
     wait until page contains     Ce champ est requis     10s

TC03 - Vérifier L'Erreur Si Le Mot De Passe Actuel Est Incorrect
    [Documentation]    Vérifie qu'un message d'erreur s'affiche si le mot de passe actuel est invalide
    [Tags]    validation    negatif    securite
    Input Text    ${INPUT_MOT_DE_PASSE}          123409
    Input Text    ${INPUT_NOUVEAU_CODE}          qw067012@
    Input Text    ${INPUT_CONFIRMATION_CODE}      qw067012@
    Click Element    ${BTN_ENREGISTRER}
     wait until page contains    Mot de passe incorrect.    10s
     #ferme toast
    Fermer Le Toast
     sleep    3s

TC04 - Vérifier L'Erreur Si Les Codes Ne Correspondent Pas
    [Documentation]    Vérifie qu'un message d'erreur s'affiche si le nouveau code et la confirmation diffèrent
    [Tags]    validation    negatif
    Input Text    ${INPUT_MOT_DE_PASSE}          ${PASSWORD}
    Input Text    ${INPUT_NOUVEAU_CODE}          qw067012@
    Input Text    ${INPUT_CONFIRMATION_CODE}     654321
    Click Element    ${BTN_ENREGISTRER}
       wait until page contains    Votre champ n'est pas identique     10s

TC05 - Vérifier L'Affichage/Masquage Du Mot De Passe (Icône Œil)
    [Documentation]    Vérifie que le champ mot de passe bascule entre masqué et visible via l'icône œil
    [Tags]    ui    securite
    Input Text    ${INPUT_MOT_DE_PASSE}    MonMotDePasse123
    Element Attribute Value Should Be    ${INPUT_MOT_DE_PASSE}    type    password
    Click Element    ${BTN_EYE_MOT_DE_PASSE}
    Element Attribute Value Should Be    ${INPUT_MOT_DE_PASSE}    type    text
    Click Element    ${BTN_EYE_MOT_DE_PASSE}
    Element Attribute Value Should Be    ${INPUT_MOT_DE_PASSE}    type    password

TC06 - Vérifier La Mise À Jour Réussie Du Code De Sécurité
    [Documentation]    Vérifie qu'un message de succès s'affiche après une mise à jour valide du code de sécurité
    [Tags]    positif    critique    securite
    Input Text    ${INPUT_MOT_DE_PASSE}          ${PASSWORD}
    Input Text    ${INPUT_NOUVEAU_CODE}          qw067012@
    Input Text    ${INPUT_CONFIRMATION_CODE}     qw067012@
    Click Element    ${BTN_ENREGISTRER}
    wait until page contains    otre code de sécurité a été mis à jour    10s

TC07 - Vérifier Que Le Nouveau Code Est Différent De L'Ancien
    [Documentation]    Vérifie qu'une erreur s'affiche si le nouveau code de sécurité est identique à l'ancien
    [Tags]    validation    negatif
          wait until page contains    otre code de sécurité a été mis à jour    10s


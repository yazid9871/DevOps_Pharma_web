
*** Settings ***
Documentation     Tests fonctionnels de la page "Paramètres d'affichage"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags     Paramètres d'affichage


*** Variables ***

${TITLE_PAGE}                 xpath=//h1[contains(text(),"Thème et préférences")] | xpath=//*[contains(text(),"Paramètres d'affichage")]

${SLIDER_TAILLE}              css=.slider
${LABEL_PETIT}                css=._0
${LABEL_PAR_DEFAUT}           xpath=//*[text()="Par défaut"]
${LABEL_GRAND}                xpath=//*[text()="Grand"]

${DROPDOWN_THEME}             xpath=//div[contains(@class,"select") and contains(.,"Pharma Classique")] | xpath=//select[contains(@id,"theme")]
${OPTION_PHARMA_CLASSIQUE}    xpath=//*[text()="Pharma Classique"]
${OPTION_PHARMA_SOMBRE}       xpath=//*[text()="Pharma Sombre"]
${OPTION_PHARMA_CLAIRE}       xpath=//*[text()="Pharma Claire"]

*** Keywords ***
Ouvrir Navigateur Et Se Connecter
    [Documentation]    Ouvre le navigateur, se connecte à l'application et navigue vers la page Thème et préférences
    Accéder à la page     settings?view=theme-preferences
    Wait Until Page Contains    Thème et préférences

*** Test Cases ***
TC01 - Vérifier Le Chargement De La Page
    [Documentation]    Vérifie que la page "Thème et préférences" s'affiche avec tous les éléments attendus
    [Tags]    smoke    preferences
    Page Should Contain Element    ${TITLE_PAGE}
    Page Should Contain Element    ${SLIDER_TAILLE}
    Page Should Contain Element    ${DROPDOWN_THEME}

TC02 - Vérifier La Présence Des Labels Du Curseur De Taille
    [Documentation]    Vérifie que les labels Petit, Par défaut et Grand sont bien affichés autour du curseur
    [Tags]    taille
    Page Should Contain Element    ${LABEL_PETIT}
    Page Should Contain Element    ${LABEL_PAR_DEFAUT}
    Page Should Contain Element    ${LABEL_GRAND}

TC03 - Vérifier La Valeur Par Défaut Du Curseur De Taille
    [Documentation]    Vérifie que le curseur de taille est positionné sur "Par défaut" à l'ouverture de la page
    [Tags]    taille    defaut
    ${valeur}=    Get Element Attribute    ${SLIDER_TAILLE}    value
    Should Be Equal As Strings    ${valeur}    2

TC04 - Vérifier Le Changement De Taille Vers Petit
    [Documentation]    Vérifie qu'on peut déplacer le curseur vers la position "Petit"
    [Tags]    taille    positif
    Click Element    ${LABEL_PETIT}
    ${valeur}=    Get Element Attribute    ${SLIDER_TAILLE}    value
    Should Be Equal As Strings    ${valeur}    1

TC05 - Vérifier Le Changement De Taille Vers Grand
    [Documentation]    Vérifie qu'on peut déplacer le curseur vers la position "Grand"
    [Tags]    taille    positif
    Click Element    ${LABEL_GRAND}
    ${valeur}=    Get Element Attribute    ${SLIDER_TAILLE}    value
    Should Be Equal As Strings    ${valeur}    3

TC06 - Vérifier L'Application Visuelle Du Changement De Taille
    [Documentation]    Vérifie que la taille de police de l'application change réellement après modification du curseur
    [Tags]    taille    visuel
    ${taille_avant}=    Execute Javascript    return window.getComputedStyle(document.body).fontSize;
    Click Element    ${LABEL_GRAND}
    Sleep    0.5s
    ${taille_apres}=    Execute Javascript    return window.getComputedStyle(document.body).fontSize;
    Should Not Be Equal    ${taille_avant}    ${taille_apres}

TC07 - Vérifier La Valeur Par Défaut Du Thème
    [Documentation]    Vérifie que le thème sélectionné par défaut est "Pharma Classique"
    [Tags]    theme    defaut
    Element Should Contain    ${DROPDOWN_THEME}    Pharma Classique

TC08 - Vérifier L'Ouverture Du Menu Déroulant Des Thèmes
    [Documentation]    Vérifie que le clic sur le dropdown affiche bien les 3 options de thème
    [Tags]    theme    ui
    Click Element    ${DROPDOWN_THEME}
    Wait Until Element Is Visible    ${OPTION_PHARMA_CLASSIQUE}    timeout=5s
    Page Should Contain Element    ${OPTION_PHARMA_SOMBRE}
    Page Should Contain Element    ${OPTION_PHARMA_CLAIRE}

TC09 - Vérifier La Sélection Du Thème Pharma Sombre
    [Documentation]    Vérifie qu'on peut sélectionner le thème "Pharma Sombre" et qu'il s'applique
    [Tags]    theme    positif    critique
    Click Element    ${DROPDOWN_THEME}
    Wait Until Element Is Visible    ${OPTION_PHARMA_SOMBRE}    timeout=5s
    Click Element    ${OPTION_PHARMA_SOMBRE}
    Wait Until Element Contains    ${DROPDOWN_THEME}    Pharma Sombre    timeout=5s

TC10 - Vérifier La Sélection Du Thème Pharma Claire
    [Documentation]    Vérifie qu'on peut sélectionner le thème "Pharma Claire" et qu'il s'applique
    [Tags]    theme    positif
    Click Element    ${DROPDOWN_THEME}
    Wait Until Element Is Visible    ${OPTION_PHARMA_CLAIRE}    timeout=5s
    Click Element    ${OPTION_PHARMA_CLAIRE}
    Wait Until Element Contains    ${DROPDOWN_THEME}    Pharma Claire    timeout=5s

TC11 - Vérifier La Persistance Du Thème Après Rechargement De Page
    [Documentation]    Vérifie que le thème choisi reste appliqué après un rafraîchissement de la page
    [Tags]    theme    persistance
    Click Element    ${DROPDOWN_THEME}
    Wait Until Element Is Visible    ${OPTION_PHARMA_SOMBRE}    timeout=5s
    Click Element    ${OPTION_PHARMA_SOMBRE}
    Wait Until Element Contains    ${DROPDOWN_THEME}    Pharma Sombre    timeout=5s
    Reload Page
    Wait Until Page Contains    Thème et préférences    timeout=10s
    Element Should Contain    ${DROPDOWN_THEME}    Pharma Sombre

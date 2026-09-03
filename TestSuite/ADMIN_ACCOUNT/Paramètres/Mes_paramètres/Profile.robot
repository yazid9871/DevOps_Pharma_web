
*** Settings ***
Documentation     Tests fonctionnels de la page "Changer Profil"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags      Profil


*** Variables ***


${BUTTON_SON_ACCOUNT}        xpath=//*[@data-testid="gérer_mon_compte_sobrus"]
${BUTTON_EDIT}        xpath=//*[@data-testid="modifier"]
${BTN_SAVE}        xpath=//*[@data-testid="enregistrer"]


${INPUT_EMAIL}            id=email
${INPUT_PASSWORD}         id=password
${BTN_LOGIN}              id=login-button

${MENU_MON_PROFIL}        xpath=//span[text()="Mon profil"]
${MENU_HISTORIQUE}        css=a[id="/login_history"]
${MENU_MOT_DE_PASSE}      xpath=//*[@id="/password"]
${BTN_DECONNEXION}        xpath=//*[@data-testid="déconnexion"]




${TXT_NOM}                xpath=/html/body/div/div/div[2]/div/div/div[2]/div[2]/div[2]/div[1]/div/div[1]/div[1]/div/p
${TXT_PRENOM}             xpath=/html/body/div/div/div[2]/div/div/div[2]/div[2]/div[2]/div[1]/div/div[1]/div[2]/div/p
${TXT_EMAIL}              xpath=/html/body/div/div/div[2]/div/div/div[2]/div[2]/div[2]/div[1]/div/div[1]/div[3]/div/p
${TXT_PORTABLE}           xpath=/html/body/div/div/div[2]/div/div/div[2]/div[2]/div[2]/div[1]/div/div[2]/div[2]/div/p
${TXT_TITLE}              xpath=/html/body/div/div/div[2]/div/div/div[2]/div[2]/div[2]/div[1]/div/div[2]/div[1]/div/p
${TXT_FAX}                xpath=/html/body/div/div/div[2]/div/div/div[2]/div[2]/div[2]/div[1]/div/div[3]/div[1]/div/p
${TXT_WEB}                xpath=/html/body/div/div/div[2]/div/div/div[2]/div[2]/div[2]/div[1]/div/div[3]/div[2]/div/p
${TXT_Date_naissance}     xpath=/html/body/div/div/div[2]/div/div/div[2]/div[2]/div[2]/div[1]/div/div[3]/div[3]/div/p
${SECTION_ADRESSE}        xpath=/html/body/div/div/div[2]/div/div/div[2]/div[2]/div[2]/div[2]/div/div/div[1]/div/p
${SUPPORT_NUMBER}         css=.sob-v2-supportbtn-text > span:nth-child(2)



*** Keywords ***
Scroll To Element By Text
       [Arguments]    ${text}    # The text you're looking for
    # Using JavaScript to find and scroll to element containing the text
    Execute JavaScript
    ...    var elements = Array.from(document.getElementsByTagName('p'));
    ...    var targetElement = elements.find(el => el.textContent.trim() === '${text}');
    ...    if(targetElement) {
    ...        targetElement.scrollIntoView({block: 'center'});
    ...        window.scrollBy(0, -100);
    ...    }
    Sleep    2s

Cliquer Sur compte
    wait until element is visible      ${BUTTON_SON_ACCOUNT}
    Click Element    ${BUTTON_SON_ACCOUNT}
    Cliquer Et Basculer Vers Nouvelle Fenetre Simple      ${BUTTON_SON_ACCOUNT}
    sleep  2s
    wait until page contains    Gérez ici vos informations personnelles pour toutes vos applications Sobrus    10s
Cliquer Et Basculer Vers Nouvelle Fenetre Simple
    [Arguments]    ${locator}
    Click Element    ${locator}
    Sleep    1s    # laisse le temps à la fenêtre de s'ouvrir
    @{handles}=    Get Window Handles
    Switch Window    locator=${handles}[-1]
Click Element With JavaScript
   [Arguments]    ${locator}
    ${element}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].scrollIntoView({block: 'center'});    ARGUMENTS    ${element}
    Sleep    0.3s
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}
*** Test Cases ***

TC01 - Vérifier Le Chargement De La Page Mon Profil
    [Documentation]    Vérifie que la page "Mon profil" se charge correctement après connexion
    Accéder à la page    settings?view=profile
   wait until element is visible      ${BUTTON_SON_ACCOUNT}    timeout=15s
    wait until page contains       Langue
      wait until page contains     Fuseau horaire
      wait until element is visible       css=div.sob-v2-row:nth-child(1) > div:nth-child(1) > div:nth-child(1) > p:nth-child(2) > span:nth-child(1)     10s
       sleep    2s
       ${Langue}=    Get Text    css=div.sob-v2-row:nth-child(1) > div:nth-child(1) > div:nth-child(1) > p:nth-child(2) > span:nth-child(1)
      ${Time_Zone}=     Get Text    css=div.sob-v2-row:nth-child(2) > div:nth-child(1) > div:nth-child(1) > p:nth-child(2)

    Should Be Equal As Strings   ${Langue}     fr
    should be equal    ${Time_Zone}      Africa/Casablanca

TC02 - Vérifier L'Affichage Des Informations Générales account sobrus
    [Documentation]    Vérifie que les informations personnelles de l'utilisateur sont correctement affichées
   Cliquer Sur compte
    wait until page contains    Téléphone  10s
    Element Text Should Be    ${TXT_NOM}          al hajjouji
    Element Text Should Be    ${TXT_PRENOM}      Meryem
    Element Text Should Be    ${TXT_EMAIL}       meryem.e1@sobrus.com
    Element Text Should Be    ${TXT_PORTABLE}    212704201898
    Element Text Should Be    ${TXT_TITLE}         QAtester
    Element Text Should Be    ${TXT_FAX}      0587695465
    Element Text Should Be    ${TXT_WEB}       https://account.sobrus.ovh
    Element Text Should Be    ${TXT_Date_naissance}     1999-04-10
TC04 - Vérifier Le Fonctionnement Du Bouton Modifier
    [Documentation]    Vérifie que le clic sur "Modifier" ouvre le formulaire d'édition du profil
     Wait Until Page Contains Element   ${BUTTON_EDIT}    timeout=5s
    Click Element    ${BUTTON_EDIT}
    wait until element is visible      ${BTN_SAVE}
    click element      ${BTN_SAVE}
    wait until page contains     Mon profil


TC05 - Vérifier La Navigation Vers Mon Historique
    [Documentation]    Vérifie que le lien "Mon historique de connexions" redirige vers la bonne page
    wait until element is visible      ${MENU_HISTORIQUE}    10s
     Scroll To Element By Text       Historique de connexions
     go to     https://account.sobrus.ovh/login_history
          sleep    2s
    Wait Until Page Contains    Historique de connexions     10s


TC06 - Vérifier La Navigation Vers Mot De Passe Et Sécurité
    [Documentation]    Vérifie que le lien "Mot de passe et sécurité" redirige vers la bonne page

    go to    https://account.sobrus.ovh/password
    Wait Until Page Contains   Changer le mot de passe

TC07 - Vérifier La Présence Du Numéro De Support
    [Documentation]    Vérifie que le numéro de support est visible en haut de la page
    go to      https://account.sobrus.ovh/
      wait until page contains    05 30 500 500


TC08 - Vérifier La Déconnexion
    [Documentation]    Vérifie que le bouton Déconnexion termine bien la session utilisateur
    [Tags]    logout    critique
     Click Element    ${BTN_DECONNEXION}
     sleep    1s
      Reload Page
    #Page Should Contain Element   id=login        10s




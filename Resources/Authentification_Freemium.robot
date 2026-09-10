*** Settings ***
Documentation     Tests fonctionnels de connexion (authentification)
Library           SeleniumLibrary
Resource          Variables.robot


*** Variables ***
${USERNAME}   ser.e@sobrus.com
${PASSWORD}     qwqwqw12@

*** Keywords ***
Ouvrir Le Navigateur Se Connecter
    [Documentation]     la connexion complète avec l'étape de validation télé (écran "Passer")
     Ouvrir Le Navigateur
      sleep     1s
     Wait Until Element Is Visible    css:button[type="submit"]     timeout=15s
     Click Button  css:button[type="submit"]
      Wait Until Element Is Visible     xpath=//input[@id='login']     timeout=5s
     Input Text  xpath=//input[@id='login']   ${USERNAME}
     Click Button  css:button[type="submit"]
     Wait Until Element Is Visible    css:input[name="password"]    timeout=5s
     input password    css:input[name="password"]  ${PASSWORD}
     Click Button  css:button[type="submit"]
      wait until page contains    Fil d'actualité  timeout=5s



Ouvrir Le Navigateur
    [Documentation]    Ouvre le navigateur sur l'application avant chaque suite
    Open Browser    ${BASE_URL}    Firefox

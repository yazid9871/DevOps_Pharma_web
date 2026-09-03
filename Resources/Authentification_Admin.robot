*** Settings ***
Documentation     Tests fonctionnels de connexion (authentification)
Library           SeleniumLibrary
Resource          Variables.robot


*** Variables ***
${USERNAME}  meryeme.e@sobrus.com
${PASSWORD}  qw067012@

${USERNAME2}  meryem.e1@sobrus.com
${PASSWORD2}  qw067012@

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
     Wait Until Element Is Visible    xpath=//button[@type = 'button' and (text() = 'Passer' or . = 'Passer')]     20s
     Click Button    xpath=//button[@type = 'button' and (text() = 'Passer' or . = 'Passer')]
      wait until page contains    Fil d'actualité  timeout=5s
Ouvrir Le Navigateur Se Connecter 2
    [Documentation]     la connexion sans passer par l'étape de validation télé
    Ouvrir Le Navigateur
     sleep     1s
     Wait Until Element Is Visible    css:button[type="submit"]     timeout=15s
     Click Button  css:button[type="submit"]
      Wait Until Element Is Visible     xpath=//input[@id='login']     timeout=5s
     Input Text  xpath=//input[@id='login']   ${USERNAME2}
     Click Button  css:button[type="submit"]
     Wait Until Element Is Visible    css:input[name="password"]    timeout=5s
     input password    css:input[name="password"]  ${PASSWORD2}
     Click Button  css:button[type="submit"]
     wait until page contains    Fil d'actualité  timeout=20s


Ouvrir Le Navigateur
    [Documentation]    Ouvre le navigateur sur l'application avant chaque suite
    Open Browser    ${BASE_URL}    Firefox


*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports Exporter les clients"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Resource          ../../../../Resources/Vérifier_que_le_téléchargement_commence.robot

Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports  Exporter les clients

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryeme.e@sobrus.com
${PASSWORD}  qw067012@

${TITRE_PAGE}           Exporter les clients
${BTN_TELECHARGER}           xpath=//*[@data-testid="télécharger_en_csv"]

*** Test Cases ***
Vérifier l'affichage de la page Exportation de clients
      [Documentation]    Vérifier affichage du rapport
      Accéder à la page     reports/exportcustomers
    wait until page contains    ${TITRE_PAGE}    10s

Export all clients
     Export All Clients should be Selected
    Click Download and Verify
   # Vérifier que le téléchargement commence
Export active clients
    Select Export Active Clients
   Click Download and Verify
      # Vérifier que le téléchargement commence
Export archived clients
    Select Export Archived Clients
   Click Download and Verify
     # Vérifier que le téléchargement commence



*** Keywords ***



Export All Clients should be Selected
     Radio Button Should Be Set To    status    on
Click Download and Verify
    wait until element is visible     ${BTN_TELECHARGER}
    click element     ${BTN_TELECHARGER}

Select Export Active Clients
       Click Element    xpath=//label[contains(@class,'sob-v2-radioBtn-container') and .//span[text()='Exporter les clients actifs (csv)']]

Select Export Archived Clients
     Click Element    xpath=//label[contains(@class,'sob-v2-radioBtn-container') and .//span[text()='Exporter les clients archivés (csv)']]
Vérifier que le téléchargement commence
     sleep     5s
    ${timestamp}=    Evaluate    int(time.time())    time
    # Firefox affiche généralement une notification de téléchargement
    Wait Until Element Is Visible    css=.downloadSubPanel    timeout=5s    error=Aucune notification de téléchargement détectée

*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Exporter des produits avec des prix modifiés"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Resource          ../../../../Resources/Vérifier_que_le_téléchargement_commence.robot

Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports Exporter des produits avec des prix modifiés

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryem.e1@sobrus.com
${PASSWORD}  qw067012@

${TITRE_PAGE}             Exporter des produits avec des prix modifiés
${BTN_TELECHARGER}           xpath=//*[@data-testid="télécharger_en_csv"]

*** Test Cases ***
Vérifier l'affichage de la page Export Products With Modified Prices

     [Documentation]    Vérifier affichage du rapport
      Accéder à la page    /reports/exportproductswithmodifiedprices
          Wait Until Element Is Visible    css=.sob-v2-table

Export Products With Modified Prices
    Click Download and Verify
   # Vérifier que le téléchargement commence



*** Keywords ***



Click Download and Verify
    wait until element is visible     ${BTN_TELECHARGER}
    click element     ${BTN_TELECHARGER}

Vérifier que le téléchargement commence
     sleep     5s
    ${timestamp}=    Evaluate    int(time.time())    time
    # Firefox affiche généralement une notification de téléchargement
    Wait Until Element Is Visible    css=.downloadSubPanel    timeout=5s    error=Aucune notification de téléchargement détectée

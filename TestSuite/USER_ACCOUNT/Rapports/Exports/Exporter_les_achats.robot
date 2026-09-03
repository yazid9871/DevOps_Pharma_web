
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Exporter les achats"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports  Exporter les achats

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryeme.e@sobrus.com
${PASSWORD}  qw067012@

${TITRE_PAGE}            Exporter les achats
${start_date}          id=start_date
${end_date}            id=end_date
*** Test Cases ***
Vérifier l'affichage de la page Exportation de stock
      [Documentation]    Vérifier affichage du rapport
      Accéder à la page  reports/exportpurchases
    wait until page contains    ${TITRE_PAGE}    10s
change period et Téléchargement CSV
     Vérifier la présence des éléments de formulaire
     change period
     Téléchargement CSV



*** Keywords ***



Vérifier la présence des éléments de formulaire
    Element Should Be Visible    ${start_date}
    Element Should Be Visible    ${end_date}

change period
     Click Element    ${start_date}
    Wait Until Element Is Visible  css=div.sob-v2-col:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1)        10s
      sleep    1s
     click element    css=.react-datepicker__day--012

      Click Element    ${end_date}
    Wait Until Element Is Visible  css=div.sob-v2-col:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1)        10s
      sleep    1s
     click element    css=.react-datepicker__day--014
Téléchargement CSV
         click element     xpath=//*[@data-testid="télécharger_en_csv"]

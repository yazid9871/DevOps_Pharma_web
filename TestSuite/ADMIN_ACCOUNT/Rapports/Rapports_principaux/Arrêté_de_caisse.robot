*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports  Arrêté de caisse"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Resource        ../../../../Resources/Vérifier_que_le_téléchargement_commence.robot

Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags       Rapports Arrêté de caisse

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryeme.e@sobrus.com
${PASSWORD}  qw067012@

${TITRE_PAGE}               Arrêté de caisse
${CHAMP_DATE_DEBUT}          id=start_date
${CHAMP_DATE_FIN}            id=end_date
${CASE_REGROUPER}            id=by_day
${CASE_VERSION_AVANCEE}      id=advanced
${BTN_TELECHARGER}           xpath=//*[@data-testid="télécharger"]
${date_DROPDOWN}      css=.react-datepicker

*** Test Cases ***
Vérifier l'affichage de la page d'arrêté de caisse
    [Documentation]    Vérifier affichage du rapport
      Accéder à la page  reports/customersmain
    wait until page contains    ${TITRE_PAGE}    10s

    Go To Arrêté de caisse Listing Page
    Vérifier la présence des éléments de formulaire


Générer un rapport d'arrêté de caisse standard
    Saisir une période
    Cliquer sur télécharger
    Vérifier que le téléchargement commence

Générer un rapport d'arrêté de caisse avec regroupement par jour
    choisir un période
    Desactiver l'option regrouper par jour
    Cliquer sur télécharger
    Vérifier que le téléchargement commence


Générer un rapport d'arrêté de caisse en version avancée
    Saisir une période
    Desactiver l'option version avancée
    Cliquer sur télécharger
    Vérifier que le téléchargement commence








*** Keywords ***
Go To Arrêté de caisse Listing Page
    [Documentation]
    Go To    ${BASE_URL}/reports/cashdeskclosing
    wait until page contains    ${TITRE_PAGE}    10s


Vérifier la présence des éléments de formulaire
    Element Should Be Visible    ${CHAMP_DATE_DEBUT}
    Element Should Be Visible    ${CHAMP_DATE_FIN}
    Element Should Be Visible    ${CASE_REGROUPER}
    Element Should Be Visible    ${CASE_VERSION_AVANCEE}
    Element Should Be Visible    ${BTN_TELECHARGER}

Saisir une période
    Clear Element Text    ${CHAMP_DATE_DEBUT}
    Input Text    ${CHAMP_DATE_DEBUT}    24/02/2025
    Clear Element Text    ${CHAMP_DATE_FIN}
    Input Text    ${CHAMP_DATE_FIN}    24/04/2025
    #tous les checkbox selected
Desactiver l'option regrouper par jour
    unselect checkbox    ${CASE_REGROUPER}
Desactiver l'option version avancée
   unselect checkbox    ${CASE_VERSION_AVANCEE}


Cliquer sur télécharger
    Click Element    ${BTN_TELECHARGER}

choisir un période
    #date debut
    click element     ${CHAMP_DATE_DEBUT}
     Wait Until Element Is Visible  ${date_DROPDOWN}    10s
      click element    css:button.react-datepicker__navigation:nth-child(3)
     sleep    5s
     click element     css=.react-datepicker__day--006
    #date fin
       click element    ${CHAMP_DATE_FIN}
     Wait Until Element Is Visible  ${date_DROPDOWN}    10s
      click element    css:button.react-datepicker__navigation:nth-child(3)
     sleep    5s
     click element     css=.react-datepicker__day--020


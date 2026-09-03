
*** Settings ***
Documentation     Tests fonctionnels de la page "Rapports Exportation de stock"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Resource          ../../../../Resources/Vérifier_que_le_téléchargement_commence.robot

Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags       Rapports   Exportation de stock

*** Variables ***
${BASE_URL}   https://app.pharma.sobrus.ovh
${USERNAME}  meryeme.e@sobrus.com
${PASSWORD}  qw067012@

${TITRE_PAGE}              Exportation de stock
${CHAMP_DATE}          id=date
${CHAMP_classerpar}            id=sort
${CASE_ZONE}            id=zone_id
${CASE_Form}      id=product_galenic_form_id
${BTN_TELECHARGER}           xpath=//*[@data-testid="télécharger_en_csv"]
${date_DROPDOWN}      css=.react-datepicker
${FICHIER_ATTENDU}     test
*** Test Cases ***
Vérifier l'affichage de la page Exportation de stock
       Accéder à la page  reports/exportstock

Téléchargement CSV par défaut
     Vérifier la présence des éléments de formulaire
     verify checkboxs are selected
    #Téléchargement CSV par défaut
Filtrer par zone Forme galénique Classer par order et exporter
    Sélectionner Zone
    Sélectionner Forme Galenique
     Classer par order
Décocher Filtre Stock
    Seulement produits avec stock différent de zéro
    Décocher Décocher Filtre Stock







*** Keywords ***
Go ToExportation de stock Listing Page
    [Documentation]
    Go To    ${BASE_URL}/reports/exportstock
    wait until page contains    ${TITRE_PAGE}    10s


Vérifier la présence des éléments de formulaire
    Element Should Be Visible    ${CHAMP_DATE}
    Element Should Be Visible    ${CHAMP_classerpar}
    Element Should Be Visible    ${CASE_ZONE}
    Element Should Be Visible    ${CASE_FORM}
    Element Should Be Visible    ${BTN_TELECHARGER}

verify checkboxs are selected
    checkbox should be selected     id=as_csv
    checkbox should be selected     id=only_non_zero_stock
Téléchargement CSV par défaut
    click element     xpath=//*[@data-testid="télécharger_en_csv"]
Changer Date
    input text    id=date     24/03/2026
Sélectionner Zone
     Click Element   id=zone_id
     Wait Until Element Is Visible    css=.sob-v2-select-clearable > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)     10s
     click element     css=.sob-v2-select__option:nth-child(2)

Sélectionner Forme Galenique
      Click Element   id=product_galenic_form_id
      sleep    1s
     Wait Until Element Is Visible    css=div.sob-v2-row:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)    10s
    sleep    1s
     click element     css=.sob-v2-select__option:nth-child(2)

Classer par order
     Click Element   id=sort
     Wait Until Element Is Visible    css=div.sob-v2-row:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2)    10s
     click element     css=.sob-v2-select__option:nth-child(2)

Seulement produits avec stock différent de zéro
     unselect checkbox      id=only_non_zero_stock
     checkbox should not be selected       id=only_non_zero_stock
Décocher Décocher Filtre Stock
       unselect checkbox     id=as_csv
     checkbox should not be selected        id=as_csv
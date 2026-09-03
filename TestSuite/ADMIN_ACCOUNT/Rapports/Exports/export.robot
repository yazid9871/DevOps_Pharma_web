
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
   Vérifier que le fichier CSV est présent après le clic.

export un rapport de stock standard
    Cliquer sur télécharger
    Vérifier que le téléchargement commence

export un rapport de stock Seulement produits avec stock différent de zéro
   Saisir les info
    Decoche l'option Seulement produits avec stock différent de zéro
    Cliquer sur télécharger
    Vérifier que le téléchargement commence


export un rapport de stock standard sana Télécharger en CSV
    Desactiver l'option Télécharger en CSV
    Cliquer sur télécharger
    Vérifier que le téléchargement commence








*** Keywords ***



Vérifier la présence des éléments de formulaire
    Element Should Be Visible    ${CHAMP_DATE}
    Element Should Be Visible    ${CHAMP_classerpar}
    Element Should Be Visible    ${CASE_ZONE}
    Element Should Be Visible    ${CASE_FORM}
    Element Should Be Visible    ${BTN_TELECHARGER}

Saisir les info
    Clear Element Text    ${CHAMP_DATE}
    sleep     2s
    Input Text    ${CHAMP_DATE}    24/02/2025

Desactiver l'option Télécharger en CSV
    unselect checkbox   ps=as_csv
Decoche l'option Seulement produits avec stock différent de zéro
   unselect checkbox     id=only_non_zero_stock


Cliquer sur télécharger
    Click Element    ${BTN_TELECHARGER}


Vérifier que le fichier CSV est présent après le clic.
     Créer Dossier Téléchargement
    Configurer Firefox Pour Telechargement
      # Click Element    ${BTN_TELECHARGER}
    Sleep    15s
    File Should Exist    ${DOWNLOAD_DIR}Sobrus - Stock 20250630(2)


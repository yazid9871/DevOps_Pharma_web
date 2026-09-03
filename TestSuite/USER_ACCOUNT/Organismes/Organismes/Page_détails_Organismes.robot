*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Organismes"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Organismes

*** Variables ***
${PAYER_ID}      payer/49/table
${PAYER_NAME}    farouk test

*** Test Cases ***
Vérifier les sections (En-tête et Informations générales)
     Aller à la page détails Organismes
     Vérifier la section en-tête de l'Organisme
     Vérifier les informations générales de l'Organisme

Vérifier la section Historique des paiements
   Vérifier que la section est visible     Historique des paiements       id=##payersfinancial_transactions

Vérifier la section Ventes
      Vérifier que la section Ventes est visible

Vérifier la section Bordereaux d'envoi
      Vérifier que la section Bordereaux d'envoi est visible
    Cliquer sur "Créer" et vérifier que l'organisme sélectionné est correct

Vérifier la section Informations de traçabilité
  Vérifier que la section est visible     Informations de traçabilité       id=##payersaudit_info

Vérifier la section Commentaires
  Vérifier que la section est visible     Commentaires       id=##payerscomments

*** Keywords ***
Aller à la page détails Organismes
     [Documentation]    Navigue vers la page de détails de l'organisme après connexion.
     Go To     ${BASE_URL}/${PAYER_ID}

Vérifier la section en-tête de l'Organisme
     Wait Until Page Contains    ${PAYER_NAME}    timeout=10s

Vérifier les informations générales de l'Organisme
     Page Should Contain    Informations générales
     Page Should Contain    ${PAYER_NAME}
     Page Should Contain    Adresse
     Page Should Contain    Informations descriptives

Vérifier que la section Ventes est visible
     Faire défiler jusqu'à l'élément par texte    Ventes
     click element    id=##payersinvoices
     sleep    3s
     wait until page contains    Ventes
    Wait Until Element Is Visible       ${BOUTON_CREER_VENTE_ORGANISME}    10s

Vérifier que la section Bordereaux d'envoi est visible
     Faire défiler jusqu'à l'élément par texte    Bordereaux d\\'envoi
     click element    id=##payersdispatch_slips
     sleep    3s
     wait until page contains    Bordereaux d'envoi
    Wait Until Element Is Visible       ${BOUTON_CREER_BORDEREAU_ORGANISME}    10s

Cliquer sur "Créer" et vérifier que l'organisme sélectionné est correct
    click element    ${BOUTON_CREER_BORDEREAU_ORGANISME}
    wait until page contains    Créer un nouveau bordereau d'envoi
    wait until element is visible    id=payer_id    10s
    wait until page contains    ${PAYER_NAME}
    click element    xpath=//*[@data-testid="suivant"]
    wait until page contains    Sélectionnez une période    10s
    Go To    ${BASE_URL}/${PAYER_ID}

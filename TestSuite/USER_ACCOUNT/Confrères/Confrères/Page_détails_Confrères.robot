*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Confrères"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Confrères

*** Variables ***
${COLLEAGUE_ID}      colleague/8636
${COLLEAGUE_NAME}    test12


*** Test Cases ***
Vérifier les sections (En-tête et Informations générales)
     Aller à la page détails Confrères
     Vérifier la section en-tête du Confrère
     Vérifier les informations générales du Confrère

Vérifier la section Historique des produits
   Vérifier que la section est visible     Historique des produits       id=##colleaguestock_transactions

Vérifier la section Encaissements
      Vérifier que la section et le button creer sont visibles   Encaissements     id=##colleagueincoming_payments   Ajouter Encaissements    ${BOUTON_CREER_ENCAISSEMENT_CONFRERE}
    Go To    ${BASE_URL}/${COLLEAGUE_ID}

Vérifier la section Décaissements
      Vérifier que la section et le button creer sont visibles   Décaissements     id=##colleagueoutgoing_payments   Ajouter un paiement le    ${BOUTON_CREER_DECAISSEMENT_CONFRERE}
    Go To    ${BASE_URL}/${COLLEAGUE_ID}

Vérifier la section Sorties confrère
      Faire défiler jusqu'à l'élément par texte    Sorties confrère
      click element    id=##colleaguecolleague_sales
      sleep    3s
      Wait Until Element Is Visible    ${BOUTON_CREER_SORTIE_CONFRERE}    10s
    Cliquer sur "Créer" et vérifier que le confrère sélectionné est correct    ${BOUTON_CREER_SORTIE_CONFRERE}

Vérifier la section Entrées confrère
      Faire défiler jusqu'à l'élément par texte    Entrées confrère
      click element    id=##colleaguecolleague_purchases
      sleep    3s
      Wait Until Element Is Visible    ${BOUTON_CREER_ENTREE_CONFRERE}    10s
    Cliquer sur "Créer" et vérifier que le confrère sélectionné est correct    ${BOUTON_CREER_ENTREE_CONFRERE}

Vérifier la section Total par méthode d'échange
   Vérifier que la section est visible    Total par méthode d’échange     id=##colleaguetotal_by_pricing_field

Vérifier la section Informations de traçabilité
   Vérifier que la section est visible     Informations de traçabilité       id=##colleagueaudit_info

Vérifier la section Commentaires
   Vérifier que la section est visible     Commentaires       id=##colleaguecomments

Vérifier le bouton Archiver
    [Documentation]    Vérifie la présence du bouton Archiver sur la page Confrères
    Wait Until Element Is Visible    ${BOUTON_ARCHIVER_CONFRERE}    10s

Vérifier le bouton Modifier
    [Documentation]    Vérifie la présence du bouton Modifier sur la page Confrères
    Wait Until Element Is Visible    ${BOUTON_MODIFIER_CONFRERE}    10s

Vérifier le bouton Imprimer le relevé
    [Documentation]    Vérifie la présence du bouton Imprimer le relevé sur la page Confrères
    Wait Until Element Is Visible    ${BOUTON_IMPRIMER_RELEVE_CONFRERE}    10s


*** Keywords ***
Aller à la page détails Confrères
    [Documentation]    Navigue vers la page de détails du confrère après connexion.
    Go To     ${BASE_URL}/${COLLEAGUE_ID}

Vérifier la section en-tête du Confrère
    Wait Until Page Contains    ${COLLEAGUE_NAME}    timeout=10s
    Wait Until Page Contains    Actif    10s

Vérifier les informations générales du Confrère
    Page Should Contain    Informations générales
    Page Should Contain    Adresse
    Page Should Contain    Informations descriptives

Cliquer sur "Créer" et vérifier que le confrère sélectionné est correct
    [Arguments]    ${bouton_creer}
    click element    ${bouton_creer}
    wait until page contains    Sélectionnez une méthode d'échange
    click element    xpath=//*[@data-testid="suivant"]
    wait until element is visible    id=colleague_name    10s
    ${nom}=    Get Value    id=colleague_name
    Should Be Equal    ${nom}    ${COLLEAGUE_NAME}
    Go To    ${BASE_URL}/${COLLEAGUE_ID}

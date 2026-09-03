*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Bordereaux d'envoi"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Bordereaux d'envoi

*** Variables ***
${BORDEREAU_ID}      payers/dispatchslips/view/payer_dispatch_slip_id/537
${BORDEREAU_ORGANISME}    Farouk test

*** Test Cases ***
Accéder à la page Bordereaux d'envoi
    [Documentation]    Vérifie la navigation vers la page de liste des bordereaux d'envoi après
    ...                connexion.
    Accéder à la page    payers/dispatchslips

Vérifier la page détails Bordereaux d'envoi et ses boutons d'action
    [Documentation]    Ouvre un bordereau d'envoi depuis le tableau et vérifie que les boutons
    ...                "Supprimer", "Imprimer bordereau d'envoi" et "Modifier factures" sont
    ...                visibles. Contrairement à la page Devis, la page Bordereaux d'envoi ne
    ...                possède ni statut ni menu "Autres actions" : ces boutons sont toujours
    ...                affichés directement.
    Aller à la page détails du Bordereau d'envoi    ${BORDEREAU_ID}
    Vérifier l'en-tête du Bordereau d'envoi
    Wait Until Element Is Visible    xpath=//*[@data-testid="supprimer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer_bordereau_d'envoi"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier_factures"]    10s

Vérifier la section Ventes
    [Documentation]    Vérifie que la section Ventes (liste des ventes rattachées au bordereau
    ...                d'envoi) est visible, avec ses boutons Rafraichir et Recherche.
    Aller à la page détails du Bordereau d'envoi    ${BORDEREAU_ID}
    Page Should Contain    Ventes
    Wait Until Element Is Visible    xpath=(//*[@data-testid="recherche"])[2]    10s

Vérifier la visibilité de la section Commentaires
    [Documentation]    Vérifie que la section Commentaires est visible sur la page détails
    ...                Bordereaux d'envoi.
    Aller à la page détails du Bordereau d'envoi    ${BORDEREAU_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité
    [Documentation]    Vérifie que la section Informations de traçabilité est visible sur la page
    ...                détails Bordereaux d'envoi.
    Aller à la page détails du Bordereau d'envoi    ${BORDEREAU_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations du Bordereau d'envoi (organisme, date, total)
    [Documentation]    Vérifie que les informations générales du bordereau d'envoi (organisme,
    ...                date, totaux) sont correctement affichées.
    Aller à la page détails du Bordereau d'envoi    ${BORDEREAU_ID}
    Page Should Contain    Date
    Page Should Contain    Gestionnaire
    Page Should Contain    Organisme
    Page Should Contain    ${BORDEREAU_ORGANISME}
    Page Should Contain    Total client
    Page Should Contain    Total organisme

*** Keywords ***
Aller à la page détails du Bordereau d'envoi
    [Documentation]    Navigue vers la page de détails d'un bordereau d'envoi après connexion.
    [Arguments]    ${bordereau_id}
    Go To     ${BASE_URL}/${bordereau_id}
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier_factures"]    10s

Vérifier l'en-tête du Bordereau d'envoi
    Page Should Contain    Bordereau d'envoi
    Page Should Contain    ${BORDEREAU_ORGANISME}

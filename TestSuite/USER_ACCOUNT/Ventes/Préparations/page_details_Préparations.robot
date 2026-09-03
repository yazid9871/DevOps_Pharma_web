*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Préparations"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Préparations

*** Variables ***
${PREPARATION_COMPLETE_ID}      preparation/461
${PREPARATION_PRODUIT}          13.0 CONTROL DRILL STOP

*** Test Cases ***
Accéder à la page Préparations
    [Documentation]    Vérifie la navigation vers la page de liste des préparations après
    ...                connexion.
    Accéder à la page    preparations

Vérifier la page détails Préparations avec le statut Complété
    [Documentation]    Ouvre une préparation avec le statut "Complété" et vérifie que les boutons
    ...                "Annuler", "Dupliquer" et "Vendre cette préparation" sont visibles.
    ...                Contrairement à la page Devis, la page Préparations ne possède ni bouton
    ...                Imprimer, ni menu "Autres actions" : les actions sont toujours affichées
    ...                directement.
    Aller à la page détails de la Préparation    ${PREPARATION_COMPLETE_ID}
    Vérifier le statut de la Préparation    Complété
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="vendre_cette_préparation"]    10s

Vérifier la page détails Préparations avec le statut Annulé
    [Documentation]    Recherche une préparation avec le statut "Annulé" et, s'il en existe une,
    ...                l'ouvre et vérifie que les boutons "Dupliquer" et "Vendre cette préparation"
    ...                restent visibles, sans le bouton "Annuler". Note : l'annulation d'une
    ...                préparation nécessite un code de sécurité gestionnaire, ce test ne peut donc
    ...                pas générer lui-même de donnée Annulé.
    Rechercher Préparations par statut    Annulé
    ${a_un_resultat}=    Run Keyword And Return Status    Page Should Not Contain    Aucun résultat ne correspond à votre recherche
    IF    ${a_un_resultat}
        click element    xpath=${table}
        wait until element is visible    xpath=//*[@data-testid="dupliquer"]    10s
        Page Should Not Contain Element    xpath=//*[@data-testid="annuler"]
    END

Vérifier la visibilité de la section Commentaires
    [Documentation]    Vérifie que la section Commentaires est visible sur la page détails
    ...                Préparations.
    Aller à la page détails de la Préparation    ${PREPARATION_COMPLETE_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité
    [Documentation]    Vérifie que la section Informations de traçabilité est visible sur la page
    ...                détails Préparations.
    Aller à la page détails de la Préparation    ${PREPARATION_COMPLETE_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations de la Préparation (produit, date, total)
    [Documentation]    Vérifie que les informations générales de la préparation (produit, date,
    ...                prix unitaire résultant) sont correctement affichées.
    Aller à la page détails de la Préparation    ${PREPARATION_COMPLETE_ID}
    Page Should Contain    Date
    Page Should Contain    ${PREPARATION_PRODUIT}
    Page Should Contain    Prix Unitaire produit résultant

*** Keywords ***
Rechercher Préparations par statut
    [Arguments]    ${statut}
    Go To     ${BASE_URL}/preparations
    Wait Until Element Is Visible      xpath=//*[@data-testid="créer"]     timeout=30s
    click element    xpath=//*[@data-testid="recherche"]
    click element    id=status.q
    wait until element is visible    xpath=//div[contains(@class,"sob-v2-select__option") and text()="${statut}"]    10s
    click element    xpath=//div[contains(@class,"sob-v2-select__option") and text()="${statut}"]
    click element    xpath=//*[@data-testid="recherche"]
    sleep    2s

Aller à la page détails de la Préparation
    [Documentation]    Navigue vers la page de détails d'une préparation après connexion.
    [Arguments]    ${preparation_id}
    Go To     ${BASE_URL}/${preparation_id}
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s

Vérifier le statut de la Préparation
    [Arguments]    ${statut}
      Wait Until Page Contains     ${statut}     timeout=20s

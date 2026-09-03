*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Sorties confrères"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Sorties confrères

*** Variables ***
${SORTIE_BROUILLON_ID}      colleagues/sales/view/colleague_sale_id/89490
${SORTIE_COMPLETE_ID}       colleagues/sales/view/colleague_sale_id/89487
${SORTIE_ANNULE_ID}         colleagues/sales/view/colleague_sale_id/89491
${SORTIE_PRODUIT}           13.0 CONTROL DRILL STOP

*** Test Cases ***
Accéder à la page Sorties confrères
    [Documentation]    Vérifie la navigation vers la page de liste des sorties confrères après
    ...                connexion.
    Accéder à la page    colleagues/sales

Vérifier la page détails Sorties confrères avec le statut Brouillon
    [Documentation]    Ouvre une sortie confrère avec le statut "Brouillon" et vérifie que les
    ...                boutons "Annuler", "Générer un PDF", "Dupliquer" et "Modifier" sont
    ...                visibles. Contrairement à la page Devis, la page Sorties confrères ne
    ...                possède pas de menu "Autres actions" : les actions sont toujours affichées
    ...                directement.
    Aller à la page détails de la Sortie confrère    ${SORTIE_BROUILLON_ID}
    Vérifier le statut de la Sortie confrère    Brouillon
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]       10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="générer_un_pdf"]      10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]      10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier"]        10s

Vérifier la page détails Sorties confrères avec le statut Complété
    [Documentation]    Ouvre une sortie confrère avec le statut "Complété" et vérifie que les
    ...                boutons "Annuler", "Générer un PDF" et "Dupliquer" sont visibles, sans le
    ...                bouton "Modifier".
    Aller à la page détails de la Sortie confrère    ${SORTIE_COMPLETE_ID}
    Vérifier le statut de la Sortie confrère    Complété
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="générer_un_pdf"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Page Should Not Contain Element    xpath=//*[@data-testid="modifier"]

Vérifier la page détails Sorties confrères avec le statut Annulé
    [Documentation]    Ouvre une sortie confrère avec le statut "Annulé" et vérifie que seuls les
    ...                boutons "Générer un PDF" et "Dupliquer" sont visibles, sans les boutons
    ...                "Annuler" ni "Modifier".
    Aller à la page détails de la Sortie confrère    ${SORTIE_ANNULE_ID}
    Vérifier le statut de la Sortie confrère    Annulé
    Wait Until Element Is Visible    xpath=//*[@data-testid="générer_un_pdf"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Page Should Not Contain Element    xpath=//*[@data-testid="annuler"]
    Page Should Not Contain Element    xpath=//*[@data-testid="modifier"]

Vérifier la visibilité de la section Commentaires
    [Documentation]    Vérifie que la section Commentaires est visible sur la page détails
    ...                Sorties confrères.
    Aller à la page détails de la Sortie confrère    ${SORTIE_COMPLETE_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité
    [Documentation]    Vérifie que la section Informations de traçabilité est visible sur la page
    ...                détails Sorties confrères.
    Aller à la page détails de la Sortie confrère    ${SORTIE_COMPLETE_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations de la Sortie confrère (produit, date, total)
    [Documentation]    Vérifie que les informations générales de la sortie confrère (confrère,
    ...                produit, date, total) sont correctement affichées.
    Aller à la page détails de la Sortie confrère    ${SORTIE_COMPLETE_ID}
    Page Should Contain    Date
    Page Should Contain    Méthode d'échange
    Page Should Contain    Confrère
    Page Should Contain    Sous-total HT
    Page Should Contain    Total

*** Keywords ***
Aller à la page détails de la Sortie confrère
    [Documentation]    Navigue vers la page de détails d'une sortie confrère après connexion.
    [Arguments]    ${sortie_id}
    Go To     ${BASE_URL}/${sortie_id}
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s

Vérifier le statut de la Sortie confrère
    [Arguments]    ${statut}
    Wait Until Page Contains     ${statut}     timeout=20s
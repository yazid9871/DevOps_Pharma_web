*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Retours sur ventes"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Retours sur ventes

*** Variables ***
${RETOUR_COMPLETE_ID}      salesreturn/382465
${RETOUR_ANNULE_ID}        salesreturn/382139
${RETOUR_PRODUIT}          13.0 CONTROL DRILL STOP

*** Test Cases ***
Accéder à la page Retours sur ventes
    [Documentation]    Vérifie la navigation vers la page de liste des retours sur ventes après
    ...                connexion.
    Accéder à la page    salesreturns

Vérifier la page détails Retours sur ventes avec le statut Brouillon
    [Documentation]    Recherche un retour sur vente avec le statut "Brouillon" et, s'il en existe
    ...                un, l'ouvre et vérifie que le bouton "Autres actions" est visible.
    Rechercher Retours sur ventes par statut    Brouillon
    ${a_un_resultat}=    Run Keyword And Return Status    Page Should Not Contain    Aucun résultat ne correspond à votre recherche
    IF    ${a_un_resultat}
        click element    xpath=${table}
        wait until element is visible    xpath=//button[contains(., "Autres actions")]    10s
        Page Should Contain    Brouillon
    END

Vérifier la page détails Retours sur ventes avec le statut Complété
    [Documentation]    Ouvre un retour sur vente avec le statut "Complété" et vérifie que le
    ...                bouton "Annuler" ainsi que le bouton "Autres actions" (avec les options
    ...                "Imprimer" et "Imprimer ticket de caisse") sont visibles.
    Aller à la page détails du retour sur vente    ${RETOUR_COMPLETE_ID}
    Vérifier le statut du retour sur vente    Complété
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Vérifier les options du popup Autres actions Complété

Vérifier la page détails Retours sur ventes avec le statut Annulé
    [Documentation]    Ouvre un retour sur vente avec le statut "Annulé" et vérifie que seul le
    ...                bouton "Autres actions" (avec uniquement l'option "Imprimer") est visible,
    ...                sans bouton "Annuler".
    Aller à la page détails du retour sur vente    ${RETOUR_ANNULE_ID}
    Vérifier le statut du retour sur vente    Annulé
    Page Should Not Contain Element    xpath=//*[@data-testid="annuler"]
    Vérifier les options du popup Autres actions Annulé

Vérifier la visibilité de la section Commentaires
    [Documentation]    Vérifie que la section Commentaires est visible sur la page détails
    ...                Retours sur ventes.
    Aller à la page détails du retour sur vente    ${RETOUR_COMPLETE_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité
    [Documentation]    Vérifie que la section Informations de traçabilité est visible sur la page
    ...                détails Retours sur ventes.
    Aller à la page détails du retour sur vente    ${RETOUR_COMPLETE_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations du retour sur vente (produit, date, total)
    [Documentation]    Vérifie que les informations générales du retour sur vente (produit, date,
    ...                montant restitué) sont correctement affichées.
    Aller à la page détails du retour sur vente    ${RETOUR_COMPLETE_ID}
    Page Should Contain    Date
    Page Should Contain    ${RETOUR_PRODUIT}
    Page Should Contain    Montant restitué

*** Keywords ***
Rechercher Retours sur ventes par statut
    [Arguments]    ${statut}
    Go To     ${BASE_URL}/salesreturns
    Wait Until Element Is Visible      xpath=//*[@data-testid="créer"]     timeout=30s
    wait until element is visible       xpath=//*[@data-testid="recherche"]     10s
    click element    xpath=//*[@data-testid="recherche"]
    click element    id=status.q
    wait until element is visible    xpath=//div[contains(@class,"sob-v2-select__option") and text()="${statut}"]    10s
    click element    xpath=//div[contains(@class,"sob-v2-select__option") and text()="${statut}"]
     wait until element is visible       xpath=//*[@data-testid="recherche"]     10s
    click element    xpath=//*[@data-testid="recherche"]
    sleep    2s

Aller à la page détails du retour sur vente
    [Documentation]    Navigue vers la page de détails d'un retour sur vente après connexion.
    [Arguments]    ${retour_id}
    Go To     ${BASE_URL}/${retour_id}
    Wait Until Element Is Visible    xpath=//button[contains(., "Autres actions")]    10s

Vérifier le statut du retour sur vente
    [Arguments]    ${statut}
     Wait Until Page Contains     ${statut}     timeout=20s

Vérifier les options du popup Autres actions Complété
    click element    xpath=//button[contains(., "Autres actions")]
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s
    Page Should Contain    Imprimer
    Page Should Contain    Imprimer ticket de caisse
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer_ticket_de_caisse"]    10s
    press keys    None    ESC

Vérifier les options du popup Autres actions Annulé
    click element    xpath=//button[contains(., "Autres actions")]
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s
    Page Should Contain    Imprimer
    press keys    None    ESC

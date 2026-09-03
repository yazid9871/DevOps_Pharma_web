*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Inventaires"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Inventaires

*** Variables ***
${INVENTAIRE_COMPLETE_ID}      stock/stocktakes/view/stock_take_id/170252
${INVENTAIRE_ANNULE_ID}        stock/stocktakes/view/stock_take_id/168908
${INVENTAIRE_NUM_COMPLETE}     INV-10
${INVENTAIRE_NUM_ANNULE}       INV-5

*** Test Cases ***
Accéder à la page Inventaires
    [Documentation]    Vérifie la navigation vers la page de liste des inventaires après
    ...                connexion.
    Accéder à la page    stock/stocktakes

Vérifier la page détails Inventaires avec le statut Complété
    [Documentation]    Ouvre un inventaire avec le statut "Complété" et vérifie que les boutons
    ...                "Annuler", "Dupliquer" et "Imprimer" sont visibles. Contrairement à la page
    ...                Devis, la page Inventaires ne possède pas de menu "Autres actions" : les
    ...                actions sont toujours affichées directement, et le bouton "Imprimer" se
    ...                trouve dans la section "Produits de l'inventaire".
    Aller à la page détails de l'Inventaire    ${INVENTAIRE_COMPLETE_ID}
    Vérifier l'en-tête de l'Inventaire    ${INVENTAIRE_NUM_COMPLETE}
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer_"]    10s

Vérifier la page détails Inventaires avec le statut Annulé
    [Documentation]    Ouvre un inventaire avec le statut "Annulé" et vérifie que seul le bouton
    ...                "Dupliquer" est visible, sans les boutons "Annuler" ni "Imprimer".
    Aller à la page détails de l'Inventaire    ${INVENTAIRE_ANNULE_ID}
    Vérifier l'en-tête de l'Inventaire    ${INVENTAIRE_NUM_ANNULE}
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Page Should Not Contain Element    xpath=//*[@data-testid="annuler"]
    Page Should Not Contain Element    xpath=//*[@data-testid="imprimer_"]

Vérifier la section Produits de l'inventaire
    [Documentation]    Vérifie que la section "Produits de l'inventaire" est visible, avec ses
    ...                boutons Rafraichir et Recherche.
    Aller à la page détails de l'Inventaire    ${INVENTAIRE_COMPLETE_ID}
    Page Should Contain    Produits de l'inventaire
    Wait Until Element Is Visible    xpath=(//*[@data-testid="recherche"])[2]    10s

Vérifier la visibilité de la section Commentaires
    [Documentation]    Vérifie que la section Commentaires est visible sur la page détails
    ...                Inventaires.
    Aller à la page détails de l'Inventaire    ${INVENTAIRE_COMPLETE_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité
    [Documentation]    Vérifie que la section Informations de traçabilité est visible sur la page
    ...                détails Inventaires.
    Aller à la page détails de l'Inventaire    ${INVENTAIRE_COMPLETE_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations de l'Inventaire (produit, date, total)
    [Documentation]    Vérifie que les informations générales de l'inventaire (date, écart total,
    ...                valeurs PPV/PPH, quantités) sont correctement affichées.
    Aller à la page détails de l'Inventaire    ${INVENTAIRE_COMPLETE_ID}
    Page Should Contain    Date
    Page Should Contain    Écart total
    Page Should Contain    Valeur totale en PPV
    Page Should Contain    Valeur totale en PPH
    Page Should Contain    Quantités totales inventoriées

*** Keywords ***
Aller à la page détails de l'Inventaire
    [Documentation]    Navigue vers la page de détails d'un inventaire après connexion.
    [Arguments]    ${inventaire_id}
    Go To     ${BASE_URL}/${inventaire_id}
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s

Vérifier l'en-tête de l'Inventaire
    [Arguments]    ${numero}
    Page Should Contain    ${numero}

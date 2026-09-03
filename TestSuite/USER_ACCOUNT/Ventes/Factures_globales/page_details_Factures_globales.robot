*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Factures globales"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Factures globales

*** Variables ***
${FACTURE_GLOBALE_ID}      globalinvoices/index/view/global_invoice_id/1022
${FACTURE_GLOBALE_NUM}     FACG-18
${FACTURE_GLOBALE_PRODUIT}    13.0 CONTROL DRILL STOP

*** Test Cases ***
Accéder à la page Factures globales
    [Documentation]    Vérifie la navigation vers la page de liste des factures globales après
    ...                connexion.
    Accéder à la page    globalinvoices

Vérifier la page détails Factures globales et ses boutons d'action
    [Documentation]    Ouvre une facture globale depuis le tableau et vérifie que les boutons
    ...                "Supprimer", "Imprimer" et "Modifier" sont visibles. Contrairement à la
    ...                page Devis, la page Factures globales ne possède pas de statut ni de menu
    ...                "Autres actions" : ces boutons sont toujours affichés directement.
    Aller à la page détails de la Facture globale    ${FACTURE_GLOBALE_ID}
    Vérifier l'en-tête de la Facture globale
    Wait Until Element Is Visible    xpath=//*[@data-testid="supprimer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier"]    10s

Vérifier la section Ventes
    [Documentation]    Vérifie que la section Ventes (liste des ventes rattachées à la facture
    ...                globale) est visible, avec ses boutons Rafraichir et Recherche.
    Aller à la page détails de la Facture globale    ${FACTURE_GLOBALE_ID}
    Page Should Contain    Ventes
    Wait Until Element Is Visible    xpath=(//*[@data-testid="recherche"])[2]    10s

Vérifier la visibilité de la section Commentaires
    [Documentation]    Vérifie que la section Commentaires est visible sur la page détails
    ...                Factures globales.
    Aller à la page détails de la Facture globale    ${FACTURE_GLOBALE_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité
    [Documentation]    Vérifie que la section Informations de traçabilité est visible sur la page
    ...                détails Factures globales.
    Aller à la page détails de la Facture globale    ${FACTURE_GLOBALE_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations de la Facture globale (produit, date, total)
    [Documentation]    Vérifie que les informations générales de la facture globale (client,
    ...                produit, date de vente) sont correctement affichées.
    Aller à la page détails de la Facture globale    ${FACTURE_GLOBALE_ID}
    Page Should Contain    Date de vente
    Page Should Contain    Client
    Page Should Contain    ${FACTURE_GLOBALE_PRODUIT}

*** Keywords ***
Aller à la page détails de la Facture globale
    [Documentation]    Navigue vers la page de détails d'une facture globale après connexion.
    [Arguments]    ${facture_id}
    Go To     ${BASE_URL}/${facture_id}
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier"]    10s

Vérifier l'en-tête de la Facture globale
    Page Should Contain    ${FACTURE_GLOBALE_NUM}

*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Devis"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Devis

*** Variables ***
${QUOTE_BROUILLON_ID}      quote/8841
${QUOTE_COMPLETE_ID}       quote/8840
${QUOTE_ANNULE_ID}         quote/8688
${QUOTE_PRODUIT}           test product

*** Test Cases ***
Accéder à la page Devis
    [Documentation]    Vérifie la navigation vers la page de liste des devis après connexion.
    Accéder à la page    quotes

Vérifier la page détails devis avec le statut Brouillon
    [Documentation]    Recherche un devis avec le statut "Brouillon", l'ouvre et vérifie que les
    ...                boutons de la page détails (Imprimer, Autres actions) sont visibles, ainsi
    ...                que les options "Modifier", "Dupliquer" et "Annuler" dans le menu.
    Aller à la page détails du devis    ${QUOTE_BROUILLON_ID}
    Vérifier le statut du devis    Brouillon
    Vérifier le bouton Imprimer
    Vérifier les options du popup Autres actions Brouillon

Vérifier la page détails devis avec le statut Complété
    [Documentation]    Recherche un devis avec le statut "Complété", l'ouvre et vérifie que les
    ...                boutons de la page détails (Imprimer, Convertir en vente, Autres actions)
    ...                sont visibles, ainsi que les options "Dupliquer" et "Annuler" dans le menu.
    Aller à la page détails du devis    ${QUOTE_COMPLETE_ID}
    Vérifier le statut du devis    Complété
    Vérifier le bouton Imprimer
    Wait Until Element Is Visible    xpath=//*[@data-testid="convertir_en_vente"]    10s
    Vérifier les options du popup Autres actions Complété

Vérifier la page détails devis avec le statut Annulé
    [Documentation]    Recherche un devis avec le statut "Annulé", l'ouvre et vérifie que le
    ...                bouton Imprimer est visible, ainsi que l'option "Dupliquer" dans le menu
    ...                Autres actions.
    Aller à la page détails du devis    ${QUOTE_ANNULE_ID}
    Vérifier le statut du devis    Annulé
    Vérifier le bouton Imprimer
    Vérifier les options du popup Autres actions Annulé

Vérifier la visibilité de la section Commentaires
    [Documentation]    Vérifie que la section Commentaires est visible sur la page détails devis.
    Aller à la page détails du devis    ${QUOTE_BROUILLON_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité
    [Documentation]    Vérifie que la section Informations de traçabilité est visible sur la page
    ...                détails devis.
    Aller à la page détails du devis    ${QUOTE_BROUILLON_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations du devis (produit, date, total)
    [Documentation]    Vérifie que les informations générales du devis (produit, date de validité,
    ...                total) sont correctement affichées.
    Aller à la page détails du devis    ${QUOTE_BROUILLON_ID}
    Page Should Contain    Valable jusqu'au
    Page Should Contain    ${QUOTE_PRODUIT}
    Page Should Contain    Sous-total HT
    Page Should Contain    Total

*** Keywords ***
Aller à la page détails du devis
    [Documentation]    Navigue vers la page de détails d'un devis après connexion.
    [Arguments]    ${quote_id}
    Go To     ${BASE_URL}/${quote_id}
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s

Vérifier le statut du devis
    [Arguments]    ${statut}
     Wait Until Page Contains     ${statut}     timeout=20s

Vérifier le bouton Imprimer
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s

Vérifier les options du popup Autres actions Brouillon
    click element    xpath=//button[contains(., "Autres actions")]
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier"]    10s
    Page Should Contain    Modifier
    Page Should Contain    Dupliquer
    Page Should Contain    Annuler
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    press keys    None    ESC

Vérifier les options du popup Autres actions Complété
    click element    xpath=//button[contains(., "Autres actions")]
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Page Should Contain    Dupliquer
    Page Should Contain    Annuler
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    press keys    None    ESC

Vérifier les options du popup Autres actions Annulé
    click element    xpath=//button[contains(., "Autres actions")]
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Page Should Contain    Dupliquer
    press keys    None    ESC

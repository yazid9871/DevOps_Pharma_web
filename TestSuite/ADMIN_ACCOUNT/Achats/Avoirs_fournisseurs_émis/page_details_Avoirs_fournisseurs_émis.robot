*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Avoirs_fournisseurs_émis"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Avoirs_fournisseurs_émis

*** Variables ***
${AVOIR_BROUILLON_ID}      purchasesissuedreturn/89245
${AVOIR_COMPLETE_ID}       purchasesissuedreturn/89240
${AVOIR_ANNULE_ID}       purchasesissuedreturn/89248
${AVOIR_PRODUIT}           ALCE MIEL D'AGRUMES 400G
${AVOIR_FOURNISSEUR}       Cooper GPF

*** Test Cases ***
Accéder à la page Avoirs_fournisseurs_émis
    [Documentation]    Vérifie la navigation vers la page de liste des Avoirs_fournisseurs_émis après connexion.
    Accéder à la page    purchasesissuedreturns

Aller à la page détails de l'Avoirs_fournisseurs_émis Brouillon
    Aller à la page détails de l'Avoirs_fournisseurs_émis    ${AVOIR_BROUILLON_ID}
Vérifier le statut de l'Avoirs_fournisseurs_émis Brouillon
    Vérifier le statut de l'Avoirs_fournisseurs_émis    Brouillon
Vérifier le bouton Imprimer Brouillon
    Vérifier le bouton Imprimer
Vérifier la page détails Avoirs_fournisseurs_émis avec le statut Brouillon
    Vérifier les boutons d'action Brouillon

Aller à la page détails de l'Avoirs_fournisseurs_émis Complété
    Aller à la page détails de l'Avoirs_fournisseurs_émis     ${AVOIR_COMPLETE_ID}
Vérifier le statut de l'Avoirs_fournisseurs_émis Complété
    Vérifier le statut de l'Avoirs_fournisseurs_émis    Complété
Vérifier le bouton Imprimer Complété
    Vérifier le bouton Imprimer
Vérifier la page détails Avoirs_fournisseurs_émis avec le statut Complété
    Vérifier les boutons d'action Complété

Aller à la page détails de l'Avoirs_fournisseurs_émis Annulé
    Aller à la page détails de l'Avoirs_fournisseurs_émis     ${AVOIR_ANNULE_ID}
Vérifier le statut de l'Avoirs_fournisseurs_émis Annulé
    Vérifier le statut de l'Avoirs_fournisseurs_émis    Annulé
Vérifier le bouton Imprimer Annulé
    Vérifier le bouton Imprimer
Vérifier la page détails Avoirs_fournisseurs_émis avec le statut Annulé
    Vérifier les boutons d'action Annulé
Vérifier la visibilité de la section Commentaires
    Aller à la page détails de l'Avoirs_fournisseurs_émis    ${AVOIR_BROUILLON_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité

    Aller à la page détails de l'Avoirs_fournisseurs_émis    ${AVOIR_BROUILLON_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations de l'Avoirs_fournisseurs_émis (produit, date, fournisseur)

    Aller à la page détails de l'Avoirs_fournisseurs_émis    ${AVOIR_BROUILLON_ID}
    Page Should Contain    ${AVOIR_PRODUIT}
    Page Should Contain    ${AVOIR_FOURNISSEUR}
    Page Should Contain    Nombre de produits

*** Keywords ***
Aller à la page détails de l'Avoirs_fournisseurs_émis
    [Documentation]    Navigue vers la page de détails d'un Avoirs_fournisseurs_émis après connexion.
    [Arguments]    ${avoir_id}
    Go To     ${BASE_URL}/${avoir_id}
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s

Vérifier le statut de l'Avoirs_fournisseurs_émis
    [Arguments]    ${statut}
     Wait Until Page Contains     ${statut}     timeout=20s

Vérifier le bouton Imprimer
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s

Vérifier les boutons d'action Brouillon
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier"]    10s

Vérifier les boutons d'action Complété
    [Documentation]    Une fois l'Avoirs_fournisseurs_émis Complété, le bouton "Modifier" n'est plus
    ...                proposé (vérifié en direct sur RAE-5, id 89240) : contrairement à Devis où
    ...                le statut Complété propose encore "Convertir en vente" via "Autres actions",
    ...                ici il n'y a pas de menu "Autres actions" du tout, les boutons sont directs.
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Page Should Not Contain Element    xpath=//*[@data-testid="modifier"]
Vérifier les boutons d'action Annulé
      Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s

*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Bons_de_livraison"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Bons_de_livraison

*** Variables ***
${BL_BROUILLON_ID}      deliverynote/3661576
${BL_COMPLETE_ID}        deliverynote/3661859
${BL_NON_PAYE_ID}        deliverynote/3662229
${BL_ANNULE_ID}          deliverynote/3661305
${BL_PARTIELLEMENT_PAYE_ID}          deliverynote/3661534
${BL_PRODUIT}           AGIFENE SI 150ML SIROP
${BL_FOURNISSEUR}        Cooper GPF

*** Test Cases ***
Accéder à la page Bons_de_livraison
    [Documentation]    Vérifie la navigation vers la page de liste des Bons_de_livraison après connexion.
    Accéder à la page    deliverynotes

Aller à la page détails du Bons_de_livraison Brouillon
    Aller à la page détails du Bons_de_livraison    ${BL_BROUILLON_ID}
Vérifier le statut du Bons_de_livraison Brouillon
    Vérifier le statut du Bons_de_livraison    Brouillon
Vérifier le bouton Imprimer Brouillon
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_livraison avec le statut Brouillon
    Vérifier les boutons d'action Brouillon

Aller à la page détails du Bons_de_livraison Complété
    Aller à la page détails du Bons_de_livraison     ${BL_COMPLETE_ID}
Vérifier le statut du Bons_de_livraison Complété
    Vérifier le statut du Bons_de_livraison    Complété
Vérifier le bouton Imprimer Complété
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_livraison avec le statut Complété
    Vérifier les boutons d'action Complété

Aller à la page détails du Bons_de_livraison Non payé
    Aller à la page détails du Bons_de_livraison     ${BL_NON_PAYE_ID}
Vérifier le statut du Bons_de_livraison Non payé
    Vérifier le statut du Bons_de_livraison     Non payé
Vérifier le bouton Imprimer Non payé
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_livraison avec le statut Non payé
    Vérifier les boutons d'action Non payé

Aller à la page détails du Bons_de_livraison Partiellement payé
    Aller à la page détails du Bons_de_livraison     ${BL_PARTIELLEMENT_PAYE_ID}
Vérifier le statut du Bons_de_livraison Partiellement payé
    Vérifier le statut du Bons_de_livraison    Partiellement payé
Vérifier le bouton Imprimer Partiellement payé
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_livraison avec le statut Partiellement payé
    Vérifier les boutons d'action Partiellement payé

Aller à la page détails du Bons_de_livraison Annulé
    Aller à la page détails du Bons_de_livraison     ${BL_ANNULE_ID}
Vérifier le statut du Bons_de_livraison Annulé
    Vérifier le statut du Bons_de_livraison    Annulé
Vérifier le bouton Imprimer Annulé
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_livraison avec le statut Annulé
    Vérifier les boutons d'action Annulé

Vérifier la visibilité de la section Commentaires
    [Documentation]    Vérifie que la section Commentaires est visible sur la page détails Bons_de_livraison.
    Aller à la page détails du Bons_de_livraison    ${BL_BROUILLON_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité
    [Documentation]    Vérifie que la section Informations de traçabilité est visible sur la page
    ...                détails Bons_de_livraison.
    Aller à la page détails du Bons_de_livraison    ${BL_BROUILLON_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations du Bons_de_livraison (produit, date, fournisseur)
    [Documentation]    Vérifie que les informations générales du Bons_de_livraison (produit, date,
    ...                fournisseur, total) sont correctement affichées.
    Aller à la page détails du Bons_de_livraison    ${BL_BROUILLON_ID}
    Page Should Contain    Date Bon de Livraison
    Page Should Contain    ${BL_PRODUIT}
    Page Should Contain    ${BL_FOURNISSEUR}
    Page Should Contain    Total PPH

*** Keywords ***
Aller à la page détails du Bons_de_livraison
    [Documentation]    Navigue vers la page de détails d'un Bons_de_livraison après connexion.
    [Arguments]    ${bl_id}
    Go To     ${BASE_URL}/${bl_id}
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s

Vérifier le statut du Bons_de_livraison
    [Arguments]    ${statut}
     Wait Until Page Contains     ${statut}     timeout=20s

Vérifier le bouton Imprimer
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s

Vérifier les boutons d'action Brouillon
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="approuver"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier"]    10s

Vérifier les boutons d'action Complété
    [Documentation]    Une fois le Bons_de_livraison entièrement payé (Total à payer = 0,00), les
    ...                boutons Approuver, Modifier et Ajouter un paiement disparaissent (vérifié en
    ...                direct sur BL-17, id 3661859).
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="générer_avoir_fournisseur"]    10s
    Page Should Not Contain Element    xpath=//*[@data-testid="approuver"]
    Page Should Not Contain Element    xpath=//*[@data-testid="modifier"]

Vérifier les boutons d'action Non payé
    [Documentation]    Un Bons_de_livraison approuvé mais non intégralement payé propose "Générer
    ...                avoir fournisseur" et "Ajouter un paiement" (vérifié en direct sur BL-20, id
    ...                3661947), au lieu d'Approuver/Modifier qui ne s'appliquent qu'au Brouillon.
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    # autre action / générer_avoir_fournisseur    et envoye par mail
    Wait Until Element Is Visible    xpath=//*[@data-testid="autres_actions"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="ajouter_un_paiement"]    10s
Vérifier les boutons d'action Partiellement payé
    [Documentation]    Un Bons_de_livraison approuvé mais non intégralement payé propose "Générer
    ...                avoir fournisseur" et "Ajouter un paiement" (vérifié en direct sur BL-20, id
    ...                3661947), au lieu d'Approuver/Modifier qui ne s'appliquent qu'au Brouillon.
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="générer_avoir_fournisseur"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="ajouter_un_paiement"]    10s
Vérifier les boutons d'action Annulé
     Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s

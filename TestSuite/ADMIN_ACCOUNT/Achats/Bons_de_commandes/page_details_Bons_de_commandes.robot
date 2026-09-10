*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Bons_de_commandes"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Bons_de_commandes

*** Variables ***
${BC_BROUILLON_ID}      purchaseorder/1936452
${BC_ANNULE_ID}          purchaseorder/1936869
${BC_LIVRE_ID}           purchaseorder/1936390
${BL_NON_PAYE_ID}          purchaseorder/1933485
${BL_ENVOYE_AU_FOURNISSEUR_ID}          purchaseorder/1936689
${BL_TRAITE_PAR_FOURNISSEUR_ID}          purchaseorder/1932176
${BC_PRODUIT}            13.0 CONTROL DRILL STOP D3.75/4.0 REF 125155
${BC_FOURNISSEUR}        Grossiste COOPER PHARMA

*** Test Cases ***
Accéder à la page Bons_de_commandes
    [Documentation]    Vérifie la navigation vers la page de liste des Bons_de_commandes après connexion.
    Accéder à la page    purchaseorders

Aller à la page détails du Bons_de_commandes Brouillon
    Aller à la page détails du Bons_de_commandes    ${BC_BROUILLON_ID}
Vérifier le statut du Bons_de_commandes Brouillon
    Vérifier le statut du Bons_de_commandes    Brouillon
Vérifier le bouton Imprimer Brouillon
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_commandes avec le statut Brouillon
    Vérifier les boutons d'action Brouillon

Aller à la page détails du Bons_de_commandes Non payé
    Aller à la page détails du Bons_de_commandes    ${BL_NON_PAYE_ID}
Vérifier le statut du Bons_de_commandes Non payé
    Vérifier le statut du Bons_de_commandes    Non payé
Vérifier le bouton Imprimer Non payé
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_commandes avec le statut Non payé
    Vérifier les boutons d'action Non payé

Aller à la page détails du Bons_de_commandes Envoyé au fournisseur
    Aller à la page détails du Bons_de_commandes    ${BL_ENVOYE_AU_FOURNISSEUR_ID}
Vérifier le statut du Bons_de_commandes Envoyé au fournisseur
    Vérifier le statut du Bons_de_commandes   Envoyé au fournisseur
Vérifier le bouton Imprimer Envoyé au fournisseur
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_commandes avec le statut Envoyé au fournisseur
    Vérifier les boutons d'action Envoyé au fournisseur

Aller à la page détails du Bons_de_commandes Traité par le fournisseur
    Aller à la page détails du Bons_de_commandes    ${BL_TRAITE_PAR_FOURNISSEUR_ID}
Vérifier le statut du Bons_de_commandes Traité par le fournisseur
    Vérifier le statut du Bons_de_commandes    Traité par le fournisseur
Vérifier le bouton Imprimer Traité par le fournisseur
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_commandes avec le statut Traité par le fournisseur
    Vérifier les boutons d'action Traité par le fournisseur

Aller à la page détails du Bons_de_commandes Annulé
    Aller à la page détails du Bons_de_commandes    ${BC_ANNULE_ID}
Vérifier le statut du Bons_de_commandes Annulé
    Vérifier le statut du Bons_de_commandes    Annulé
Vérifier le bouton Imprimer Annulé
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_commandes avec le statut Annulé
    Vérifier les boutons d'action Annulé

Aller à la page détails du Bons_de_commandes Livré
    Aller à la page détails du Bons_de_commandes    ${BC_LIVRE_ID}
Vérifier le statut du Bons_de_commandes Livré
    Vérifier le statut du Bons_de_commandes    Livré
Vérifier le bouton Imprimer Livré
    Vérifier le bouton Imprimer
Vérifier la page détails Bons_de_commandes avec le statut Livré
    Vérifier les boutons d'action Livré

Vérifier la visibilité de la section Commentaires
    [Documentation]    Vérifie que la section Commentaires est visible sur la page détails Bons_de_commandes.
    Aller à la page détails du Bons_de_commandes    ${BC_BROUILLON_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité
    [Documentation]    Vérifie que la section Informations de traçabilité est visible sur la page
    ...                détails Bons_de_commandes.
    Aller à la page détails du Bons_de_commandes    ${BC_BROUILLON_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations du Bons_de_commandes (produit, fournisseur, total)
    [Documentation]    Vérifie que les informations générales du Bons_de_commandes (produit,
    ...                fournisseur, total commandé) sont correctement affichées.
    Aller à la page détails du Bons_de_commandes    ${BC_BROUILLON_ID}
    Page Should Contain    ${BC_PRODUIT}
    Page Should Contain    ${BC_FOURNISSEUR}
    Page Should Contain    Total commandé

*** Keywords ***
Aller à la page détails du Bons_de_commandes
    [Documentation]    Navigue vers la page de détails d'un Bons_de_commandes après connexion.
    [Arguments]    ${bc_id}
    Go To     ${BASE_URL}/${bc_id}
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s

Vérifier le statut du Bons_de_commandes
    [Arguments]    ${statut}
     Wait Until Page Contains     ${statut}     timeout=20s

Vérifier le bouton Imprimer
    Wait Until Element Is Visible    xpath=//*[@data-testid="imprimer"]    10s

Vérifier les boutons d'action Non payé
    [Documentation]    Un Bons_de_commandes en Non payé propose Annuler, Exporter la commande CSV,
    ...                Dupliquer, Modifier et Approuver (vérifié en direct sur BC-22, id 1936452).
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="exporter_la_commande_csv"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="convertir_en_bon_de_livraison"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="commander_en_ligne"]    10s

Vérifier les boutons d'action Brouillon
    [Documentation]    Un Bons_de_commandes en Brouillon propose Annuler, Exporter la commande CSV,
    ...                Dupliquer, Modifier et Approuver (vérifié en direct sur BC-22, id 1936452).
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="exporter_la_commande_csv"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="modifier"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="approuver"]    10s

Vérifier les boutons d'action Annulé
    [Documentation]    Un Bons_de_commandes Annulé n'a plus de bouton Annuler/Modifier/Approuver :
    ...                Exporter la commande CSV et Envoyer par Email passent derrière un menu
    ...                "Autres actions" (vérifié en direct sur BC-36, id 1936869).
    click element    xpath=//button[contains(., "Autres actions")]
    Wait Until Element Is Visible    xpath=//*[contains(text(), "Exporter la commande CSV")]    10s
    Page Should Contain    Envoyer par Email
    press keys    None    ESC
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Page Should Not Contain Element    xpath=//*[@data-testid="annuler"]
    Page Should Not Contain Element    xpath=//*[@data-testid="modifier"]

Vérifier les boutons d'action Livré
    [Documentation]    Un Bons_de_commandes Livré propose un bouton "Bon de Livraison" pour générer
    ...                le bon de livraison associé, à la place de Modifier/Approuver (vérifié en
    ...                direct sur BC-19, id 1936390).
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="exporter_la_commande_csv"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="bon_de_livraison"]    10s
    Page Should Not Contain Element    xpath=//*[@data-testid="modifier"]
    Page Should Not Contain Element    xpath=//*[@data-testid="approuver"]

Vérifier les boutons d'action Envoyé au fournisseur
    Wait Until Element Is Visible    xpath=//*[@data-testid="annuler"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="exporter_la_commande_csv"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s


Vérifier les boutons d'action Traité par le fournisseur
    Wait Until Element Is Visible    xpath=//*[@data-testid="convertir_en_bon_de_livraison"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="exporter_la_commande_csv"]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="dupliquer"]    10s
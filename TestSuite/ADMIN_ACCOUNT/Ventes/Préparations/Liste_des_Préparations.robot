*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Préparations"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Préparations


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Préparations fonctionne correctement
    Accéder à la page    preparations
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier Le Bouton "Créer" Préparations
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page Préparations
    Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Créer une nouvelle préparation     preparations

Rechercher Par Client
    [Documentation]    Vérifie que la recherche par client fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Préparations
    Vérifier La Recherche     th    kjgljg      ${CHAMP_CLIENT_PREPARATION}

Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Préparations
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Préparations
    Vérifier La Recherche     td[1]    PRE-431   ${CHAMP_NUM_TRANSACTION_PREPARATION}

Rechercher Par Date
    [Documentation]    Vérifie que la recherche par date fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Préparations
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Préparations
    Vérifier La Recherche     td[3]       2026-08-06     ${CHAMP_DATE_PREPARATION}

Vérifier La Recherche Par Quantité De Produit Résultant
    [Documentation]    Vérifie la recherche d'une Préparation par sa quantité de produit résultant.
    Vérifier La Visibilité Des Champs De Recherche Préparations
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Préparations
    Vérifier La Recherche     td[4]     110    ${CHAMP_QTE_PRODUIT_PREPARATION}

Vérifier La Recherche Par Prix Unitaire Du Produit Résultant
    [Documentation]    Vérifie la recherche d'une Préparation par le prix unitaire de son produit résultant.
    Vérifier La Visibilité Des Champs De Recherche Préparations
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Préparations
    Vérifier La Recherche     td[5]     100    ${CHAMP_PRIX_UNI_PREPARATION}

Rechercher Par Type
    [Documentation]    Vérifie que la recherche par type fonctionne correctement
     Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_TYPE_PREPARATION}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[2]    ${CHAMP_TYPE_PREPARATION}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_PREPARATION}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[6]    ${CHAMP_STATUT_PREPARATION}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Préparations
    Wait Until Element Is Visible  ${CHAMP_CLIENT_PREPARATION}
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_PREPARATION}
    Wait Until Element Is Visible  ${CHAMP_TYPE_PREPARATION}
    Wait Until Element Is Visible  ${CHAMP_DATE_PREPARATION}
    Wait Until Element Is Visible  ${CHAMP_QTE_PRODUIT_PREPARATION}
    Wait Until Element Is Visible  ${CHAMP_PRIX_UNI_PREPARATION}
    Wait Until Element Is Visible  ${CHAMP_STATUT_PREPARATION}


Vérifier Que Le Champ De Recherche Est Vide Préparations
    ${client} =    Get Value    ${CHAMP_CLIENT_PREPARATION}
    ${num_transaction} =    Get Value    ${CHAMP_NUM_TRANSACTION_PREPARATION}
    ${date} =    Get Value    ${CHAMP_DATE_PREPARATION}
    ${qte} =    Get Value    ${CHAMP_QTE_PRODUIT_PREPARATION}
    ${prix} =    Get Value    ${CHAMP_PRIX_UNI_PREPARATION}

    Should Be Empty    ${client}
    Should Be Empty    ${num_transaction}
    Should Be Empty    ${date}
    Should Be Empty    ${qte}
    Should Be Empty    ${prix}

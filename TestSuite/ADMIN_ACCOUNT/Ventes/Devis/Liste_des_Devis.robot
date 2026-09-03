*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Devis"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Devis


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Devis fonctionne correctement
    Accéder à la page    quotes
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier La Visibilité Et La Fonctionnalité De L'Icône Imprimer
    [Documentation]    Vérifie que l'icône Imprimer est visible et fonctionnelle
    Vérifier Icône Imprimer          quotes
Vérifier L'Icône Éditer
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    VérifierL'Icône Éditer      Modifier devis        quotes
Vérifier Le Bouton "Créer" Devis
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page Devis
    Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Créer un nouveau devis     quotes

Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Devis
    Vérifier La Recherche     th    DEV-6      ${CHAMP_NUM_TRANSACTION_DEVIS}

Rechercher Par Client
    [Documentation]    Vérifie que la recherche par client fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Devis
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Devis
    Vérifier La Recherche     td[1]    kjgljg   ${CHAMP_CLIENT_DEVIS}

Rechercher Par Date De Validité
    [Documentation]    Vérifie que la recherche par date "Valable jusqu'au" fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Devis
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Devis
    Vérifier La Recherche     td[2]       2026-07-31     ${CHAMP_VALABLE_JUSQUAU_DEVIS}

Vérifier La Recherche Par Total
    [Documentation]    Vérifie la recherche d'un Devis par son montant total.
    Vérifier La Visibilité Des Champs De Recherche Devis
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Devis
    Vérifier La Recherche     td[3]     78    ${CHAMP_TOTAL_DEVIS}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_DEVIS}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[4]    ${CHAMP_STATUT_DEVIS}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Devis
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_DEVIS}
    Wait Until Element Is Visible  ${CHAMP_CLIENT_DEVIS}
    Wait Until Element Is Visible  ${CHAMP_VALABLE_JUSQUAU_DEVIS}
    Wait Until Element Is Visible  ${CHAMP_TOTAL_DEVIS}
    Wait Until Element Is Visible  ${CHAMP_STATUT_DEVIS}


Vérifier Que Le Champ De Recherche Est Vide Devis
    ${num_transaction} =    Get Value    ${CHAMP_NUM_TRANSACTION_DEVIS}
    ${client} =    Get Value    ${CHAMP_CLIENT_DEVIS}
    ${valable_jusquau} =    Get Value    ${CHAMP_VALABLE_JUSQUAU_DEVIS}
    ${total} =    Get Value    ${CHAMP_TOTAL_DEVIS}

    Should Be Empty    ${num_transaction}
    Should Be Empty    ${client}
    Should Be Empty    ${valable_jusquau}
    Should Be Empty    ${total}

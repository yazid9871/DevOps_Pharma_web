*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Retours sur ventes"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Retours sur ventes


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Retours sur ventes fonctionne correctement
    Accéder à la page    salesreturns
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier La Visibilité Et La Fonctionnalité De L'Icône Imprimer
    [Documentation]    Vérifie que l'icône Imprimer est visible et fonctionnelle
    Vérifier Icône Imprimer          salesreturns
Vérifier L'Icône Éditer
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    VérifierL'Icône Éditer      Modifier un retour sur vente        salesreturns
Vérifier Le Bouton "Créer" Retours sur ventes
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page Retours sur ventes
    Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Créer un nouveau retour sur vente     salesreturns

Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Retours sur ventes
    Vérifier La Recherche     th    RV-969      ${CHAMP_NUM_TRANSACTION_RETOUR}

Rechercher Par Client
    [Documentation]    Vérifie que la recherche par client fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Retours sur ventes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Retours sur ventes
    Vérifier La Recherche     td[1]    test   ${CHAMP_CLIENT_RETOUR}

Rechercher Par Date
    [Documentation]    Vérifie que la recherche par date fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Retours sur ventes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Retours sur ventes
    Vérifier La Recherche     td[2]       2026-08-05     ${CHAMP_DATE_RETOUR}

Vérifier La Recherche Par Montant Restitué
    [Documentation]    Vérifie la recherche d'un Retour sur vente par son montant restitué.
    Vérifier La Visibilité Des Champs De Recherche Retours sur ventes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Retours sur ventes
    Vérifier La Recherche     td[3]     100    ${CHAMP_MONTANT_RESTITUE_RETOUR}

Rechercher Par Mode De Remboursement
    [Documentation]    Vérifie que la recherche par mode de remboursement fonctionne correctement
     Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_MODE_REMBOURSEMENT_RETOUR}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[4]    ${CHAMP_MODE_REMBOURSEMENT_RETOUR}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_RETOUR}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[5]    ${CHAMP_STATUT_RETOUR}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Retours sur ventes
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_RETOUR}
    Wait Until Element Is Visible  ${CHAMP_CLIENT_RETOUR}
    Wait Until Element Is Visible  ${CHAMP_DATE_RETOUR}
    Wait Until Element Is Visible  ${CHAMP_MONTANT_RESTITUE_RETOUR}
    Wait Until Element Is Visible  ${CHAMP_MODE_REMBOURSEMENT_RETOUR}
    Wait Until Element Is Visible  ${CHAMP_STATUT_RETOUR}


Vérifier Que Le Champ De Recherche Est Vide Retours sur ventes
    ${num_transaction} =    Get Value    ${CHAMP_NUM_TRANSACTION_RETOUR}
    ${client} =    Get Value    ${CHAMP_CLIENT_RETOUR}
    ${date} =    Get Value    ${CHAMP_DATE_RETOUR}
    ${montant} =    Get Value    ${CHAMP_MONTANT_RESTITUE_RETOUR}

    Should Be Empty    ${num_transaction}
    Should Be Empty    ${client}
    Should Be Empty    ${date}
    Should Be Empty    ${montant}

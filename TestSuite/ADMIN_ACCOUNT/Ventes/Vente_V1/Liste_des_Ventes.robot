*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Ventes"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Ventes



*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Ventes fonctionne correctement
    Accéder à la page    invoices
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent
Vérifier La Visibilité Et La Fonctionnalité De L'Icône Imprimer
    [Documentation]    Vérifie que l'icône Imprimer est visible et fonctionnelle
    Vérifier Icône Imprimer          invoices
Vérifier L'Icône Éditer
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    VérifierL'Icône Éditer     Modifier la facture      invoices
Vérifier L'Icône Ajouter un paiement
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    VérifierL'Icône Ajouter un paiement     Ajouter un paiement     invoices

Vérifier Le Bouton "Créer" Ventes
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page Ventes
    Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Créer une nouvelle vente     invoices

Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Ventes
    Vérifier La Recherche     th    FAC-8004      ${CHAMP_NUM_TRANSACTION_VENTE}

Rechercher Par Client
    [Documentation]    Vérifie que la recherche par client fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Ventes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Ventes
    Vérifier La Recherche     td[1]    kjgljg   ${CHAMP_CLIENT_VENTE}

Rechercher Par Date De Vente
    [Documentation]    Vérifie que la recherche par date de vente fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Ventes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Ventes
    Vérifier La Recherche     td[2]       2026-06-09     ${CHAMP_DATE_VENTE}

Rechercher Par Date De Création
    [Documentation]    Vérifie la recherche d'une Vente par sa date de création (Créé le).
    Vérifier La Visibilité Des Champs De Recherche Ventes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Ventes
    Vérifier La Recherche     td[3]     2026-07-31 15:34:37     ${CHAMP_CREE_LE_VENTE}

Vérifier La Recherche Par Total
    [Documentation]    Vérifie la recherche d'une Vente par son montant total.
    Vérifier La Visibilité Des Champs De Recherche Ventes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Ventes
    Vérifier La Recherche     td[4]     170,00    ${CHAMP_TOTAL_VENTE}
Rechercher Par Livré
    [Documentation]    Vérifie que la recherche par statut de livraison fonctionne correctement
      Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_LIVRE_VENTE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[5]    ${CHAMP_LIVRE_VENTE}
Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_VENTE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[6]    ${CHAMP_STATUT_VENTE}




*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Ventes
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_VENTE}
    Wait Until Element Is Visible  ${CHAMP_CLIENT_VENTE}
    Wait Until Element Is Visible  ${CHAMP_DATE_VENTE}
    Wait Until Element Is Visible  ${CHAMP_CREE_LE_VENTE}
    Wait Until Element Is Visible  ${CHAMP_TOTAL_VENTE}
    Wait Until Element Is Visible  ${CHAMP_LIVRE_VENTE}
    Wait Until Element Is Visible  ${CHAMP_STATUT_VENTE}


Vérifier Que Le Champ De Recherche Est Vide Ventes
    ${num_transaction} =    Get Value    ${CHAMP_NUM_TRANSACTION_VENTE}
    ${client} =    Get Value    ${CHAMP_CLIENT_VENTE}
    ${date_vente} =    Get Value    ${CHAMP_DATE_VENTE}
    ${cree_le} =    Get Value    ${CHAMP_CREE_LE_VENTE}
    ${total} =    Get Value    ${CHAMP_TOTAL_VENTE}

    Should Be Empty    ${num_transaction}
    Should Be Empty    ${client}
    Should Be Empty    ${date_vente}
    Should Be Empty    ${cree_le}
    Should Be Empty    ${total}


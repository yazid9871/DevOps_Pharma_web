*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Factures globales"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Factures globales


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Factures globales fonctionne correctement
    Accéder à la page    globalinvoices
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier Le Bouton "Créer" Factures globales
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page Factures globales
    Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Sélectionnez une méthode d'échange     globalinvoices

Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Factures globales
    Vérifier La Recherche     th    FACG-216      ${CHAMP_NUM_TRANSACTION_FACTURE_GLOBALE}

Rechercher Par Client
    [Documentation]    Vérifie que la recherche par client fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Factures globales
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures globales
    Vérifier La Recherche     td[1]    kjgljg   ${CHAMP_CLIENT_FACTURE_GLOBALE}

Rechercher Par Date De Vente
    [Documentation]    Vérifie que la recherche par date de vente fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Factures globales
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures globales
    Vérifier La Recherche     td[2]       2026-08-06     ${CHAMP_DATE_VENTE_FACTURE_GLOBALE}

Rechercher Par Date De Création
    [Documentation]    Vérifie la recherche d'une Facture globale par sa date de création (Créé le).
    Vérifier La Visibilité Des Champs De Recherche Factures globales
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures globales
    Vérifier La Recherche     td[4]     2026-08-06     ${CHAMP_CREE_LE_FACTURE_GLOBALE}

Vérifier La Recherche Par Total
    [Documentation]    Vérifie la recherche d'une Facture globale par son montant total.
    Vérifier La Visibilité Des Champs De Recherche Factures globales
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Factures globales
    Vérifier La Recherche     td[5]     100    ${CHAMP_TOTAL_FACTURE_GLOBALE}

Rechercher Par Créé Par
    [Documentation]    Vérifie que la recherche par "Créé par" fonctionne correctement
     Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_CREE_PAR_FACTURE_GLOBALE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]    ${CHAMP_CREE_PAR_FACTURE_GLOBALE}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Factures globales
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_FACTURE_GLOBALE}
    Wait Until Element Is Visible  ${CHAMP_CLIENT_FACTURE_GLOBALE}
    Wait Until Element Is Visible  ${CHAMP_DATE_VENTE_FACTURE_GLOBALE}
    Wait Until Element Is Visible  ${CHAMP_CREE_PAR_FACTURE_GLOBALE}
    Wait Until Element Is Visible  ${CHAMP_CREE_LE_FACTURE_GLOBALE}
    Wait Until Element Is Visible  ${CHAMP_TOTAL_FACTURE_GLOBALE}


Vérifier Que Le Champ De Recherche Est Vide Factures globales
    ${num_transaction} =    Get Value    ${CHAMP_NUM_TRANSACTION_FACTURE_GLOBALE}
    ${client} =    Get Value    ${CHAMP_CLIENT_FACTURE_GLOBALE}
    ${date_vente} =    Get Value    ${CHAMP_DATE_VENTE_FACTURE_GLOBALE}
    ${cree_le} =    Get Value    ${CHAMP_CREE_LE_FACTURE_GLOBALE}
    ${total} =    Get Value    ${CHAMP_TOTAL_FACTURE_GLOBALE}

    Should Be Empty    ${num_transaction}
    Should Be Empty    ${client}
    Should Be Empty    ${date_vente}
    Should Be Empty    ${cree_le}
    Should Be Empty    ${total}

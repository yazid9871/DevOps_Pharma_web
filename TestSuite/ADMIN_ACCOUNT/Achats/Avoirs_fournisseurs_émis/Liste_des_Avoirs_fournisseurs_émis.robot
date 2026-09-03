*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Avoirs fournisseurs émis"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Avoirs fournisseurs émis


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Avoirs fournisseurs émis fonctionne correctement
    Accéder à la page    purchasesissuedreturns
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent
Vérifier La Visibilité Et La Fonctionnalité De L'Icône Imprimer
    [Documentation]    Vérifie que l'icône Imprimer est visible et fonctionnelle
    Vérifier Icône Imprimer          purchasesissuedreturns
Vérifier Le Bouton "créer Avoirs fournisseurs émis"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Avoirs fournisseurs émis
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Créer un nouvel avoir fournisseur émis     purchasesissuedreturns
Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs émis
    Vérifier La Recherche     th    RAE-505   ${CHAMP_NUM_TRANSACTION_AVOIR_FOURNISSEUR}

Rechercher Par Fournisseur
    [Documentation]    Vérifie que la recherche par fournisseur fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs émis
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs émis
    Vérifier La Recherche     td[1]    farouk test   ${CHAMP_FOURNISSEUR_AVOIR_FOURNISSEUR}


Rechercher Par Date
    [Documentation]    Vérifie que la recherche par date fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs émis
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs émis
    Vérifier La Recherche     td[2]    2026-08-04    ${CHAMP_DATE_AVOIR_FOURNISSEUR}

Vérifier La Recherche Par Total Émis
    [Documentation]    Vérifie la recherche d'un Avoir fournisseur émis par son total émis.
     Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs émis
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs émis
   Vérifier La Recherche     td[3]    806    ${CHAMP_TOTAL_EMIS_AVOIR_FOURNISSEUR}

Vérifier La Recherche Par Total En Attente
    [Documentation]    Vérifie la recherche d'un Avoir fournisseur émis par son total en attente.
     Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs émis
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs émis
   Vérifier La Recherche     td[4]    806    ${CHAMP_TOTAL_ATTENTE_AVOIR_FOURNISSEUR}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs émis
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_AVOIR_FOURNISSEUR}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[5]  ${CHAMP_STATUT_AVOIR_FOURNISSEUR}
*** Keywords ***

Vérifier La Visibilité Des Champs De Recherche Avoirs fournisseurs émis
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_AVOIR_FOURNISSEUR}
    Wait Until Element Is Visible  ${CHAMP_FOURNISSEUR_AVOIR_FOURNISSEUR}
     Wait Until Element Is Visible  ${CHAMP_DATE_AVOIR_FOURNISSEUR}
    Wait Until Element Is Visible    ${CHAMP_TOTAL_EMIS_AVOIR_FOURNISSEUR}
     Wait Until Element Is Visible  ${CHAMP_TOTAL_ATTENTE_AVOIR_FOURNISSEUR}
    Wait Until Element Is Visible    ${CHAMP_STATUT_AVOIR_FOURNISSEUR}

Vérifier Que Le Champ De Recherche Est Vide Avoirs fournisseurs émis
    ${fournisseur} =    Get Value    ${CHAMP_FOURNISSEUR_AVOIR_FOURNISSEUR}
    ${date} =    Get Value    ${CHAMP_DATE_AVOIR_FOURNISSEUR}
    ${total_emis} =    Get Value    ${CHAMP_TOTAL_EMIS_AVOIR_FOURNISSEUR}
    ${total_attente} =    Get Value    ${CHAMP_TOTAL_ATTENTE_AVOIR_FOURNISSEUR}

     Should Be Empty    ${fournisseur}
     Should Be Empty    ${date}
     Should Be Empty    ${total_emis}
     Should Be Empty    ${total_attente}

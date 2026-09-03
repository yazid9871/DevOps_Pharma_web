*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Inventaires"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste Inventaires


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Inventaires fonctionne correctement
    Accéder à la page    stock/stocktakes
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier Le Bouton Demander mon inventaire"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    Vérifier Bouton Demander mon inventaire

Vérifier Le Bouton "créer Inventaires"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Inventaires
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    inventaire     stock/stocktakes

Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Inventaires
    Vérifier La Recherche     th    INV-4609      ${CHAMP_NUM_TRANSACTION_INVENTAIRE}

Rechercher Par Date
    [Documentation]    Vérifie que la recherche par date fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Inventaires
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Inventaires
    Vérifier La Recherche     td[1]    2026-08-07   ${CHAMP_DATE_INVENTAIRE}

Rechercher Par Modifié Par
    [Documentation]    Vérifie que la recherche par utilisateur ayant modifié (Updated By) fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Inventaires
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Inventaires
    Vérifier La Recherche     td[6]    Ahmed    ${CHAMP_MODIFIE_PAR_INVENTAIRE}

Rechercher Par Créé Par
    [Documentation]    Vérifie que la recherche par utilisateur ayant créé (Created By) fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Inventaires
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Inventaires
    Vérifier La Recherche     td[7]    Ahmed    ${CHAMP_CREE_PAR_INVENTAIRE}

Rechercher Par Date De Création
    [Documentation]    Vérifie la recherche d'un Inventaire par sa date de création (Créé le).
    Vérifier La Visibilité Des Champs De Recherche Inventaires
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Inventaires
    Vérifier La Recherche     td[8]    2026-08-07    ${CHAMP_CREE_LE_INVENTAIRE}

Rechercher Par Date De Modification
    [Documentation]    Vérifie la recherche d'un Inventaire par sa date de modification (Modifié le).
    Vérifier La Visibilité Des Champs De Recherche Inventaires
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Inventaires
    Vérifier La Recherche     td[9]    2026-08-07    ${CHAMP_MODIFIE_LE_INVENTAIRE}

Rechercher Par Méthode
    [Documentation]    Vérifie que la recherche par méthode fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Inventaires
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_METHODE_INVENTAIRE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[2]  ${CHAMP_METHODE_INVENTAIRE}

Rechercher Par Forme Galénique
    [Documentation]    Vérifie que la recherche par forme galénique fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Inventaires
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_FORME_GALENIQUE_INVENTAIRE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]  ${CHAMP_FORME_GALENIQUE_INVENTAIRE}

Rechercher Par Zone
    [Documentation]    Vérifie que la recherche par zone fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Inventaires
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_ZONE_INVENTAIRE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[4]  ${CHAMP_ZONE_INVENTAIRE}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Inventaires
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_INVENTAIRE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[5]  ${CHAMP_STATUT_INVENTAIRE}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Inventaires
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_INVENTAIRE}
    Wait Until Element Is Visible  ${CHAMP_DATE_INVENTAIRE}
     Wait Until Element Is Visible  ${CHAMP_METHODE_INVENTAIRE}
     Wait Until Element Is Visible  ${CHAMP_FORME_GALENIQUE_INVENTAIRE}
    Wait Until Element Is Visible    ${CHAMP_ZONE_INVENTAIRE}
     Wait Until Element Is Visible  ${CHAMP_STATUT_INVENTAIRE}
    Wait Until Element Is Visible    ${CHAMP_MODIFIE_PAR_INVENTAIRE}
    Wait Until Element Is Visible    ${CHAMP_CREE_PAR_INVENTAIRE}
    Wait Until Element Is Visible    ${CHAMP_CREE_LE_INVENTAIRE}
    Wait Until Element Is Visible    ${CHAMP_MODIFIE_LE_INVENTAIRE}

Vérifier Que Le Champ De Recherche Est Vide Inventaires
    ${num_transaction} =    Get Value    ${CHAMP_NUM_TRANSACTION_INVENTAIRE}
    ${date} =    Get Value    ${CHAMP_DATE_INVENTAIRE}
    ${modifie_par} =    Get Value    ${CHAMP_MODIFIE_PAR_INVENTAIRE}
    ${cree_par} =    Get Value    ${CHAMP_CREE_PAR_INVENTAIRE}
    ${cree_le} =    Get Value    ${CHAMP_CREE_LE_INVENTAIRE}
    ${modifie_le} =    Get Value    ${CHAMP_MODIFIE_LE_INVENTAIRE}

     Should Be Empty    ${num_transaction}
     Should Be Empty    ${date}
     Should Be Empty    ${modifie_par}
     Should Be Empty    ${cree_par}
     Should Be Empty    ${cree_le}
     Should Be Empty    ${modifie_le}

Vérifier Bouton Demander mon inventaire
     Wait Until Element Is Visible    ${BOUTON_DEMANDER_MON_INVENTAIRE}    timeout=10s
      click element         ${BOUTON_DEMANDER_MON_INVENTAIRE}
      wait until page contains         Bienvenue dans l’inventaire guidé      10s
       Go To    ${BASE_URL}/stock/stocktakes
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s

Vérifier Bouton Démarrer l’inventaire guidé
     Wait Until Element Is Visible    ${BOUTON_DEMArrer_INVENTAIRE}    timeout=10s
      click element         ${BOUTON_DEMArrer_INVENTAIRE}
      wait until page contains    Gagner du temps et commandez votre inventaire Sobrus par téléphone 0530500500 Ou envoyez un message.      10s
       Go To    ${BASE_URL}/stock/stocktakes
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s


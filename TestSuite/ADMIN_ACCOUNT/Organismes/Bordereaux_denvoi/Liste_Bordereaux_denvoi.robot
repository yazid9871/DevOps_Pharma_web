*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Bordereaux d'envoi"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste Bordereaux d'envoi


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Bordereaux d'envoi fonctionne correctement
    Accéder à la page    payers/dispatchslips
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier Le Bouton "créer Bordereaux d'envoi"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Bordereaux d'envoi
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    organisme     payers/dispatchslips

Rechercher Par Payeur
    [Documentation]    Vérifie que la recherche par payeur fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Bordereaux d'envoi
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_PAYEUR_BORDEREAU_ENVOI}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    th  ${CHAMP_PAYEUR_BORDEREAU_ENVOI}

Rechercher Par Date
    [Documentation]    Vérifie que la recherche par date fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Bordereaux d'envoi
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bordereaux d'envoi
    Vérifier La Recherche     td[1]    2026-08-03   ${CHAMP_DATE_BORDEREAU_ENVOI}

Vérifier La Recherche Par Total Client
    [Documentation]    Vérifie la recherche d'un Bordereau d'envoi par son total client.
    Vérifier La Visibilité Des Champs De Recherche Bordereaux d'envoi
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bordereaux d'envoi
    Vérifier La Recherche     td[2]    120    ${CHAMP_TOTAL_CLIENT_BORDEREAU_ENVOI}

Vérifier La Recherche Par Total Organisme
    [Documentation]    Vérifie la recherche d'un Bordereau d'envoi par son total organisme.
    Vérifier La Visibilité Des Champs De Recherche Bordereaux d'envoi
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bordereaux d'envoi
    Vérifier La Recherche     td[3]    50    ${CHAMP_TOTAL_ORGANISME_BORDEREAU_ENVOI}

Vérifier La Recherche Par Total
    [Documentation]    Vérifie la recherche d'un Bordereau d'envoi par son montant total.
    Vérifier La Visibilité Des Champs De Recherche Bordereaux d'envoi
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bordereaux d'envoi
    Vérifier La Recherche     td[4]    170    ${CHAMP_TOTAL_BORDEREAU_ENVOI}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Bordereaux d'envoi
    Wait Until Element Is Visible  ${CHAMP_PAYEUR_BORDEREAU_ENVOI}
    Wait Until Element Is Visible  ${CHAMP_DATE_BORDEREAU_ENVOI}
     Wait Until Element Is Visible  ${CHAMP_TOTAL_CLIENT_BORDEREAU_ENVOI}
    Wait Until Element Is Visible    ${CHAMP_TOTAL_ORGANISME_BORDEREAU_ENVOI}
    Wait Until Element Is Visible    ${CHAMP_TOTAL_BORDEREAU_ENVOI}

Vérifier Que Le Champ De Recherche Est Vide Bordereaux d'envoi
    ${date} =    Get Value    ${CHAMP_DATE_BORDEREAU_ENVOI}
    ${total_client} =    Get Value    ${CHAMP_TOTAL_CLIENT_BORDEREAU_ENVOI}
    ${total_organisme} =    Get Value    ${CHAMP_TOTAL_ORGANISME_BORDEREAU_ENVOI}
    ${total} =    Get Value    ${CHAMP_TOTAL_BORDEREAU_ENVOI}

     Should Be Empty    ${date}
     Should Be Empty    ${total_client}
     Should Be Empty    ${total_organisme}
     Should Be Empty    ${total}

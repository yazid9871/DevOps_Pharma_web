*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Paiements Fatourati"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Paiements Fatourati




*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Paiements Fatourati fonctionne correctement
    Accéder à la page    customers/fatourati/transactions
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent


Rechercher Par Client
    [Documentation]    Vérifie que la recherche par Client fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche
    Vérifier La Recherche     th   soraya      ${CHAMP_CLIENT_PAIEMENT}

Rechercher Par Montant Du Paiement
    [Documentation]    Vérifie que la recherche par montant du paiement fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
    Vérifier La Recherche     td[1]    100      ${CHAMP_MONTANT_PAIEMENT}

Vérifier La Recherche Par Date De Génération
    [Documentation]    Vérifie la recherche d'un Paiement Fatourati par sa date de génération.
    [Tags]    module:paiements-fatourati
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
    Vérifier La Recherche     td[2]     2026-06-09    ${CHAMP_DATE_PAIEMENT}

Vérifier La Recherche Par Statut
    [Documentation]    Vérifie la recherche d'un Paiement Fatourati par son statut.
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_PAIEMENT}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]    ${CHAMP_STATUT_PAIEMENT}

Vérifier Le Bouton " Synchroniser avec CMI "
    [Documentation]    Vérifie la présence de bouton Synchroniser avec CMI sur la page
   Vérifier Bouton Synchroniser avec CMI

*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche
    Wait Until Element Is Visible  ${CHAMP_CLIENT_PAIEMENT}
    Wait Until Element Is Visible  ${CHAMP_MONTANT_PAIEMENT}
    Wait Until Element Is Visible  ${CHAMP_DATE_PAIEMENT}
    Wait Until Element Is Visible  ${CHAMP_STATUT_PAIEMENT}


Vérifier Que Le Champ De Recherche Est Vide
    ${client} =    Get Value    ${CHAMP_CLIENT_PAIEMENT}
    ${montant} =    Get Value    ${CHAMP_MONTANT_PAIEMENT}
    ${date} =    Get Value    ${CHAMP_DATE_PAIEMENT}

    Should Be Empty    ${client}
    Should Be Empty    ${montant}
    Should Be Empty    ${date}

Vérifier Bouton Synchroniser avec CMI
      sleep    1s
      click element     ${BOUTON_syn_CMI}
    wait until page contains     Synchronisation réussie     10s
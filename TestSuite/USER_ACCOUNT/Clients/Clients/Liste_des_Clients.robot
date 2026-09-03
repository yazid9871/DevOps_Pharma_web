*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des clients"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des clients



*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau clients fonctionne correctement
    Accéder à la page    customers
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier Affichage KPI Et Visibilité Des Colonnes
    [Documentation]    Vérifie que les indicateurs KPI et les colonnes du tableau sont visibles
    Vérifier Affichage KPI
    Vérifier Visibilité Des Colonnes
Vérifier La Visibilité Et La Fonctionnalité De L'Icône Éditer
    [Documentation]    Vérifie que l'icône d'édition est visible et fonctionnelle
    Vérifier Visibilité Icône Éditer
    Vérifier Fonctionnalité Icône Éditer     Modifier client     customers
Vérifier La Visibilité Et La Fonctionnalité De L'Icône Envoyer Message
    [Documentation]    Vérifie que l'icône d'envoi de message est visible et fonctionnelle
    Vérifier Visibilité Icône Envoyer Message
    Vérifier Fonctionnalité Icône Envoyer Message
Vérifier Le Bouton "Clients Archivés"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page clients
    Vérifier Bouton Clients Archivés
Vérifier Le Bouton "Importer Des Clients"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page clients
    Vérifier Bouton Importer Clients
Vérifier Le Bouton "créer Client"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page clients
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Créer un nouveau client     customers
Rechercher Par Nom
    [Documentation]    Vérifie que la recherche par nom fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche
    Vérifier La Recherche     th    MER-TEST-VENT   ${CHAMP_NOM_CLIENT}

Vérifier La Recherche Par Email
    [Documentation]    Vérifie la recherche d'un client par son adresse email.
   Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
    Vérifier La Recherche     td[1]    MER-TEST@gmail.com   ${CHAMP_EMAIL}


Vérifier La Recherche Par Téléphone
    [Documentation]    Vérifie la recherche d'un client par son numéro de téléphone.
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
    Vérifier La Recherche     td[2]    0625148596    ${CHAMP_TÉLÉPHONE}

Rechercher Par Organisme AMO
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_ORGANISME_AMO}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]  ${CHAMP_ORGANISME_AMO}

Rechercher Par Numéro D'immatriculation AMO
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
   Vérifier La Recherche     td[4]    12    ${CHAMP_N_IMMATRICULATION_AMO}

Rechercher Par Organisme AMC
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_ORGANISME_AMC}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[5]  ${CHAMP_ORGANISME_AMC}
Rechercher Par Numéro D'immatriculation AMC
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
   Vérifier La Recherche     td[6]    123123    ${CHAMP_N_IMMATRICULATION_AMC}
*** Keywords ***

# --- Boutons Archivés / Import ---
Vérifier Bouton Clients Archivés
    [Documentation]    vérifier la présence et le fonctionnement du bouton "Clients archivés"
    Wait Until Element Is Visible    ${BOUTON_ARCHIVES}    timeout=10s
      click element         ${BOUTON_ARCHIVES}
      wait until page contains     Clients archivés     10s
       wait until page does not contain    Nombre de clients
       wait until page does not contain    Client avec n° téléphone
       Go To    ${BASE_URL}/customers
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s

Vérifier Bouton Importer Clients
    [Documentation]     vérifier la présence et le fonctionnement du bouton "Importer des clients"
     sleep    1s
    Wait Until Element Is Visible    ${BOUTON_IMPORTER}    timeout=10s
      click element     ${BOUTON_IMPORTER}
      wait until page contains     Importer clients    10s
       Go To    ${BASE_URL}/customers
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s

Vérifier La Visibilité Des Champs De Recherche
    Wait Until Element Is Visible  ${CHAMP_NOM_CLIENT}
    Wait Until Element Is Visible  ${CHAMP_EMAIL}
     Wait Until Element Is Visible  ${CHAMP_TÉLÉPHONE}
     Wait Until Element Is Visible  ${CHAMP_ORGANISME_AMO}
    Wait Until Element Is Visible    ${CHAMP_N_IMMATRICULATION_AMO}
     Wait Until Element Is Visible  ${CHAMP_ORGANISME_AMC}
    Wait Until Element Is Visible    ${CHAMP_N_IMMATRICULATION_AMC}

Vérifier Que Le Champ De Recherche Est Vide
    ${name} =    Get Value    ${CHAMP_NOM_CLIENT}
    ${mail} =    Get Value    ${CHAMP_EMAIL}
    ${phone} =    Get Value    ${CHAMP_TÉLÉPHONE}
    ${amo} =    Get Value    ${CHAMP_N_IMMATRICULATION_AMO}
    ${amc} =    Get Value    ${CHAMP_N_IMMATRICULATION_AMC}

     Should Be Empty    ${name}
     Should Be Empty    ${mail}
     Should Be Empty    ${phone}
     Should Be Empty    ${amo}
     Should Be Empty    ${amc}


# --- KPI et colonnes ---
Vérifier Affichage KPI
    [Documentation]    vérifier que les indicateurs KPI sont affichés en haut de la page
      Execute JavaScript  window.scrollTo(0,  0)
    sleep    10s
    wait until page contains    Nombre de clients
    wait until page contains   Client avec n° téléphone
    wait until page contains   Clients avec e-mail
    wait until page contains   Clients avec MySobrus
Vérifier Visibilité Des Colonnes
    [Documentation]    TODO - vérifier que les colonnes du tableau sont visibles
      wait until page contains    Nom
    wait until page contains     E-mail
    wait until page contains     Téléphone
    wait until page contains     Organisme AMO
     wait until page contains    N° Immatriculation AMO
    wait until page contains     Organisme AMC
    wait until page contains     N° Immatriculation AMC
    wait until page contains    Points de fidélité
    wait until page contains    Solde


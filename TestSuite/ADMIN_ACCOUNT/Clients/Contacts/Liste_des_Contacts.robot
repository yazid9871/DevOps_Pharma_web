*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Contacts"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Contacts


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Contacts fonctionne correctement
    Accéder à la page    customers/contacts
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent


Vérifier La Visibilité Et La Fonctionnalité De L'Icône Éditer
    [Documentation]    Vérifie que l'icône d'édition est visible et fonctionnelle
    Vérifier Visibilité Icône Éditer
    Vérifier Fonctionnalité Icône Éditer     Modifier le contac      customers/contacts
Vérifier Le Boutons "créer Contacts"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Contacts
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Créer un nouveau contact     customers/contacts
Rechercher Par Prénom
    [Documentation]    Vérifie que la recherche par Prénom fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche
    Vérifier La Recherche     th    HAOUL      ${CHAMP_PRENOM_CONTACT}

Rechercher Par Nom
    [Documentation]    Vérifie que la recherche par nom fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
    Vérifier La Recherche     td[1]    sadsdasd   ${CHAMP_NOM_CONTACT}
Vérifier La Recherche Par Email
    [Documentation]    Vérifie la recherche d'un Contact par son adresse email.
    [Tags]    PSV-9
   Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
    Vérifier La Recherche     td[2]     youssef.s@sobrus.com    ${CHAMP_EMAIL}


Vérifier La Recherche Par Téléphone
    [Documentation]    Vérifie la recherche d'un Contact par son numéro de téléphone.
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
    Vérifier La Recherche     td[3]    062548722    ${CHAMP_TÉLÉPHONE}


Rechercher Par Titre
    [Documentation]    Vérifie la recherche d'un Contact par Titre
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
   Vérifier La Recherche     td[4]    12    ${CHAMP_TITRE_CONTACT}

Rechercher Par nom client
    [Documentation]    Vérifie la recherche d'un Contact par Nom de client
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide
   Vérifier La Recherche     td[5]    kjgljg    ${CHAMP_CLIENT_CONTACT}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche
    Wait Until Element Is Visible  ${CHAMP_PRENOM_CONTACT}
        Wait Until Element Is Visible  ${CHAMP_NOM_CONTACT}
    Wait Until Element Is Visible  ${CHAMP_EMAIL}
     Wait Until Element Is Visible  ${CHAMP_TÉLÉPHONE}
     Wait Until Element Is Visible  ${CHAMP_TITRE_CONTACT}


Vérifier Que Le Champ De Recherche Est Vide
    ${prenom} =    Get Value    ${CHAMP_PRENOM_CONTACT}
    ${name} =    Get Value    ${CHAMP_NOM_CONTACT}
    ${mail} =    Get Value    ${CHAMP_EMAIL}
    ${phone} =    Get Value    ${CHAMP_TÉLÉPHONE}
    ${titre} =    Get Value    ${CHAMP_TITRE_CONTACT}

     Should Be Empty    ${name}
     Should Be Empty    ${prenom}
     Should Be Empty    ${mail}
     Should Be Empty    ${phone}
     Should Be Empty    ${titre}





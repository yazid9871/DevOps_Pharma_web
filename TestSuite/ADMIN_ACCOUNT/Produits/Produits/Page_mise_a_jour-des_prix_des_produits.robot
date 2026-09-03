*** Settings ***
Documentation     Tests fonctionnels de la page "Mise à jour des prix des produits"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Mise à jour des prix des produits



*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Mise à jour des prix des produits
    ...                fonctionne correctement
    Accéder à la page    products/suggested-prices
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent


Vérifier La Visibilité Des Boutons D'action Par Ligne : BOUTON_AJOUTER_DEUXIEME_PRIX
    [Documentation]    Vérifie que le bouton
    Wait Until Element Is Visible    ${BOUTON_AJOUTER_DEUXIEME_PRIX}    timeout=10s
Vérifier La Visibilité Des Boutons D'action Par Ligne : BOUTON_REMPLACER_PRIX
    [Documentation]    Vérifie que le bouton
    Wait Until Element Is Visible    ${BOUTON_REMPLACER_PRIX}    timeout=10s
Vérifier La Visibilité Des Boutons D'action Par Ligne : BOUTON_IGNORER_PRIX
    [Documentation]    Vérifie que le bouton
    Wait Until Element Is Visible    ${BOUTON_IGNORER_PRIX}    timeout=10s

Rechercher Par Nom
    [Documentation]    Vérifie que la recherche par Nom fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche
    Vérifier La Recherche     th     PEDIAKID GOMMES OMEGA 3 B60      ${CHAMP_NOM_MAJ_PRIX}

Rechercher Par PPV
    [Documentation]    Vérifie que la recherche par PPV fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier La Recherche     td[1]     139.00   ${CHAMP_PPV_MAJ_PRIX}

Rechercher Par PPV Mis À Jour
    [Documentation]    Vérifie que la recherche par PPV (mis à jour) fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier La Recherche     td[2]     31.43   ${CHAMP_PPV_MAJ_MAJ_PRIX}

Rechercher Par PPH
    [Documentation]    Vérifie que la recherche par PPH fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier La Recherche     td[3]     97.30   ${CHAMP_PPH_MAJ_PRIX}

Rechercher Par PPH Mis À Jour
    [Documentation]    Vérifie que la recherche par PPH (mis à jour) fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    Vérifier La Recherche     td[4]     22.00   ${CHAMP_PPH_MAJ_MAJ_PRIX}


*** Keywords ***

Vérifier La Visibilité Des Champs De Recherche
    Wait Until Element Is Visible  ${CHAMP_NOM_MAJ_PRIX}
    Wait Until Element Is Visible  ${CHAMP_PPV_MAJ_PRIX}
    Wait Until Element Is Visible  ${CHAMP_PPV_MAJ_MAJ_PRIX}
    Wait Until Element Is Visible  ${CHAMP_PPH_MAJ_PRIX}
    Wait Until Element Is Visible  ${CHAMP_PPH_MAJ_MAJ_PRIX}

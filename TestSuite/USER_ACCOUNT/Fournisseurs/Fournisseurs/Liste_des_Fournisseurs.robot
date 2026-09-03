*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Fournisseurs"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Fournisseurs


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Fournisseurs fonctionne correctement
    Accéder à la page    suppliers
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier Le Bouton "Historique des suggestions"
    [Documentation]   Vérifie la présence des boutons d'actions globales sur la page Fournisseurs
    Vérifier Bouton Historique des suggestions

Vérifier Le Bouton "Suggérer Un Nouveau Fournisseur"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Fournisseurs
   Vérifier Bouton créer / Suggérer     ${BOUTON_SUGGERER_FOURNISSEUR}    Suggérer un fournisseur     suppliers

Rechercher Par Nom
    [Documentation]    Vérifie que la recherche par nom fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Fournisseurs
    Vérifier La Recherche     td[2]     Grossiste GPM MARCHE      ${CHAMP_NOM_FOURNISSEUR}

Rechercher Par Téléphone
    [Documentation]    Vérifie que la recherche par téléphone fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Fournisseurs
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Fournisseurs
    Vérifier La Recherche     td[3]    062548722   ${CHAMP_TELEPHONE_FOURNISSEUR}

Rechercher Par Ville
    [Documentation]    Vérifie que la recherche par ville fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Fournisseurs
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Fournisseurs
    Vérifier La Recherche     td[4]     441    ${CHAMP_VILLE_FOURNISSEUR}

Vérifier La Recherche Par Solde
    [Documentation]    Vérifie la recherche d'un Fournisseur par son solde.
    Vérifier La Visibilité Des Champs De Recherche Fournisseurs
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Fournisseurs
    Vérifier La Recherche     td[5]    0    ${CHAMP_SOLDE_FOURNISSEUR}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Fournisseurs
    Wait Until Element Is Visible  ${CHAMP_NOM_FOURNISSEUR}
    Wait Until Element Is Visible  ${CHAMP_TELEPHONE_FOURNISSEUR}
     Wait Until Element Is Visible  ${CHAMP_VILLE_FOURNISSEUR}
    Wait Until Element Is Visible    ${CHAMP_SOLDE_FOURNISSEUR}

Vérifier Que Le Champ De Recherche Est Vide Fournisseurs
    ${nom} =    Get Value    ${CHAMP_NOM_FOURNISSEUR}
    ${telephone} =    Get Value    ${CHAMP_TELEPHONE_FOURNISSEUR}
    ${ville} =    Get Value    ${CHAMP_VILLE_FOURNISSEUR}
    ${solde} =    Get Value    ${CHAMP_SOLDE_FOURNISSEUR}

     Should Be Empty    ${nom}
     Should Be Empty    ${telephone}
     Should Be Empty    ${ville}
     Should Be Empty    ${solde}
Vérifier Bouton Historique des suggestions
     Wait Until Element Is Visible    ${BOUTON_HISTORIQUE_SUGGESTIONS}    timeout=10s
      click element         ${BOUTON_HISTORIQUE_SUGGESTIONS}
      wait until page contains     Suggestions de fournisseurs     10s
       Go To    ${BASE_URL}/suppliers
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
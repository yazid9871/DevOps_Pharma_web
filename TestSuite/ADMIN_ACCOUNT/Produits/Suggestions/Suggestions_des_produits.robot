*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Suggestions des produits"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Suggestions des produits



*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Suggestions des produits fonctionne correctement
    Accéder à la page    products/suggestions
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent


Vérifier Le Bouton "Suggérer Un Nouveau Produit"
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page Suggestions des produits
   Vérifier Bouton créer / Suggérer     ${BOUTON_SUGGERER_PRODUIT}    Suggérer produit     products/suggestions

Rechercher Par Nom
    [Documentation]    Vérifie que la recherche par Nom fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche
    Vérifier La Recherche     th     Test modification de prix     ${CHAMP_NOM_PRODUIT}


Rechercher Par Forme Galénique
    [Documentation]    Vérifie que la recherche par forme galénique fonctionne correctement
    Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_FORME_GALENIQUE_PRODUIT}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[1]             ${CHAMP_FORME_GALENIQUE_PRODUIT}



Rechercher Par statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_PRODUIT}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche   td[2]         ${CHAMP_STATUT_PRODUIT}


Vérifier La Recherche Par Raison
    [Documentation]    Vérifie la recherche d'un Produit par sa raison de désactivation.
    Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_RAISON_SUGGERE_PRODUIT}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]       ${CHAMP_RAISON_SUGGERE_PRODUIT}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche
    Wait Until Element Is Visible  ${CHAMP_NOM_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_FORME_GALENIQUE_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_RAISON_SUGGERE_PRODUIT}


Vérifier Que Le Champ De Recherche Est Vide
    ${name} =    Get Value    ${CHAMP_NOM_PRODUIT}


     Should Be Empty    ${name}

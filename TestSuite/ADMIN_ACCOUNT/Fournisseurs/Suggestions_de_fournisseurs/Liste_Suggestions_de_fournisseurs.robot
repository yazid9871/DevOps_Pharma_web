*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Suggestions de fournisseurs"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste Suggestions de fournisseurs


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Suggestions de fournisseurs fonctionne correctement
    Accéder à la page    suppliers/suggestions
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier Le Bouton "Suggérer Un Nouveau Fournisseur"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Suggestions de fournisseurs
   Vérifier Bouton créer / Suggérer     ${BOUTON_SUGGERER_FOURNISSEUR}    fournisseur     suppliers/suggestions



Rechercher Par Nom
    [Documentation]    Vérifie que la recherche par nom fonctionne correctement
   Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Suggestions de fournisseurs
    Vérifier La Recherche     th[2]    Fournis_Test   ${CHAMP_NOM_SUGGESTION_FOURNISSEUR}

Rechercher Par Téléphone
    [Documentation]    Vérifie que la recherche par téléphone fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Suggestions de fournisseurs
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Suggestions de fournisseurs
    Vérifier La Recherche     td[1]    jj979    ${CHAMP_TELEPHONE_SUGGESTION_FOURNISSEUR}

Rechercher Par Ville
    [Documentation]    Vérifie que la recherche par ville fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Suggestions de fournisseurs
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Suggestions de fournisseurs
    Vérifier La Recherche     td[2]    	MEKNES    ${CHAMP_VILLE_SUGGESTION_FOURNISSEUR}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Suggestions de fournisseurs
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_SUGGESTION_FOURNISSEUR}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]  ${CHAMP_STATUT_SUGGESTION_FOURNISSEUR}

Rechercher Par Raison
    [Documentation]    Vérifie que la recherche par raison fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Suggestions de fournisseurs
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_RAISON_SUGGESTION_FOURNISSEUR}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[4]  ${CHAMP_RAISON_SUGGESTION_FOURNISSEUR}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Suggestions de fournisseurs
    Wait Until Element Is Visible  ${CHAMP_SUPPLIER_SUGGESTION_FOURNISSEUR}
    Wait Until Element Is Visible  ${CHAMP_NOM_SUGGESTION_FOURNISSEUR}
     Wait Until Element Is Visible  ${CHAMP_TELEPHONE_SUGGESTION_FOURNISSEUR}
     Wait Until Element Is Visible  ${CHAMP_VILLE_SUGGESTION_FOURNISSEUR}
    Wait Until Element Is Visible    ${CHAMP_STATUT_SUGGESTION_FOURNISSEUR}
    Wait Until Element Is Visible    ${CHAMP_RAISON_SUGGESTION_FOURNISSEUR}

Vérifier Que Le Champ De Recherche Est Vide Suggestions de fournisseurs
    ${fournisseur} =    Get Value    ${CHAMP_SUPPLIER_SUGGESTION_FOURNISSEUR}
    ${nom} =    Get Value    ${CHAMP_NOM_SUGGESTION_FOURNISSEUR}
    ${telephone} =    Get Value    ${CHAMP_TELEPHONE_SUGGESTION_FOURNISSEUR}
    ${ville} =    Get Value    ${CHAMP_VILLE_SUGGESTION_FOURNISSEUR}

     Should Be Empty    ${fournisseur}
     Should Be Empty    ${nom}
     Should Be Empty    ${telephone}
     Should Be Empty    ${ville}

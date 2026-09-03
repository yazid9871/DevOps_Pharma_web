*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Entrées confrères"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste Entrées confrères


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Entrées confrères fonctionne correctement
    Accéder à la page    colleagues/purchases
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier Le Bouton "créer Entrées confrères"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Entrées confrères
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    confrère     colleagues/purchases

Rechercher Par Confrère
    [Documentation]    Vérifie que la recherche par confrère fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Entrées confrères
    Vérifier La Recherche     th    sada      ${CHAMP_CONFRERE_ENTREE_CONFRERE}

Rechercher Par Date
    [Documentation]    Vérifie que la recherche par date fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Entrées confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Entrées confrères
    Vérifier La Recherche     td[1]    2025-10-22   ${CHAMP_DATE_ENTREE_CONFRERE}

Rechercher Par Date De Création
    [Documentation]    Vérifie la recherche d'une Entrée confrère par sa date de création (Créé le).
    Vérifier La Visibilité Des Champs De Recherche Entrées confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Entrées confrères
    Vérifier La Recherche     td[2]    2025-10-22    ${CHAMP_CREE_LE_ENTREE_CONFRERE}

Vérifier La Recherche Par Total
    [Documentation]    Vérifie la recherche d'une Entrée confrère par son montant total.
    Vérifier La Visibilité Des Champs De Recherche Entrées confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Entrées confrères
    Vérifier La Recherche     td[4]    24    ${CHAMP_TOTAL_ENTREE_CONFRERE}

Rechercher Par Champ De Tarification
    [Documentation]    Vérifie que la recherche par champ de tarification fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Entrées confrères
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_CHAMP_TARIFICATION_ENTREE_CONFRERE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]  ${CHAMP_CHAMP_TARIFICATION_ENTREE_CONFRERE}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Entrées confrères
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_ENTREE_CONFRERE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[5]  ${CHAMP_STATUT_ENTREE_CONFRERE}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Entrées confrères
    Wait Until Element Is Visible  ${CHAMP_CONFRERE_ENTREE_CONFRERE}
    Wait Until Element Is Visible  ${CHAMP_DATE_ENTREE_CONFRERE}
     Wait Until Element Is Visible  ${CHAMP_CREE_LE_ENTREE_CONFRERE}
     Wait Until Element Is Visible  ${CHAMP_CHAMP_TARIFICATION_ENTREE_CONFRERE}
    Wait Until Element Is Visible    ${CHAMP_TOTAL_ENTREE_CONFRERE}
    Wait Until Element Is Visible    ${CHAMP_STATUT_ENTREE_CONFRERE}

Vérifier Que Le Champ De Recherche Est Vide Entrées confrères
    ${confrere} =    Get Value    ${CHAMP_CONFRERE_ENTREE_CONFRERE}
    ${date} =    Get Value    ${CHAMP_DATE_ENTREE_CONFRERE}
    ${cree_le} =    Get Value    ${CHAMP_CREE_LE_ENTREE_CONFRERE}
    ${total} =    Get Value    ${CHAMP_TOTAL_ENTREE_CONFRERE}

     Should Be Empty    ${confrere}
     Should Be Empty    ${date}
     Should Be Empty    ${cree_le}
     Should Be Empty    ${total}

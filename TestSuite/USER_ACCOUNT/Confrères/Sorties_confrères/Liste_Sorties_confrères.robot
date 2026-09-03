*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Sorties confrères"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste Sorties confrères


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Sorties confrères fonctionne correctement
    Accéder à la page    colleagues/sales
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier Le Bouton "créer Sorties confrères"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Sorties confrères
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    confrère     colleagues/sales

Rechercher Par Confrère
    [Documentation]    Vérifie que la recherche par confrère fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Sorties confrères
    Vérifier La Recherche     th    sada      ${CHAMP_CONFRERE_SORTIE_CONFRERE}

Rechercher Par Date
    [Documentation]    Vérifie que la recherche par date fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Sorties confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Sorties confrères
    Vérifier La Recherche     td[1]    2026-01-26   ${CHAMP_DATE_SORTIE_CONFRERE}

Rechercher Par Date De Création
    [Documentation]    Vérifie la recherche d'une Sortie confrère par sa date de création (Créé le).
    Vérifier La Visibilité Des Champs De Recherche Sorties confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Sorties confrères
    Vérifier La Recherche     td[2]    2026-01-26    ${CHAMP_CREE_LE_SORTIE_CONFRERE}

Vérifier La Recherche Par Total
    [Documentation]    Vérifie la recherche d'une Sortie confrère par son montant total.
    Vérifier La Visibilité Des Champs De Recherche Sorties confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Sorties confrères
    Vérifier La Recherche     td[4]    105    ${CHAMP_TOTAL_SORTIE_CONFRERE}

Rechercher Par Champ De Tarification
    [Documentation]    Vérifie que la recherche par champ de tarification fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Sorties confrères
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_CHAMP_TARIFICATION_SORTIE_CONFRERE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]  ${CHAMP_CHAMP_TARIFICATION_SORTIE_CONFRERE}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Sorties confrères
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_SORTIE_CONFRERE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[5]  ${CHAMP_STATUT_SORTIE_CONFRERE}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Sorties confrères
    Wait Until Element Is Visible  ${CHAMP_CONFRERE_SORTIE_CONFRERE}
    Wait Until Element Is Visible  ${CHAMP_DATE_SORTIE_CONFRERE}
     Wait Until Element Is Visible  ${CHAMP_CREE_LE_SORTIE_CONFRERE}
     Wait Until Element Is Visible  ${CHAMP_CHAMP_TARIFICATION_SORTIE_CONFRERE}
    Wait Until Element Is Visible    ${CHAMP_TOTAL_SORTIE_CONFRERE}
    Wait Until Element Is Visible    ${CHAMP_STATUT_SORTIE_CONFRERE}

Vérifier Que Le Champ De Recherche Est Vide Sorties confrères
    ${confrere} =    Get Value    ${CHAMP_CONFRERE_SORTIE_CONFRERE}
    ${date} =    Get Value    ${CHAMP_DATE_SORTIE_CONFRERE}
    ${cree_le} =    Get Value    ${CHAMP_CREE_LE_SORTIE_CONFRERE}
    ${total} =    Get Value    ${CHAMP_TOTAL_SORTIE_CONFRERE}

     Should Be Empty    ${confrere}
     Should Be Empty    ${date}
     Should Be Empty    ${cree_le}
     Should Be Empty    ${total}

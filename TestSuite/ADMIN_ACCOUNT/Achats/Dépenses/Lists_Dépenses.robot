*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Dépenses"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Dépenses



*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la page initiale de la pagination du tableau Dépenses
    ...                s'affiche correctement. Le tableau ne contient actuellement aucune
    ...                dépense : les clics "Suivant"/"Précédent" ne sont donc pas testés,
    ...                faute d'une deuxième page à atteindre.
    Accéder à la page    expenses
    Tester Page Initiale

Vérifier Le Bouton "Créer"
    [Documentation]    Vérifie la présence du bouton d'action globale "Créer" sur la page
    ...                Dépenses et que son clic ouvre bien le formulaire de création d'une
    ...                nouvelle dépense.
    Accéder à la page    expenses
    Vérifier Bouton créer / Suggérer     xpath=//*[@data-testid="créer"]    Créer une nouvelle dépense    expenses

Vérifier Le Bouton "Imprimer"
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page Dépenses.
    ...                Imprimer déclenche une vraie génération de document : le bouton n'est
    ...                donc vérifié qu'en visibilité, sans être cliqué.
    Accéder à la page    expenses
    Wait Until Element Is Visible    ${BOUTON_IMPRIMER_DEPENSE}    timeout=10s

Vérifier La Visibilité Des Champs De Recherche
    [Documentation]    Vérifie que les champs de recherche sont visibles
    Accéder à la page    expenses
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche

Rechercher Par Catégorie
    [Documentation]    Vérifie que le champ de recherche par Catégorie est visible et
    ...                fonctionnel. Aucune catégorie de dépense n'est configurée sur ce
    ...                compte de test : la sélection d'une option réelle dans la liste
    ...                déroulante n'est donc pas testée, faute de données disponibles.
    Accéder à la page    expenses
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Wait Until Element Is Visible    ${CHAMP_CATEGORIE_DEPENSE}

Rechercher Par Libellé
    [Documentation]    Vérifie que la recherche par Libellé fonctionne correctement
    Accéder à la page    expenses
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Recherche     td[2]     loyer test QA     ${CHAMP_LIBELLE_DEPENSE}

Rechercher Par Date
    [Documentation]    Vérifie que la recherche par Date fonctionne correctement
    Accéder à la page    expenses
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Recherche     td[3]     2026-01-01     ${CHAMP_DATE_DEPENSE}

Rechercher Par Montant
    [Documentation]    Vérifie que la recherche par Montant fonctionne correctement
    Accéder à la page    expenses
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Recherche     td[4]     100     ${CHAMP_MONTANT_DEPENSE}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par Statut fonctionne correctement
    Accéder à la page    expenses
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_DEPENSE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[5]    ${CHAMP_STATUT_DEPENSE}


*** Keywords ***

Vérifier La Visibilité Des Champs De Recherche
    Wait Until Element Is Visible  ${CHAMP_CATEGORIE_DEPENSE}
    Wait Until Element Is Visible  ${CHAMP_LIBELLE_DEPENSE}
    Wait Until Element Is Visible  ${CHAMP_DATE_DEPENSE}
    Wait Until Element Is Visible  ${CHAMP_MONTANT_DEPENSE}
    Wait Until Element Is Visible  ${CHAMP_STATUT_DEPENSE}

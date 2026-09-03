*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Commandes groupées"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Commandes groupées


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Commandes groupées fonctionne correctement
    Accéder à la page    purchaseorders?view=grouped
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Rechercher Par Numéro
    [Documentation]    Vérifie que la recherche par numéro fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ Commandes groupées
    Vérifier La Visibilité Des Champs De Recherche Commandes groupées
    Vérifier La Recherche     th    3678      ${CHAMP_NO_BC_GROUPEE}

Rechercher Par Offre
    [Documentation]    Vérifie que la recherche par offre fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Commandes groupées
    Cliquer Sur Actualiser Commandes groupées
    Vérifier Que Le Champ De Recherche Est Vide Commandes groupées
    Vérifier La Recherche     td[1]    ttt   ${CHAMP_OFFRE_BC_GROUPEE}

Rechercher Par Groupe
    [Documentation]    Vérifie que la recherche par groupe fonctionne correctement
     Cliquer Sur Actualiser Commandes groupées
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_GROUPE_BC_GROUPEE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    th[2]  ${CHAMP_GROUPE_BC_GROUPEE}

Rechercher Par Fournisseur
    [Documentation]    Vérifie que la recherche par fournisseur fonctionne correctement
     Cliquer Sur Actualiser Commandes groupées
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_FOURNISSEUR_BC_GROUPEE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]  ${CHAMP_FOURNISSEUR_BC_GROUPEE}

Rechercher Par Date Limite
    [Documentation]    Vérifie que la recherche par date limite (Deadline) fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Commandes groupées
    Cliquer Sur Actualiser Commandes groupées
    Vérifier Que Le Champ De Recherche Est Vide Commandes groupées
    Vérifier La Recherche     td[4]    2027-06-08    ${CHAMP_DEADLINE_BC_GROUPEE}

Rechercher Par Date De Mise À Jour
    [Documentation]    Vérifie que la recherche par date de mise à jour (Updated on) fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Commandes groupées
    Cliquer Sur Actualiser Commandes groupées
    Vérifier Que Le Champ De Recherche Est Vide Commandes groupées
    Vérifier La Recherche     td[5]    2026-08-06    ${CHAMP_MISE_A_JOUR_BC_GROUPEE}

Vérifier La Recherche Par Quantité Totale
    [Documentation]    Vérifie la recherche d'une Commande groupée par sa quantité totale.
    Vérifier La Visibilité Des Champs De Recherche Commandes groupées
    Cliquer Sur Actualiser Commandes groupées
    Vérifier Que Le Champ De Recherche Est Vide Commandes groupées
    Vérifier La Recherche     td[7]    3    ${CHAMP_QTE_TOTALE_BC_GROUPEE}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser Commandes groupées
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_BC_GROUPEE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[8]  ${CHAMP_STATUT_BC_GROUPEE}

Rechercher Par Statut De Livraison
    [Documentation]    Vérifie que la recherche par statut de livraison (Delivery status) fonctionne correctement
     Cliquer Sur Actualiser Commandes groupées
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_LIVRAISON_BC_GROUPEE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[9]  ${CHAMP_STATUT_LIVRAISON_BC_GROUPEE}
*** Keywords ***

Cliquer Sur Rechercher Pour Afficher Le Champ Commandes groupées
    [Documentation]    Clique sur le bouton Rechercher (data-testid en anglais sur cette page) et vérifie que le champ de recherche est visible
    wait until element is visible     ${BOUTON_RECHERCHE_BC_GROUPEE}     10s
    Click Element  ${BOUTON_RECHERCHE_BC_GROUPEE}

Cliquer Sur Actualiser Commandes groupées
    [Documentation]    Clique sur le bouton Rafraichir/Refresh pour réinitialiser ou actualiser la page
    Click Element  ${BOUTON_ACTUALISER_BC_GROUPEE}

Vérifier La Visibilité Des Champs De Recherche Commandes groupées
    Wait Until Element Is Visible  ${CHAMP_NO_BC_GROUPEE}
    Wait Until Element Is Visible  ${CHAMP_OFFRE_BC_GROUPEE}
     Wait Until Element Is Visible  ${CHAMP_GROUPE_BC_GROUPEE}
     Wait Until Element Is Visible  ${CHAMP_MANAGER_BC_GROUPEE}
    Wait Until Element Is Visible    ${CHAMP_FOURNISSEUR_BC_GROUPEE}
     Wait Until Element Is Visible  ${CHAMP_DEADLINE_BC_GROUPEE}
    Wait Until Element Is Visible    ${CHAMP_MISE_A_JOUR_BC_GROUPEE}
    Wait Until Element Is Visible    ${CHAMP_QTE_TOTALE_BC_GROUPEE}
    Wait Until Element Is Visible    ${CHAMP_STATUT_BC_GROUPEE}
    Wait Until Element Is Visible    ${CHAMP_STATUT_LIVRAISON_BC_GROUPEE}

Vérifier Que Le Champ De Recherche Est Vide Commandes groupées
    ${offre} =    Get Value    ${CHAMP_OFFRE_BC_GROUPEE}
    ${deadline} =    Get Value    ${CHAMP_DEADLINE_BC_GROUPEE}
    ${mise_a_jour} =    Get Value    ${CHAMP_MISE_A_JOUR_BC_GROUPEE}
    ${qte_totale} =    Get Value    ${CHAMP_QTE_TOTALE_BC_GROUPEE}

     Should Be Empty    ${offre}
     Should Be Empty    ${deadline}
     Should Be Empty    ${mise_a_jour}
     Should Be Empty    ${qte_totale}

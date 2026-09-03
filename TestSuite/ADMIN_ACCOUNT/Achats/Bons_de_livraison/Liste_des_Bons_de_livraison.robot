*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Bons de livraison"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Bons de livraison


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Bons de livraison fonctionne correctement
    Accéder à la page    deliverynotes
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent
Vérifier Affichage KPI Et Visibilité Des Colonnes
    [Documentation]    Vérifie que les indicateurs KPI et les colonnes du tableau sont visibles
    Vérifier Affichage KPI
    Vérifier Visibilité Des Colonnes
Vérifier La Visibilité Et La Fonctionnalité De L'Icône Imprimer
    [Documentation]    Vérifie que l'icône Imprimer est visible et fonctionnelle
    Vérifier Icône Imprimer          deliverynotes
Vérifier L'Icône Éditer
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    VérifierL'Icône Éditer     Modifier Bon de livraison       deliverynotes
Vérifier Le Bouton Scanner le bon de livraison
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    Vérifier Bouton Scanner le bon de livraison
Vérifier Le Bouton "créer Bons de livraison"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Bons de livraison
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Créer un nouveau bon de livraison       deliverynotes
Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Bons de livraison
    Vérifier La Recherche     th    BL-1621    ${CHAMP_NUM_TRANSACTION_BON_LIVRAISON}

Rechercher Par Fournisseur
    [Documentation]    Vérifie que la recherche par fournisseur fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Bons de livraison
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de livraison
    Vérifier La Recherche     td[1]    Grossiste   ${CHAMP_FOURNISSEUR_BON_LIVRAISON}

Rechercher Par Date Bon De Livraison
    [Documentation]    Vérifie que la recherche par date du bon de livraison fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Bons de livraison
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de livraison
    Vérifier La Recherche     td[2]    2026-08-05    ${CHAMP_DATE_BON_LIVRAISON}

Rechercher Par Date De Création
    [Documentation]    Vérifie la recherche d'un Bon de livraison par sa date de création (Créé le).
     Vérifier La Visibilité Des Champs De Recherche Bons de livraison
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de livraison
   Vérifier La Recherche     td[3]    2026-08-05    ${CHAMP_CREE_LE_BON_LIVRAISON}

Vérifier La Recherche Par Total
    [Documentation]    Vérifie la recherche d'un Bon de livraison par son montant total.
     Vérifier La Visibilité Des Champs De Recherche Bons de livraison
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de livraison
   Vérifier La Recherche     td[4]    806    ${CHAMP_TOTAL_BON_LIVRAISON}

Rechercher Par Référence De Livraison
    [Documentation]    Vérifie la recherche d'un Bon de livraison par sa référence de livraison.
    Vérifier La Visibilité Des Champs De Recherche Bons de livraison
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de livraison
    Vérifier La Recherche     td[5]    gfhy    ${CHAMP_REFERENCE_LIVRAISON_BON_LIVRAISON}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de livraison
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_BON_LIVRAISON}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[6]  ${CHAMP_STATUT_BON_LIVRAISON}
*** Keywords ***

Vérifier La Visibilité Des Champs De Recherche Bons de livraison
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_BON_LIVRAISON}
    Wait Until Element Is Visible  ${CHAMP_FOURNISSEUR_BON_LIVRAISON}
     Wait Until Element Is Visible  ${CHAMP_DATE_BON_LIVRAISON}
     Wait Until Element Is Visible  ${CHAMP_CREE_LE_BON_LIVRAISON}
    Wait Until Element Is Visible    ${CHAMP_TOTAL_BON_LIVRAISON}
     Wait Until Element Is Visible  ${CHAMP_REFERENCE_LIVRAISON_BON_LIVRAISON}
    Wait Until Element Is Visible    ${CHAMP_STATUT_BON_LIVRAISON}

Vérifier Que Le Champ De Recherche Est Vide Bons de livraison
    ${fournisseur} =    Get Value    ${CHAMP_FOURNISSEUR_BON_LIVRAISON}
    ${date} =    Get Value    ${CHAMP_DATE_BON_LIVRAISON}
    ${cree_le} =    Get Value    ${CHAMP_CREE_LE_BON_LIVRAISON}
    ${total} =    Get Value    ${CHAMP_TOTAL_BON_LIVRAISON}
    ${reference} =    Get Value    ${CHAMP_REFERENCE_LIVRAISON_BON_LIVRAISON}

     Should Be Empty    ${fournisseur}
     Should Be Empty    ${date}
     Should Be Empty    ${cree_le}
     Should Be Empty    ${total}
     Should Be Empty    ${reference}
# --- KPI et colonnes ---
Vérifier Affichage KPI
    [Documentation]    vérifier que les indicateurs KPI sont affichés en haut de la page
      Execute JavaScript  window.scrollTo(0,  0)
    sleep    10s
    wait until page contains    En attente de livraison
    wait until page contains    Brouillon
    wait until page contains    Annulé
    wait until page contains    Non payé
    wait until page contains    Complété

Vérifier Visibilité Des Colonnes
    [Documentation]    TODO - vérifier que les colonnes du tableau sont visibles
      wait until page contains    N° transaction
    wait until page contains      Fournisseur
    wait until page contains     Date Bon de Livraison
    wait until page contains     Créé le
     wait until page contains   Total
    wait until page contains     Référence de livraison
    wait until page contains    Statut

# --- button # ---  Scanner le bon de livraison --- ---
Vérifier Bouton Scanner le bon de livraison
    [Documentation]    vérifier la présence et le fonctionnement du bouton    Scanner le bon de livraison
    Wait Until Element Is Visible    ${BOUTON_SCANNER}    timeout=10s
      click element         ${BOUTON_SCANNER}
      sleep    2s
      wait until page contains    Scannez votre bon de livraison, puis téléchargez-le ici, le système extraira automatiquement tous les détails pour vous      10s
       Go To    ${BASE_URL}/deliverynotes
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
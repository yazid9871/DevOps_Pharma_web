*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Bons de commandes"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Bons de commandes


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Bons de commandes fonctionne correctement
    Accéder à la page    purchaseorders
    Vérifier buuton ferme pop up d'info de Multi-Fournisseurs
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Vérifier Affichage KPI Bons de commandes
    [Documentation]    Vérifie que les indicateurs KPI sont affichés en haut de la page
    Vérifier Affichage KPI Bons de commandes

Vérifier La Visibilité Et La Fonctionnalité De L'Icône Imprimer
    [Documentation]    Vérifie que l'icône Imprimer est visible et fonctionnelle
    Vérifier Icône Imprimer          purchaseorders
Vérifier L'Icône Éditer
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    VérifierL'Icône Éditer     Modifier le bon de commande      purchaseorders
Vérifier L'Icône Convertir en BL
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    VérifierL'Icône Convertir en BL     Créer un nouveau bon de livraison      purchaseorders
Vérifier Le Bouton Commande Multi-Fournisseurs
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    Vérifier Bouton Commande Multi-Fournisseurs
Vérifier Le Bouton Vérifier la disponibilité
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    Vérifier Bouton Vérifier la disponibilité
Vérifier Le Bouton "créer Bons de commandes"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Bons de commandes
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    Créer un nouveau bon de commande     purchaseorders
Rechercher Par Numéro De Transaction
    [Documentation]    Vérifie que la recherche par numéro de transaction fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Bons de commandes
    Vérifier La Recherche     th    BC-8111   ${CHAMP_NUM_TRANSACTION_BON_COMMANDE}

Rechercher Par Fournisseur
    [Documentation]    Vérifie que la recherche par fournisseur fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Bons de commandes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de commandes
    Vérifier La Recherche     td[1]    Grossiste   ${CHAMP_FOURNISSEUR_BON_COMMANDE}


Rechercher Par Date Du Bon De Commande
    [Documentation]    Vérifie que la recherche par date du bon de commande fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Bons de commandes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de commandes
    Vérifier La Recherche     td[3]    2026-08-07    ${CHAMP_DATE_BON_COMMANDE}

Rechercher Par Date De Création
    [Documentation]    Vérifie la recherche d'un Bon de commande par sa date de création (Créé le).
     Vérifier La Visibilité Des Champs De Recherche Bons de commandes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de commandes
   Vérifier La Recherche     td[4]    2026-08-07    ${CHAMP_CREE_LE_BON_COMMANDE}

Vérifier La Recherche Par Total
    [Documentation]    Vérifie la recherche d'un Bon de commande par son montant total.
     Vérifier La Visibilité Des Champs De Recherche Bons de commandes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de commandes
   Vérifier La Recherche     td[5]    5468    ${CHAMP_TOTAL_BON_COMMANDE}

Rechercher Par Statut
    [Documentation]    Vérifie que la recherche par statut fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Bons de commandes
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_STATUT_BON_COMMANDE}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[6]  ${CHAMP_STATUT_BON_COMMANDE}
*** Keywords ***

Vérifier Affichage KPI Bons de commandes
    [Documentation]    vérifier que les indicateurs KPI sont affichés en haut de la page
    Execute JavaScript  window.scrollTo(0,  0)
    sleep    2s
    wait until page contains    En attente de livraison
    wait until page contains    Brouillon
    wait until page contains    Annulé
    wait until page contains    Livré

Vérifier La Visibilité Des Champs De Recherche Bons de commandes
    Wait Until Element Is Visible  ${CHAMP_NUM_TRANSACTION_BON_COMMANDE}
    Wait Until Element Is Visible  ${CHAMP_FOURNISSEUR_BON_COMMANDE}
     Wait Until Element Is Visible  ${CHAMP_DATE_BON_COMMANDE}
     Wait Until Element Is Visible  ${CHAMP_CREE_LE_BON_COMMANDE}
    Wait Until Element Is Visible    ${CHAMP_TOTAL_BON_COMMANDE}
    Wait Until Element Is Visible    ${CHAMP_STATUT_BON_COMMANDE}

Vérifier Que Le Champ De Recherche Est Vide Bons de commandes
    ${fournisseur} =    Get Value    ${CHAMP_FOURNISSEUR_BON_COMMANDE}
    ${date} =    Get Value    ${CHAMP_DATE_BON_COMMANDE}
    ${cree_le} =    Get Value    ${CHAMP_CREE_LE_BON_COMMANDE}
    ${total} =    Get Value    ${CHAMP_TOTAL_BON_COMMANDE}

     Should Be Empty    ${fournisseur}
     Should Be Empty    ${date}
     Should Be Empty    ${cree_le}
     Should Be Empty    ${total}

# --- button #  Commande Multi-Fournisseurs--- ---
Vérifier Bouton Commande Multi-Fournisseurs
    [Documentation]    vérifier la présence et le fonctionnement du bouton   Commande Multi-Fournisseurs
    Wait Until Element Is Visible    ${BOUTON_MULTI_FOURNISSEURS}    timeout=10s
      click element         ${BOUTON_MULTI_FOURNISSEURS}
      sleep    2s
      wait until page contains   Créer un nouveau bon de commande    10s
      wait until page contains   Fournisseurs   10s

       Go To    ${BASE_URL}/purchaseorders
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s

# --- button #   Vérifier la disponibilité-- ---
Vérifier Bouton Vérifier la disponibilité
    [Documentation]    vérifier la présence et le fonctionnement du bouton Vérifier la disponibilité
    Wait Until Element Is Visible    ${BOUTON_DISPONIBILITE}    timeout=10s
      click element         ${BOUTON_DISPONIBILITE}
      sleep    2s
      wait until page contains   Vérifier la disponibilité des produits   10s

       Go To    ${BASE_URL}/purchaseorders
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s



# --- Icône Imprimer ---
VérifierL'Icône Convertir en BL
  [Arguments]    ${text}     ${URL_MODULE}
  [Documentation]    Vérifie que l'icône Convertir en BL permet d'accéder à la fonctionnalité Convertir en BL
     wait until element is visible     xpath=//*[@data-testid="recherche"]     10s
    Click Button  ${SEARCH_BUTTON}
     Click Element    ${CHAMP_STATUT_VENTE}
    Wait Until Element Is Visible  ${LISTE_DEROULANTE}    10s
     click element     css=.sob-v2-select__option:nth-child(6)
        sleep     5s
     Wait Until Element Is Visible   ${EDIT_CONVERTIR_EN_BL}    timeout=10s
    Click Element     ${EDIT_CONVERTIR_EN_BL}
    sleep    2s
     wait until page contains    ${text}      10s
      Go To    ${BASE_URL}/${URL_MODULE}
      sleep    2s
     Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
      wait until element is visible           ${BOUTON_FERMER_RECHECHE}
      click element         ${BOUTON_FERMER_RECHECHE}
      wait until element is visible     ${SEARCH_BUTTON}

Vérifier buuton ferme pop up d'info de Multi-Fournisseurs
    sleep    3s
   wait until element is visible      xpath=//*[@data-testid="fermer"]     10s
   click element       xpath=//*[@data-testid="fermer"]
   sleep    1s

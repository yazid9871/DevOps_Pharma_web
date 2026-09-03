*** Settings ***
Documentation     Tests fonctionnels de la page "Liste du Stock"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Stocks


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Stock fonctionne correctement
    Accéder à la page    stock
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent
Vérifier Le Bouton liste_des_inventaires
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    Vérifier Bouton liste_des_inventaires
Vérifier Le Bouton liste_des_imports
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    Vérifier Bouton liste_des_imports
Vérifier Le Bouton remise_à_zero_du_stock
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    Vérifier Bouton remise_à_zero_du_stock
Vérifier La Visibilité Et La Fonctionnalité De L'Icône Éditer
    [Documentation]    Vérifie que l'icône d'édition est visible et fonctionnelle
    Vérifier Visibilité Icône Éditer
    Vérifier Fonctionnalité Icône Éditer     Modifier produit      stock

Rechercher Par Produit
    [Documentation]    Vérifie que la recherche par produit fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Stock
    Vérifier La Recherche     th     DOLIPRANE CO 500MG B16 COMP EFFER      ${CHAMP_PRODUIT_STOCK}

Rechercher Par Stock En Main
    [Documentation]    Vérifie que la recherche par stock en main (Stock on Hand) fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Stock
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Stock
    Vérifier La Recherche     td[1]    53   ${CHAMP_STOCK_MAIN_STOCK}

Rechercher Par Déjà Vendu
    [Documentation]    Vérifie que la recherche par quantité déjà vendue fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Stock
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Stock
    Vérifier La Recherche     td[2]    0    ${CHAMP_DEJA_VENDU_STOCK}

Rechercher Par Disponible
    [Documentation]    Vérifie que la recherche par quantité disponible fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Stock
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Stock
    Vérifier La Recherche     td[3]    53    ${CHAMP_DISPONIBLE_STOCK}

Rechercher Par Commandé
    [Documentation]    Vérifie que la recherche par quantité commandée fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Stock
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Stock
    Vérifier La Recherche     td[4]    100    ${CHAMP_COMMANDE_STOCK}

Vérifier La Recherche Par Valeur En Prix D'Achat
    [Documentation]    Vérifie la recherche d'un Stock par sa valeur en prix d'achat.
    Vérifier La Visibilité Des Champs De Recherche Stock
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Stock
    Vérifier La Recherche     td[5]    553    ${CHAMP_VALEUR_ACHAT_STOCK}

Vérifier La Recherche Par Valeur En Prix De Vente
    [Documentation]    Vérifie la recherche d'un Stock par sa valeur en prix de vente.
    Vérifier La Visibilité Des Champs De Recherche Stock
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Stock
    Vérifier La Recherche     td[6]    837    ${CHAMP_VALEUR_VENTE_STOCK}

Rechercher Par Zone
    [Documentation]    Vérifie que la recherche par zone fonctionne correctement
     Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Stock
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_ZONE_STOCK}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[7]  ${CHAMP_ZONE_STOCK}

Rechercher Par Date D'Expiration
    [Documentation]    Vérifie que la recherche par date d'expiration fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Stock
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Stock
    Vérifier La Recherche     td[8]    2026-08    ${CHAMP_DATE_EXPIRATION_STOCK}

Rechercher Par Code Barre
    [Documentation]    Vérifie que la recherche par code barre fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Stock
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Stock
    Vérifier La Recherche     td[9]    6118000040361    ${CHAMP_CODE_BARRE_STOCK}

Rechercher Par Code Barre 2
    [Documentation]    Vérifie que la recherche par code barre 2 fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Stock
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Stock
    Vérifier La Recherche     td[10]    123    ${CHAMP_CODE_BARRE_2_STOCK}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Stock
    Wait Until Element Is Visible  ${CHAMP_PRODUIT_STOCK}
    Wait Until Element Is Visible  ${CHAMP_STOCK_MAIN_STOCK}
     Wait Until Element Is Visible  ${CHAMP_DEJA_VENDU_STOCK}
     Wait Until Element Is Visible  ${CHAMP_DISPONIBLE_STOCK}
    Wait Until Element Is Visible    ${CHAMP_COMMANDE_STOCK}
     Wait Until Element Is Visible  ${CHAMP_VALEUR_ACHAT_STOCK}
    Wait Until Element Is Visible    ${CHAMP_VALEUR_VENTE_STOCK}
    Wait Until Element Is Visible    ${CHAMP_ZONE_STOCK}
    Wait Until Element Is Visible    ${CHAMP_DATE_EXPIRATION_STOCK}
    Wait Until Element Is Visible    ${CHAMP_CODE_BARRE_STOCK}
    Wait Until Element Is Visible    ${CHAMP_CODE_BARRE_2_STOCK}

Vérifier Que Le Champ De Recherche Est Vide Stock
    ${stock_main} =    Get Value    ${CHAMP_STOCK_MAIN_STOCK}
    ${deja_vendu} =    Get Value    ${CHAMP_DEJA_VENDU_STOCK}
    ${disponible} =    Get Value    ${CHAMP_DISPONIBLE_STOCK}
    ${commande} =    Get Value    ${CHAMP_COMMANDE_STOCK}
    ${valeur_achat} =    Get Value    ${CHAMP_VALEUR_ACHAT_STOCK}
    ${valeur_vente} =    Get Value    ${CHAMP_VALEUR_VENTE_STOCK}
    ${date_expiration} =    Get Value    ${CHAMP_DATE_EXPIRATION_STOCK}
    ${code_barre} =    Get Value    ${CHAMP_CODE_BARRE_STOCK}
    ${code_barre_2} =    Get Value    ${CHAMP_CODE_BARRE_2_STOCK}

     Should Be Empty    ${stock_main}
     Should Be Empty    ${deja_vendu}
     Should Be Empty    ${disponible}
     Should Be Empty    ${commande}
     Should Be Empty    ${valeur_achat}
     Should Be Empty    ${valeur_vente}
     Should Be Empty    ${date_expiration}
     Should Be Empty    ${code_barre}
     Should Be Empty    ${code_barre_2}
Vérifier Bouton liste_des_inventaires
     Wait Until Element Is Visible    ${BOUTON_LISTE_INVENTAIRES}    timeout=10s
      click element         ${BOUTON_LISTE_INVENTAIRES}
      wait until page contains      Inventaires    10s
       Go To    ${BASE_URL}/stock
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s

Vérifier Bouton liste_des_imports
     Wait Until Element Is Visible    ${BOUTON_LISTE_IMPORTS}    timeout=10s
      click element         ${BOUTON_LISTE_IMPORTS}
      wait until page contains     Importer stock    10s
       Go To    ${BASE_URL}/stock
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s

Vérifier Bouton remise_à_zero_du_stock
     Wait Until Element Is Visible    ${BOUTON_REMISE_ZERO_DU_STOCK}    timeout=10s
      click element         ${BOUTON_REMISE_ZERO_DU_STOCK}
      wait until page contains    Réinitialisation du stock    10s
       Go To    ${BASE_URL}/stock
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
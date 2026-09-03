*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Produits"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Produits



*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Produits fonctionne correctement
    Accéder à la page    products
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent


Vérifier La Visibilité Et La Fonctionnalité De L'Icône Éditer
    [Documentation]    Vérifie que l'icône d'édition est visible et fonctionnelle
    Vérifier Visibilité Icône Éditer
    Vérifier Fonctionnalité Icône Éditer     Modifier produit      products
Vérifier Le Bouton "Historique des suggestions"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    Vérifier Bouton Historique des suggestions
Vérifier Le Bouton "Mettre à jour les prix des produits"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page
    Vérifier Bouton Mettre à jour les prix des produits
Vérifier Le Bouton "Suggérer Un Nouveau Produit"
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page Produits
   Vérifier Bouton créer / Suggérer     ${BOUTON_SUGGERER_PRODUIT}    Suggérer produit     products

Rechercher Par Nom
    [Documentation]    Vérifie que la recherche par Nom fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche
    Vérifier La Recherche     th     doliprane Test QA 788654587      ${CHAMP_NOM_PRODUIT}

Rechercher Par Catégorie
    [Documentation]    Vérifie que la recherche par catégorie fonctionne correctement
    Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_CATEGORIE_PRODUIT}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[1]    ${CHAMP_CATEGORIE_PRODUIT}

Rechercher Par Forme Galénique
    [Documentation]    Vérifie que la recherche par forme galénique fonctionne correctement
    Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_FORME_GALENIQUE_PRODUIT}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[3]             ${CHAMP_FORME_GALENIQUE_PRODUIT}


Rechercher Par PPV
    [Documentation]    Vérifie que la recherche par PPV fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    #Vérifier Que Le Champ De Recherche Est Vide
    Vérifier La Recherche     td[4]     100,00   ${CHAMP_PPV_PRODUIT}
Vérifier La Recherche Par PPH
    [Documentation]    Vérifie la recherche d'un Produit par son PPH.
    [Tags]    module:products
   Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
    #Vérifier Que Le Champ De Recherche Est Vide
    Vérifier La Recherche     td[5]      100,00    ${CHAMP_PPH_PRODUIT}


Vérifier La Recherche Par Code Barre
    [Documentation]    Vérifie la recherche d'un Produit par son code barre.
    Vérifier La Visibilité Des Champs De Recherche
    Cliquer Sur Actualiser
   # Vérifier Que Le Champ De Recherche Est Vide
    Vérifier La Recherche     td[6]     98783627517    ${CHAMP_CODE_BARRE_PRODUIT}


Rechercher Par Zone
    [Documentation]    Vérifie que la recherche par zone fonctionne correctement
     Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_ZONE_PRODUIT}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche   td[7]         ${CHAMP_ZONE_PRODUIT}


Vérifier La Recherche Par Raison
    [Documentation]    Vérifie la recherche d'un Produit par sa raison de désactivation.
    Cliquer Sur Actualiser
    Cliquer Sur Le Champ Pour Afficher Les Options      ${CHAMP_RAISON_PRODUIT}
    Vérifier Que La Liste Déroulante Est Visible        ${LISTE_DEROULANTE}
    Sélectionner Un option Et Vérifier Les Résultats De Recherche    td[12]       ${CHAMP_RAISON_PRODUIT}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche
    Wait Until Element Is Visible  ${CHAMP_NOM_PRODUIT}
        Wait Until Element Is Visible  ${CHAMP_PPV_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_PPH_PRODUIT}
     Wait Until Element Is Visible  ${CHAMP_CODE_BARRE_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_CATEGORIE_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_FORME_GALENIQUE_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_ZONE_PRODUIT}
    Wait Until Element Is Visible  ${CHAMP_RAISON_PRODUIT}


Vérifier Que Le Champ De Recherche Est Vide
    ${name} =    Get Value    ${CHAMP_NOM_PRODUIT}
    ${ppv} =    Get Value    ${CHAMP_PPV_PRODUIT}
    ${pph} =    Get Value    ${CHAMP_PPH_PRODUIT}
    ${code_barre} =    Get Value    ${CHAMP_CODE_BARRE_PRODUIT}


     Should Be Empty    ${name}
     Should Be Empty    ${ppv}
     Should Be Empty    ${pph}
     Should Be Empty    ${code_barre}

Vérifier Bouton Historique des suggestions
     Wait Until Element Is Visible    ${BOUTON_HISTORIQUE_SUGGESTIONS}    timeout=10s
      click element         ${BOUTON_HISTORIQUE_SUGGESTIONS}
      wait until page contains     Suggestions des produits     10s
       Go To    ${BASE_URL}/products
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
Vérifier Bouton Mettre à jour les prix des produits
      sleep    1s
    Wait Until Element Is Visible    ${BOUTON_METTRE_A_JOUR_PRIX_PRODUITS}    timeout=10s
      click element     ${BOUTON_METTRE_A_JOUR_PRIX_PRODUITS}
      wait until page contains     Mise à jour des prix des produits    10s
       Go To    ${BASE_URL}/products
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
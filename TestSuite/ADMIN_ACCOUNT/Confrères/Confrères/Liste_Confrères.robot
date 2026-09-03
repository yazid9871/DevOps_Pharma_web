*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Confrères"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste Confrères


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Confrères fonctionne correctement
    Accéder à la page    colleagues
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent
Vérifier Le Bouton "Archives"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Confrères
    Vérifier Bouton Archives
Vérifier La Visibilité Et La Fonctionnalité De L'Icône Éditer
    [Documentation]    Vérifie que l'icône d'édition est visible et fonctionnelle
    Vérifier Visibilité Icône Éditer
    Vérifier Fonctionnalité Icône Éditer    Modifier confrère      colleagues

Vérifier Le Bouton "créer Confrères"
    [Documentation]    Vérifie la présence des boutons d'actions globales sur la page Confrères
   Vérifier Bouton créer / Suggérer     ${BOUTON_CREER}    confrère     colleagues

Rechercher Par Nom
    [Documentation]    Vérifie que la recherche par nom fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Confrères
    Vérifier La Recherche     th    test   ${CHAMP_NOM_CLIENT}

Vérifier La Recherche Par Email
    [Documentation]    Vérifie la recherche d'un Confrère par son adresse email.
   Vérifier La Visibilité Des Champs De Recherche Confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Confrères
    Vérifier La Recherche     td[1]    test@gmail.com   ${CHAMP_EMAIL}

Vérifier La Recherche Par Téléphone
    [Documentation]    Vérifie la recherche d'un Confrère par son numéro de téléphone.
    Vérifier La Visibilité Des Champs De Recherche Confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Confrères
    Vérifier La Recherche     td[2]    0625148596    ${CHAMP_TÉLÉPHONE}

Rechercher Par CIN
    [Documentation]    Vérifie que la recherche par CIN fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Confrères
   Vérifier La Recherche     td[3]    12    ${CHAMP_CIN_CONFRERE}

Rechercher Par CNSS
    [Documentation]    Vérifie que la recherche par CNSS fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Confrères
   Vérifier La Recherche     td[4]    12    ${CHAMP_CNSS_CONFRERE}

Vérifier La Recherche Par Solde
    [Documentation]    Vérifie la recherche d'un Confrère par son solde.
    Vérifier La Visibilité Des Champs De Recherche Confrères
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Confrères
   Vérifier La Recherche     td[5]    0    ${CHAMP_SOLDE_CONFRERE}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Confrères
    Wait Until Element Is Visible  ${CHAMP_NOM_CLIENT}
    Wait Until Element Is Visible  ${CHAMP_EMAIL}
     Wait Until Element Is Visible  ${CHAMP_TÉLÉPHONE}
     Wait Until Element Is Visible  ${CHAMP_CIN_CONFRERE}
    Wait Until Element Is Visible    ${CHAMP_CNSS_CONFRERE}
     Wait Until Element Is Visible  ${CHAMP_SOLDE_CONFRERE}

Vérifier Que Le Champ De Recherche Est Vide Confrères
    ${name} =    Get Value    ${CHAMP_NOM_CLIENT}
    ${mail} =    Get Value    ${CHAMP_EMAIL}
    ${phone} =    Get Value    ${CHAMP_TÉLÉPHONE}
    ${cin} =    Get Value    ${CHAMP_CIN_CONFRERE}
    ${cnss} =    Get Value    ${CHAMP_CNSS_CONFRERE}
    ${solde} =    Get Value    ${CHAMP_SOLDE_CONFRERE}

     Should Be Empty    ${name}
     Should Be Empty    ${mail}
     Should Be Empty    ${phone}
     Should Be Empty    ${cin}
     Should Be Empty    ${cnss}
     Should Be Empty    ${solde}
Vérifier Bouton Archives
      Wait Until Element Is Visible    ${BOUTON_ARCHIVES}    timeout=10s
      click element         ${BOUTON_ARCHIVES}
      wait until element is visible       xpath=//*[@data-testid="actuel"]     10s
       Go To    ${BASE_URL}/colleagues
    Wait Until Element Is Visible      css=table.sob-v2-table tbody tr    timeout=30s
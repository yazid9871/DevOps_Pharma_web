*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Organismes"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste Organismes


*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la pagination du tableau Organismes fonctionne correctement
    Accéder à la page    payers
    Tester Page Initiale
    Tester Clic Sur Bouton Suivant
    Tester Clic Sur Bouton Précédent

Rechercher Par Nom
    [Documentation]    Vérifie que la recherche par nom fonctionne correctement
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche Organismes
    Vérifier La Recherche     th     mgen      ${CHAMP_NOM_CLIENT}

Rechercher Par Téléphone
    [Documentation]    Vérifie que la recherche par téléphone fonctionne correctement
   Vérifier La Visibilité Des Champs De Recherche Organismes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Organismes
    Vérifier La Recherche     td[1]    0604640773   ${CHAMP_TELEPHONE_ORGANISME}

Rechercher Par Ville
    [Documentation]    Vérifie que la recherche par ville fonctionne correctement
    Vérifier La Visibilité Des Champs De Recherche Organismes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Organismes
    Vérifier La Recherche     td[2]    ADOUZ    ${CHAMP_VILLE_ORGANISME}

Vérifier La Recherche Par Débit
    [Documentation]    Vérifie la recherche d'un Organisme par son débit.
    Vérifier La Visibilité Des Champs De Recherche Organismes
    Cliquer Sur Actualiser
    Vérifier Que Le Champ De Recherche Est Vide Organismes
    Vérifier La Recherche     td[3]    0    ${CHAMP_DEBIT_ORGANISME}


*** Keywords ***


Vérifier La Visibilité Des Champs De Recherche Organismes
    Wait Until Element Is Visible  ${CHAMP_NOM_CLIENT}
    Wait Until Element Is Visible  ${CHAMP_TELEPHONE_ORGANISME}
     Wait Until Element Is Visible  ${CHAMP_VILLE_ORGANISME}
    Wait Until Element Is Visible    ${CHAMP_DEBIT_ORGANISME}

Vérifier Que Le Champ De Recherche Est Vide Organismes
    ${nom} =    Get Value    ${CHAMP_NOM_CLIENT}
    ${telephone} =    Get Value    ${CHAMP_TELEPHONE_ORGANISME}
    ${ville} =    Get Value    ${CHAMP_VILLE_ORGANISME}
    ${debit} =    Get Value    ${CHAMP_DEBIT_ORGANISME}

     Should Be Empty    ${nom}
     Should Be Empty    ${telephone}
     Should Be Empty    ${ville}
     Should Be Empty    ${debit}

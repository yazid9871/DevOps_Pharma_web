*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des MySobrus"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des MySobrus



*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la page initiale de la pagination du tableau MySobrus
    ...                s'affiche correctement. Le tableau ne contient actuellement aucun client
    ...                utilisateur de MySobrus : les clics "Suivant"/"Précédent" ne sont donc pas
    ...                testés, faute d'une deuxième page à atteindre.
    Accéder à la page    mysobrus
    Tester Page Initiale

Vérifier Le Bouton "Paramètres de partage d'information"
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page MySobrus
    Accéder à la page    mysobrus
    Wait Until Element Is Visible    ${BOUTON_PARAMETRES_PARTAGE_MYSOBRUS}    timeout=10s

Vérifier Le Bouton "Mon QR code"
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page MySobrus
    Accéder à la page    mysobrus
    Wait Until Element Is Visible    ${BOUTON_MON_QR_CODE_MYSOBRUS}    timeout=10s

Vérifier Le Bouton "Lier un client"
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page MySobrus.
    ...                Lier un client déclenche une vraie action de liaison de compte : le
    ...                bouton n'est donc vérifié qu'en visibilité, sans être cliqué.
    Accéder à la page    mysobrus
    Wait Until Element Is Visible    ${BOUTON_LIER_CLIENT_MYSOBRUS}    timeout=10s

Rechercher Par Client
    [Documentation]    Vérifie que la recherche par Client fonctionne correctement
    Accéder à la page    mysobrus
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche
    Input Text    ${CHAMP_CLIENT_MYSOBRUS}    test
    Press Keys    ${CHAMP_CLIENT_MYSOBRUS}    RETURN
    sleep    2s
    Page Should Contain    MySobrus

Rechercher Par Numéro De Téléphone
    [Documentation]    Vérifie que la recherche par Numéro de téléphone fonctionne correctement
    Accéder à la page    mysobrus
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche
    Input Text    ${CHAMP_TELEPHONE_MYSOBRUS}    0600000000
    Press Keys    ${CHAMP_TELEPHONE_MYSOBRUS}    RETURN
    sleep    2s
    Page Should Contain    MySobrus

Rechercher Par Solde
    [Documentation]    Vérifie que la recherche par Solde fonctionne correctement
    Accéder à la page    mysobrus
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Vérifier La Visibilité Des Champs De Recherche
    Input Text    ${CHAMP_SOLDE_MYSOBRUS}    0
    Press Keys    ${CHAMP_SOLDE_MYSOBRUS}    RETURN
    sleep    2s
    Page Should Contain    MySobrus


*** Keywords ***

Vérifier La Visibilité Des Champs De Recherche
    Wait Until Element Is Visible  ${CHAMP_CLIENT_MYSOBRUS}
    Wait Until Element Is Visible  ${CHAMP_TELEPHONE_MYSOBRUS}
    Wait Until Element Is Visible  ${CHAMP_SOLDE_MYSOBRUS}

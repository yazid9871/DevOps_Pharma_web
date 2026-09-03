*** Settings ***
Documentation     Tests fonctionnels de la page "Liste des Communication client"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Liste des Communication client



*** Test Cases ***
Vérifier La Pagination Après Connexion
    [Documentation]    Vérifie que la page initiale de la pagination du tableau Communication
    ...                client s'affiche correctement. Le tableau ne contient actuellement aucune
    ...                communication envoyée : les clics "Suivant"/"Précédent" ne sont donc pas
    ...                testés, faute d'une deuxième page à atteindre.
    Accéder à la page    communications
    Tester Page Initiale


Vérifier Les Onglets SMS Et E-mails
    [Documentation]    Vérifie que les onglets "SMS" et "E-mails" sont visibles et cliquables
    Accéder à la page    communications
    Wait Until Element Is Visible    ${ONGLET_SMS_COMMUNICATION}    timeout=10s
    Wait Until Element Is Visible    ${ONGLET_EMAILS_COMMUNICATION}    timeout=10s
    click element    ${ONGLET_EMAILS_COMMUNICATION}
    sleep    1s
    wait until page contains    E-mails envoyés    10s
    click element    ${ONGLET_SMS_COMMUNICATION}
    sleep    1s
    wait until page contains    SMS envoyés    10s

Vérifier Le Bouton "Envoyer une communication groupée"
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page Communication
    ...                client. L'envoi d'une communication groupée déclenche un vrai envoi de
    ...                SMS/e-mail : le bouton n'est donc vérifié qu'en visibilité, sans être
    ...                cliqué.
    Accéder à la page    communications
    Wait Until Element Is Visible    ${BOUTON_ENVOYER_COMMUNICATION_GROUPEE}    timeout=10s

Vérifier La Visibilité Des Champs De Recherche
    [Documentation]    Vérifie que les champs de recherche sont visibles
    Accéder à la page    communications
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Wait Until Element Is Visible  ${CHAMP_CREE_PAR_COMMUNICATION}
    Wait Until Element Is Visible  ${CHAMP_CREE_LE_COMMUNICATION}
    Wait Until Element Is Visible  ${CHAMP_ENVOYER_A_COMMUNICATION}
    Wait Until Element Is Visible  ${CHAMP_MESSAGE_COMMUNICATION}
    Wait Until Element Is Visible  ${CHAMP_CREDITS_UTILISES_COMMUNICATION}
    Wait Until Element Is Visible  ${CHAMP_STATUT_COMMUNICATION}

Rechercher Par Envoyer À
    [Documentation]    Vérifie que la recherche par "Envoyer à" fonctionne correctement
    Accéder à la page    communications
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Input Text    ${CHAMP_ENVOYER_A_COMMUNICATION}    0600000000
    Press Keys    ${CHAMP_ENVOYER_A_COMMUNICATION}    RETURN
    sleep    2s
    Page Should Contain    Communication client

Rechercher Par Message
    [Documentation]    Vérifie que la recherche par Message fonctionne correctement
    Accéder à la page    communications
    Cliquer Sur Rechercher Pour Afficher Le Champ
    Input Text    ${CHAMP_MESSAGE_COMMUNICATION}    test
    Press Keys    ${CHAMP_MESSAGE_COMMUNICATION}    RETURN
    sleep    2s
    Page Should Contain    Communication client

*** Settings ***
Documentation     Tests fonctionnels de la page "Importer stock"
Library           SeleniumLibrary
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Resource          ../../../../Resources/Recherche.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter
#Suite Teardown    Close Browser
Force Tags        Importer stock


*** Test Cases ***
Vérifier La page apres Connexion
    [Documentation]    Vérifie que la pagination du tableau Importer stock fonctionne correctement
    Accéder à la page    stock/import


Vérifier Le Bouton "Importer"
    [Documentation]    Vérifie la présence du bouton d'action globale sur la page Importer stock
   Vérifier Bouton créer / Suggérer     ${BOUTON_IMPORTER}    Importer     stock/import

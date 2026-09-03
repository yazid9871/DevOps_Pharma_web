*** Settings ***
Documentation     Tests fonctionnels de la page "Page détails Importer stock"
Library           SeleniumLibrary
Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page détails Importer_stock

*** Variables ***
${IMPORT_STOCK_ID}      stock/smartimport/view/import_id/412
${IMPORT_STOCK_FICHIER}    Sobrus - Stock 2025400206.csv

*** Test Cases ***
Accéder à la page Importer stock
    [Documentation]    Vérifie la navigation vers la page de liste des imports de stock après
    ...                connexion.
    Accéder à la page    stock/import

Vérifier la page détails Importer stock et son bouton d'action
    [Documentation]    Ouvre un import de stock depuis le tableau et vérifie que le bouton
    ...                "Inventaire" est visible. Contrairement à la page Devis, la page Importer
    ...                stock ne possède ni statut ni menu "Autres actions" : un seul bouton
    ...                d'action est toujours affiché directement.
    Aller à la page détails de l'Importer stock    ${IMPORT_STOCK_ID}
    Vérifier l'en-tête de l'Importer stock
    Wait Until Element Is Visible    xpath=//*[@data-testid="inventaire"]    10s

Vérifier la section Liste des importations
    [Documentation]    Vérifie que la section "Liste des importations" est visible, avec ses
    ...                onglets "Tous", "Succès", "Échecs" ainsi que ses boutons "Télécharger en
    ...                CSV" et "Recherche".
    Aller à la page détails de l'Importer stock    ${IMPORT_STOCK_ID}
    Page Should Contain    Liste des importations
    Wait Until Element Is Visible    xpath=//*[contains(@data-testid,"tous_(")]    10s
    Wait Until Element Is Visible    xpath=//*[contains(@data-testid,"succès_(")]    10s
    Wait Until Element Is Visible    xpath=//*[contains(@data-testid,"échecs_(")]    10s
    Wait Until Element Is Visible    xpath=//*[@data-testid="télécharger_en_csv"]    10s

Vérifier la visibilité de la section Commentaires
    [Documentation]    Vérifie que la section Commentaires est visible sur la page détails
    ...                Importer stock.
    Aller à la page détails de l'Importer stock    ${IMPORT_STOCK_ID}
    Page Should Contain    Commentaires

Vérifier la section Informations de traçabilité
    [Documentation]    Vérifie que la section Informations de traçabilité est visible sur la page
    ...                détails Importer stock.
    Aller à la page détails de l'Importer stock    ${IMPORT_STOCK_ID}
    Page Should Contain    Informations de traçabilité

Vérifier les informations de l'Importer stock (fichier, date, total)
    [Documentation]    Vérifie que les informations générales de l'import de stock (nom du
    ...                fichier, lignes importées, importé par/le) sont correctement affichées.
    Aller à la page détails de l'Importer stock    ${IMPORT_STOCK_ID}
    Page Should Contain    Nom du fichier
    Page Should Contain    ${IMPORT_STOCK_FICHIER}
    Page Should Contain    Lignes importées
    Page Should Contain    Importé par

*** Keywords ***
Aller à la page détails de l'Importer stock
    [Documentation]    Navigue vers la page de détails d'un import de stock après connexion.
    [Arguments]    ${import_id}
    Go To     ${BASE_URL}/${import_id}
    Wait Until Element Is Visible    xpath=//*[@data-testid="inventaire"]    10s

Vérifier l'en-tête de l'Importer stock
    Page Should Contain    Détails stock importé

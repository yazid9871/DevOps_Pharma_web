*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de Préparations avec client"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags         Page de création de Préparations avec client
*** Variables ***

${draft_button}      xpath=//*[@data-testid="approuver"]
${loop_button}   xpath=//div[@class='table__search__inputs']//button[@data-testid='false']
${table}           //tbody[contains(@class, 'prevent-select')]//tr
${search_input}          id=q
${customer_contact_table}      /html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr
${total}        css=.selectedPrducts__total--payment > p:nth-child(2) > span:nth-child(1)
${approv_button}        xpath=//*[@data-testid="approuver"]
${total_pay}    182,00
${preparation_customer}    Aya
${customer}    css=div.name
${checkbox_vendre}     css=.sob-v2-checkbox

*** Test Cases ***
Accéder à la page de création d'une Préparation
        Go To Préparations Listing Page       preparation/create
Sélectionner le client dans le popup
     Cliquer sur le champ     id=customer_name
    Sélectionner dans le popup
Renseigner Qté Et Prix Uni. Du Produit Résultant
    Renseigner Qté Et Prix Uni. Du Produit Résultant
Sélectionner des produits
    Sélectionner des produits par code barre      8009004800229
Vérifier Que Vendre Cette Préparation Est Coché Par Défaut
    Vérifier Que Vendre Cette Préparation Est Coché Par Défaut
Décocher Vendre Cette Préparation Et Vérifier
    Décocher Vendre Cette Préparation Et Vérifier
Recocher Vendre Cette Préparation Et Vérifier
    Recocher Vendre Cette Préparation Et Vérifier
Valider La Préparation
   Valider La Préparation
Vérifier Que La Préparation Redirige Vers La Création D'une Vente
   Vérifier Que La Préparation Redirige Vers La Création D'une Vente

*** Keywords ***
Go To Préparations Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s

Renseigner Qté Et Prix Uni. Du Produit Résultant
    [Documentation]    Champs obligatoires propres à Préparations, absents de Devis/Vente.
    Input Text    id=resulting_product_quantity    1
    Input Text    id=resulting_product_price    50

Vérifier Que Vendre Cette Préparation Est Coché Par Défaut
    [Documentation]    Vérifie que la case "Vendre cette préparation" est cochée par défaut.
    ${checked}=    Get Element Attribute    ${checkbox_vendre}    checked
    Should Be Equal As Strings    ${checked}    true

Décocher Vendre Cette Préparation Et Vérifier
    Click Element    ${checkbox_vendre}
    ${checked}=    Get Element Attribute    ${checkbox_vendre}    checked
    Should Be Equal    ${checked}    ${None}

Recocher Vendre Cette Préparation Et Vérifier
    Click Element    ${checkbox_vendre}
    ${checked}=    Get Element Attribute    ${checkbox_vendre}    checked
    Should Be Equal As Strings    ${checked}    true

Valider La Préparation
     [Documentation]    Cocher ou décocher "Vendre cette préparation" ne change pas le
     ...                comportement du bouton Approuver : dans les deux cas, la Préparation
     ...                redirige vers la création d'une Vente pour écouler le produit résultant
     ...                (confirmé en direct). Ce fichier s'arrête à la vérification de cette
     ...                redirection ; la complétion de la Vente elle-même est couverte par
     ...                creation_de_vente_avec_client.robot.
     wait until element is visible    ${approv_button}     3s
     click element     ${approv_button}
      sleep    2s

Vérifier Que La Préparation Redirige Vers La Création D'une Vente
     sleep    1s
     wait until page contains    Créer une nouvelle vente
     wait until page contains    ${preparation_customer}

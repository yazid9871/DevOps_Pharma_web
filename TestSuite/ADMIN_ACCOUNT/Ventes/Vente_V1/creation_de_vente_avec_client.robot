*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de vente avec client"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags         Page de création de vente avec client
*** Variables ***

${draft_button}      xpath=//*[@data-testid="brouillon"]
${loop_button}   xpath=//div[@class='table__search__inputs']//button[@data-testid='false']
${table}           //tbody[contains(@class, 'prevent-select')]//tr
${search_input}          id=q
${customer_contact_table}      /html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr
${total}        css=.selectedPrducts__total--payment > p:nth-child(2) > span:nth-child(1)
${approv_button}        xpath=//div[@class='sob-breadcrumb__buttons']//button[@data-testid='false']
${total_pay}    0
${vente_customer}
${customer}    css=div.name
*** Test Cases ***
Accéder à la page de création d'une vente
        Go To vente Listing Page       invoice/create?source=invoices
Sélectionner le client dans le popup
     Cliquer sur le champ     id=customer_name
    Sélectionner dans le popup
Sélectionner des produits
    Sélectionner des produits par code barre      8009004800229
Valider La Vente
   Valider La transaction
Vérifier Que Je Peux Valider Une Vente Sans Crédit
   Vérifier Que Je Peux Valider Une Vente Sans Crédit
Afficher Les Détails De La Vente
  Afficher Les Détails De La Vente
Vérifier Les Informations De La Vente
     Vérifier Les Informations De La Vente
Cliquer Sur Modifier La Vente
    Cliquer Sur Modifier La Vente
modifier la vente
    Sélectionner des produits par code barre      8009004800229
Aprouve La Vente avec Crédit
   Appouve La transaction
Choisir Un Mode De Paiement Crédit
    Choisir Un Mode De Paiement Crédit
Vérifier Que Je Peux Valider Une Vente Avec Crédit
    Vérifier Que Je Peux Valider Une Vente Avec Crédit



*** Keywords ***
Go To vente Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s

Afficher Les Détails De La Vente
       click element     xpath=//*[@data-testid="afficher_la_facture"]
        sleep    2s
Cliquer Sur Modifier La Vente
   wait until element is visible      xpath=//*[@data-testid="modifier"]     3s
       click element     xpath=//*[@data-testid="modifier"]
   wait until element is visible      ${approv_button}     3s

Vérifier Les Informations De La Vente
       wait until page contains  ${total_pay}
          # wait until page contains    ${vente_customer}

Vérifier Que Je Peux Valider Une Vente Sans Crédit

     sleep    1s
     wait until page contains    Vente créée avec succès !

Choisir Un Mode De Paiement Crédit
     sleep     1s
     wait until element is visible      xpath=//*[@data-testid="vente_à_crédit"]     20 s
     click element      xpath=//*[@data-testid="vente_à_crédit"]
Vérifier Que Je Peux Valider Une Vente Avec Crédit
    sleep    1s
     wait until page contains    Vente créée avec succès !
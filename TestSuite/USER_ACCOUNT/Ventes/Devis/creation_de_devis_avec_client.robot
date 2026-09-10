*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de Devis avec client"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags         Page de création de Devis avec client
*** Variables ***

${draft_button}      xpath=//*[@data-testid="brouillon"]
${loop_button}   xpath=//div[@class='table__search__inputs']//button[@data-testid='false']
${table}           //tbody[contains(@class, 'prevent-select')]//tr
${search_input}          id=q
${customer_contact_table}      /html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr
${total}        css=.selectedPrducts__total--payment > p:nth-child(2) > span:nth-child(1)
${approv_button}        xpath=//div[@class='sob-breadcrumb__buttons']//button[@data-testid='false']
${total_pay}    182,00
${devis_customer}    Aya
${customer}    css=div.name

${autre_action_button}     xpath=//div[@class='sob-breadcrumb__buttons']//button[@data-testid='false']
*** Test Cases ***
Accéder à la page de création d'un Devis
        Go To devis Listing Page       quote/create
Sélectionner le client dans le popup
     Cliquer sur le champ     id=customer_name
    Sélectionner dans le popup
Sélectionner des produits
    Sélectionner des produits par code barre      8009004800229
Valider La Vente
   Valider La transaction
Vérifier Que Le Devis A Été Créé Avec Succès
   Vérifier Que Le Devis A Été Créé Avec Succès
Afficher Les Détails Du Devis
  Afficher Les Détails Du Devis
Vérifier Les Informations Du Devis
     Vérifier Les Informations Du Devis
Cliquer Sur Modifier La devis
    Cliquer Sur Modifier La devis
modifier le devis
    Sélectionner des produits par code barre      8009004800229
Approuve La devis
   Appouve La transaction
Vérifier Que Le Devis A Été modie Avec Succès
   Vérifier Que Le Devis A Été Créé Avec Succès

*** Keywords ***
Go To devis Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s



Vérifier Que Le Devis A Été Créé Avec Succès
     sleep    1s
     wait until page contains    Le devis a été créé avec succès

Afficher Les Détails Du Devis
       click element     xpath=//*[@data-testid="afficher_le_devis"]
        sleep    2s

Vérifier Les Informations Du Devis
      sleep    2s
       wait until page contains  ${total_pay}      20s
       wait until element is visible      xpath=//*[@data-testid="aya"]
Cliquer Sur Modifier La devis

    wait until element is visible     ${autre_action_button}      20s
    click element     ${autre_action_button}
   wait until element is visible      xpath=//*[@data-testid="modifier"]     3s
       click element     xpath=//*[@data-testid="modifier"]
   wait until element is visible      ${approv_button}     3s

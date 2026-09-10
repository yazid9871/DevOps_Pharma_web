*** Settings ***
Documentation     Tests fonctionnels de la page " Page de création de Retours_sur_ventes avec client"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags         Page de création de Retours_sur_ventes avec client
*** Variables ***

${draft_button}      xpath=//*[@data-testid="approuver"]
${loop_button}   xpath=//div[@class='table__search__inputs']//button[@data-testid='false']
${table}           //tbody[contains(@class, 'prevent-select')]//tr
${search_input}          id=q
${customer_contact_table}      /html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr
${total}        css=.selectedPrducts__total--payment > p:nth-child(2) > span:nth-child(1)
${approv_button}        xpath=//*[@data-testid="approuver"]
${total_pay}    182,00
${retour_customer}    Aya
${customer}    css=div.name

*** Test Cases ***
Accéder à la page de création d'un Retour sur vente
        Go To Retours_sur_ventes Listing Page       salesreturn/create?source=sales_return_saved
Sélectionner le client dans le popup
     Cliquer sur le champ     id=customer_name
    Sélectionner dans le popup
Sélectionner des produits
    Sélectionner des produits par code barre      8009004800229
Valider Le Retour Sur Vente
   Valider Le Retour Sur Vente
Vérifier Que Le Retour Sur Vente A Été Créé Avec Succès
   Vérifier Que Le Retour Sur Vente A Été Créé Avec Succès
Afficher Les Détails Du Retour Sur Vente
  Afficher Les Détails Du Retour Sur Vente
Vérifier Les Informations Du Retour Sur Vente
     Vérifier Les Informations Du Retour Sur Vente

*** Keywords ***
Go To Retours_sur_ventes Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
     Wait Until Element Is Visible   ${draft_button}  timeout=30s

Valider Le Retour Sur Vente
     [Documentation]    Contrairement à un Devis, Approuver un Retour sur vente ouvre un écran
     ...                réel de remboursement ("Choisir un mode de paiement"). On complète en
     ...                Espèces pour finaliser le retour, comme le fait déjà le flux Vente en cash.
     wait until element is visible    ${approv_button}     3s
     click element     ${approv_button}
      sleep    2s
      wait until element is visible    xpath=//button[contains(., "Espèces")]     10s
      click element     xpath=//button[contains(., "Espèces")]
      sleep    2s

Vérifier Que Le Retour Sur Vente A Été Créé Avec Succès
     sleep    1s
     wait until page contains    Le retour sur vente a été crée avec succès!

Afficher Les Détails Du Retour Sur Vente
       click element     xpath=//*[@data-testid="afficher_le_retour_sur_vente"]
        sleep    2s

Vérifier Les Informations Du Retour Sur Vente
      sleep    2s
       wait until page contains  ${total_pay}      20s
       wait until element is visible      xpath=//*[@data-testid="aya"]

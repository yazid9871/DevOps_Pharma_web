*** Settings ***
Documentation     Tests fonctionnels de la page "Page de création de Préparations :verify_pop_up_check"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page de création de Préparations : verify_pop_up_check

*** Variables ***


${ADD_BUTTON}        xpath=//*[@data-testid="créer"]
${draft_button}      xpath=//*[@data-testid="approuver"]
${customer_input}      id=customer_name
${contact_input}          css=#contact_name
${REFRESH_BUTTON}       css=button.sob-v2-btn-tertiary:nth-child(2)

${table}           //tbody[contains(@class, 'prevent-select')]//tr
${SEARCH_FIELD_ZONE}      id=zone_id.q
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="barcode"]
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="barcode"]
${SEARCH_FIELD_DCI}     id=product_dci_id.q
${continuer_BUTTON}        xpath=//*[@data-testid="continuer"]
${Gestionnaire}        css=.sob-v2-navbar-user-fullName
*** Test Cases ***
go to create Préparations page
    Go To Préparations Listing Page    preparation/create
    go to create Préparations page
# --- Verify customer pop up   ---
ouvrire pop up client
    Cliquer sur le champ     id=customer_name
verify refresh button dans pop up client
    verify refresh button
ajouter un client avec invalide data
     Verify cutomer pop up create and create customer with invalid data
ajouter client avec valide data
      create customer with valid data
Rechercher Par client
    Cliquer sur le champ     id=customer_name
    Recherc her Par client
Sélectionner le client dans le popup
    Sélectionner dans le popup
Vérifier que le client sélectionné est correct
    Vérifier que le X sélectionné est correct       id=customer_name

Sélectionner des produits pour test pop up product multi price
    Sélectionner des produits par code barre      3401560238839
Vérifier affichage de pop up product multi price
    Verify pop up product multi price
Sélectionner des produits pop up tva
    Sélectionner des produits par code barre      13550
Vérifier affichage de pop up tva
    Verify pop up product tva


Verify pop up product with multi date
    Sélectionner des produits par code barre      6118000050643
Vérifier affichage de pop up productmulti date
    Verify pop up product multi date

#verify edit pop up
  #  edit product
  #  verify results
*** Keywords ***

Go To Préparations Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
go to create Préparations page
     Wait Until Element Is Visible   ${draft_button}  timeout=30s


Verify pop up product tva
     sleep     1s
     wait until page contains     Ce produit a plusieurs prix, lequel vous souhaitez utiliser      10s
      wait until element is visible    ${product_ppv_popup}     30s
       click element       ${product_ppv_popup}
Verify pop up product multi date
      sleep     1s
     wait until page contains     Ce produit a plusieurs dates de péremption, laquelle voulez-vous utiliser ?      10s
      wait until element is visible    ${product_ppv_popup}     30s
       click element       ${product_ppv_popup}


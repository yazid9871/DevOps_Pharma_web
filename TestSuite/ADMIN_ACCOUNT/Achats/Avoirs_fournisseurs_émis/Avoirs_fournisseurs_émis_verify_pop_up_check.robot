*** Settings ***
Documentation     Tests fonctionnels de la page "Page de création de Avoirs_fournisseurs_émis :verify_pop_up_check"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page de création de Avoirs_fournisseurs_émis : verify_pop_up_check

*** Variables ***


${ADD_BUTTON}        xpath=//*[@data-testid="créer"]
${draft_button}      xpath=//*[@data-testid="sauvegarder"]
${customer_input}      id=supplier_id
${REFRESH_BUTTON}       css=button.sob-v2-btn-tertiary:nth-child(2)

${table}           //tbody[contains(@class, 'prevent-select')]//tr
${SEARCH_FIELD_ZONE}      id=zone_id.q
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="barcode"]
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="barcode"]
${SEARCH_FIELD_DCI}     id=product_dci_id.q
${continuer_BUTTON}        xpath=//*[@data-testid="continuer"]
${Gestionnaire}        css=.sob-v2-navbar-user-fullName
*** Test Cases ***
go to create Avoirs_fournisseurs_émis page
    Go To Avoirs_fournisseurs_émis Listing Page    purchasesissuedreturn/create
    go to create Avoirs_fournisseurs_émis page
# --- Verify fournisseur select (pas un popup : liste déroulante react-select) ---
Sélectionner un fournisseur
    select supplier    ${SUPPLIER_NAME}
Vérifier que le fournisseur sélectionné est correct
    vérifier que le fournisseur sélectionné est correct    id=supplier_id    ${SUPPLIER_NAME}    purchasesissuedreturn/create

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

Go To Avoirs_fournisseurs_émis Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
go to create Avoirs_fournisseurs_émis page
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


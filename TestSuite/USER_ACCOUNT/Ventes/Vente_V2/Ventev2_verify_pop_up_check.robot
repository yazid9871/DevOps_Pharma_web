*** Settings ***
Documentation     Tests fonctionnels de la page "Page de création de vente :verify_pop_up_check"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page de création de vente : verify_pop_up_check

*** Variables ***


${ADD_BUTTON}        xpath=//*[@data-testid="créer"]
${draft_button}      xpath=//*[@data-testid="brouillon"]
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
go to create devis page
    Go To devis Listing Page   invoice/create/cashier-mode?source=invoices
    go to create devis page
valide le compte user par ecurity_code
     valide le compte user par ecurity_code      ${PASSWORD2}
# --- Verify customer pop up   ---
ouvrire pop up client
    Cliquer sur le champ client v2      css=.customer__info
verify refresh button dans pop up client
    verify refresh button v2
ajouter un client avec invalide data
     Verify cutomer pop up create and create customer with invalid data
ajouter client avec valide data
      create customer with valid data
Rechercher Par client
     sleep    2s
    Cliquer sur le champ client v2      css=.customer__info
    Recherc her Par client
Sélectionner le client dans le popup
    Sélectionner dans le popup

ouvrire pop up contact
    Cliquer sur le champ contact v2    css=empty__contact
verify refresh button dans pop up cpntact
    verify refresh button v2
Sélectionner le contact dans le popup
    Sélectionner dans le popup

Sélectionner des produits pour test pop up product multi price
    Sélectionner des produits par code barre      3401560238839
Vérifier affichage de pop up product multi price
    Verify pop up product multi price vente v2
Sélectionner des produits pop up tva
    Sélectionner des produits par code barre      13550
Vérifier affichage de pop up tva
    Verify pop up product tva vente v2


Verify pop up product with multi date
    Sélectionner des produits par code barre      6118000050643
Vérifier affichage de pop up productmulti date
    Verify pop up product multi date vente v2

#verify edit pop up
  #  edit product
  #  verify results
*** Keywords ***

Go To devis Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
go to create devis page
     Wait Until Element Is Visible   ${draft_button}  timeout=30s


Verify pop up product tva vente v2
     sleep     1s
     wait until page contains     Ce produit a plusieurs prix, lequel vous souhaitez utiliser      10s
      wait until element is visible    ${product_ppv_popupv2}     30s
       click element       ${product_ppv_popupv2}
Verify pop up product multi date vente v2
      sleep     1s
     wait until page contains     Ce produit a plusieurs dates de péremption, laquelle voulez-vous utiliser ?      10s
      wait until element is visible    ${product_ppv_popupv2}     30s
       click element       ${product_ppv_popupv2}

####################################
Cliquer sur le champ client v2
      [Arguments]    ${CHAMP}
     sleep       1s
    wait until element is visible      ${CHAMP}   10s
    click element     ${CHAMP}
    Wait Until Element Is Visible    css=tr.zoom:nth-child(1)     30s

Cliquer sur le champ contact v2
      [Arguments]    ${CHAMP}
     sleep       1s
    wait until element is visible      ${CHAMP}   10s
    click element     ${CHAMP}
    Wait Until Element Is Visible    css=tr.zoom:nth-child(1)     30s

Verify pop up product multi price vente v2
      sleep    1s
      wait until page contains    Ce produit a plusieurs prix, lequel vous souhaitez utiliser
     wait until element is visible    ${product_ppv_popupv2}     30s
       click element      ${product_ppv_popupv2}

verify refresh button v2
     Click Button  ${REFRESH_BUTTONv2}
      ${search} =    Get Value    ${search_input}
       Should Be Empty    ${search}
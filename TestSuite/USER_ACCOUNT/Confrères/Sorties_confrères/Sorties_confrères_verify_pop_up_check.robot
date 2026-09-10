*** Settings ***
Documentation     Tests fonctionnels de la page "Page de création de Sorties_confrères :verify_pop_up_check"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_user.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/PageCreationMotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page de création de Sorties_confrères : verify_pop_up_check

*** Variables ***


${ADD_BUTTON}        xpath=//*[@data-testid="créer"]
${draft_button}      xpath=//*[@data-testid="sauvegarder"]
${customer_input}      id=colleague_name
${contact_input}          css=#contact_name
${REFRESH_BUTTON}       css=button.sob-v2-btn-tertiary:nth-child(2)
${SEARCH_FIELD_CODEBARRE}      xpath=//*[@id="nameorbarecode.q"]

${table}           //tbody[contains(@class, 'prevent-select')]//tr
${SEARCH_FIELD_ZONE}      id=zone_id.q
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="nameorbarecode.q"]
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="nameorbarecode.q"]
${SEARCH_FIELD_DCI}     id=product_dci_id.q
${continuer_BUTTON}        xpath=//*[@data-testid="continuer"]
${Gestionnaire}        css=.sob-v2-navbar-user-fullName
*** Test Cases ***
go to create Sorties_confrères page
    Go To Sorties_confrères Listing Page    colleagues/sales/create?pricing_field=sale_price
    go to create Sorties_confrères page
# --- Verify confrère pop up   ---
ouvrire pop up confrères
    Cliquer sur le champ     id=colleague_name
verify refresh button dans pop up confrères
   verify refresh button confrères
Rechercher Par confrères
    Recherc her Par confrères
Sélectionner le confrères dans le popup
    Sélectionner dans le popup
Vérifier que le confrères sélectionné est correct
    Vérifier que le X sélectionné est correct       id=colleague_name

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

Go To Sorties_confrères Listing Page
     [Arguments]    ${URL_MODULE}
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/${URL_MODULE}
go to create Sorties_confrères page
     Wait Until Element Is Visible   ${draft_button}  timeout=30s

# --- Surcharge locale : le popup Confrères n'a pas de client nommé "client with contact",
# --- contrairement au popup Clients pour lequel ce mot-clé partagé a été écrit à l'origine.
Recherc her Par confrères
     Input Text   id=q    test
     Press Keys  id=q  RETURN
     sleep    2s
   ${expected_result}  get value    id=q
    sleep      2s
    ${table_rows}  Get Element Count    xpath=/html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr

          Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
                 ${col}    set variable    [${row}]/td[1]
                  ${xpath_tab}    set variable     /html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr${col}
                    ${cell_text}  get text   xpath= ${xpath_tab}
                Should Contain  ${cell_text}  ${expected_result}
          END

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

verify refresh button confrères
     wait until element is visible   css=.sob-v2-tableHeader-btn
     Click Button    css=.sob-v2-tableHeader-btn
      ${search} =    Get Value    css=.sob-v2-tableHeader-btn
       Should Be Empty    ${search}

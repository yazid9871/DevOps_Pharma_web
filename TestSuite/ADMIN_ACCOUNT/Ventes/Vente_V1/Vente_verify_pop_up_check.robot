*** Settings ***
Documentation     Tests fonctionnels de la page "Page de création de devis :verify_pop_up_check"
Library           SeleniumLibrary
Library    Collections

Library            String
Resource          ../../../../Resources/Authentification_Admin.robot
Resource          ../../../../Resources/MotsClesCommuns.robot
Resource          ../../../../Resources/Variables.robot
Suite Setup       Ouvrir Le Navigateur Se Connecter 2
#Suite Teardown    Close Browser
Force Tags        Page de création de devis : verify_pop_up_check

*** Variables ***


${ADD_BUTTON}        xpath=//*[@data-testid="créer"]
${draft_button}      xpath=//*[@data-testid="brouillon"]
${customer_input}      id=customer_name
${contact_input}          css=#contact_name
${ADD_CUSTOMER_BUTTON}      xpath=//*[@data-testid="nouveau_client"]
${search_input}          id=q
${REFRESH_BUTTON}      xpath=//div[@class='sob-v2-table-header-actions']//button[@data-testid='false']
${CUSTOMER8_NAME}        css=#QuickCreateModal > div:nth-child(1) > div:nth-child(2) > input:nth-child(1)
${CUSTOMER_TYPE}        css=#type
${CUSTOMER_MAIL}    xpath=//*[@id="email"]
${CUSTOMER_PHONE}    xpath=//*[@id="phone"]
${CUSTOMER_Adres}    xpath=//*[@id="address"]
${CUSTOMER_VILLE}    xpath=//*[@id="city"]
${CUSTOMER_pay}      css=#country
${CUSTOMER_SAVE_BUTTON}        xpath=//*[@data-testid="sauvegarder"]
${table}           //tbody[contains(@class, 'prevent-select')]//tr
${product_ppv_popup}        xpath=//*[@class="font-paragraph-small"]
${SEARCH_FIELD_ZONE}      id=zone_id.q
${customer_contact_table}      /html/body/div[2]/div/div/div[2]/div/div[2]/table/tbody/tr
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="barcode"]
${SEARCH_FIELD_PRODUCT_NAME}      xpath=//*[@id="barcode"]
${SEARCH_FIELD_DCI}     id=product_dci_id.q
${continuer_BUTTON}        xpath=//*[@data-testid="continuer"]
${Gestionnaire}        css=.sob-v2-navbar-user-fullName
*** Test Cases ***
go to create devis page
         Go To devis Listing Page
    go to create devis page

Verify customer pop up
     open the customer pop up
      verify refresh button
     Verify cutomer pop up create and create customer with invalid data
      create customer with valid data
     Check Customer Selected Is The Same As Input Customer
     open the customer pop up
     Search By customer
     Click Customer Row And Verify Selection
Verify contact pop up
     input contact should be empty
     open the contact pop up
     verify refresh button
     Search By contact
     Click contact Row And Verify Selection
Verify pop up product multi price
    select Product
    Verify pop up product multi price

Verify pop up tva
    select Product
    Verify pop up product tva
Verify pop up product price and tva
    select Product
    Verify pop up product price and tva
Verify pop up product with multi date
    select Product
    Verify pop up product with multi date
Verify pop up Interaction :Utiliser avec précaution
    Select Products    PROPRANOLOL
     Select Products    VILDAGLIPTINE
    Verify pop up Utiliser avec précaution
    delete product from product list
Verify pop up Interaction : À prendre en compte
    Select Products    ACEBUTOLOL
     Select Products    ATENOLOL
    Verify pop up À prendre en compte
    delete product from product list
Verify pop up Interaction : Association déconseillée
    Select Products    APIXABAN
     Select Products    VORICONAZOLE
    Verify pop up Association déconseillée
    delete product from product list
Verify pop up Interaction : Contre-indication
    Select Products    SIMVASTATINE
     Select Products    VORICONAZOLE
    Verify pop up Contre-indication
    delete product from product list
#verify edit pop up
  #  edit product
  #  verify results
*** Keywords ***

Go To devis Listing Page
    [Documentation]    Navigate to the product listing page after login in.
    Go To    ${BASE_URL}/quote/create
go to create devis page
     Wait Until Element Is Visible   ${draft_button}  timeout=30s


open the customer pop up
    click element    ${customer_input}
    Wait Until Element Is Visible     ${REFRESH_BUTTON}   timeout=30s


verify refresh button
     Click Button  ${REFRESH_BUTTON}
      ${search} =    Get Value    ${search_input}
       Should Be Empty    ${search}

Verify cutomer pop up create and create customer with invalid data
    click element    ${ADD_CUSTOMER_BUTTON}
     Wait Until Element Is Visible      css=button.sob-v2-icon-btn-sm:nth-child(1)   timeout=30s
      #invalid data
        Submit Form
        Page Should Contain  Ce champ est requis


create customer with valid data
      Input Text     ${CUSTOMER8_NAME}      MER-TEST-VENT
      click element   ${CUSTOMER_TYPE}
      click element   css=.sob-v2-select__option:nth-child(2)
      Input Text     ${CUSTOMER_MAIL}     MER-TEST@gmail.com
      Input Text     ${CUSTOMER_PHONE}  0625148596
      Execute JavaScript  document.querySelector("#city").scrollIntoView(true);
      sleep    3s
       wait until element is visible      ${CUSTOMER_VILLE}    30s
      Input Text     ${CUSTOMER_Adres}    hay fes
      Input Text     ${CUSTOMER_VILLE}    fes
      #Execute JavaScript  window.scrollTo( 0, document.body.scrollHeight)
       sleep    5s
Check Customer Selected Is The Same As Input Customer
      ${name}    set variable   MER-TEST-VENT
      click element    ${CUSTOMER_SAVE_BUTTON}
      sleep    5s
      ${cutomer_value}    get value   ${customer_input}
      should be equal    ${cutomer_value}    ${name}

Search By customer
     Input Text   ${search_input}  test test
     Press Keys  ${search_input}  RETURN
     sleep    2s
   ${expected_result}  get value    ${search_input}
    ${table_rows}  Get Element Count    xpath=${customer_contact_table}
     IF     ${table_rows} == 0
               Wait Until Element Is Visible  css:.sob-v2-empty-data-title    10s
      ELSE
          Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
                 ${col}    set variable    [${row}]/td[1]
                  ${xpath_tab}    set variable     ${customer_contact_table}${col}
                    ${cell_text}  get text   xpath= ${xpath_tab}
                Should Contain  ${cell_text}  ${expected_result}
           END
      END

Click Customer Row And Verify Selection
      sleep     2s
        ${col}    set variable  /td[1]
          ${xpath_tab}    set variable     ${customer_contact_table}${col}
       click element      xpath=${xpath_tab}
        Wait Until Element Is Visible  ${contact_input}   5s
        ${cutomer_value}    get value   ${customer_input}
         ${cust}    set variable    test test
         should be equal         ${cust}       ${cutomer_value}
input contact should be empty
     ${empty_contact}   get value    ${contact_input}
     Should Be Empty    ${empty_contact}

open the contact pop up
    click element    ${contact_input}
    sleep    5s
    Wait Until Element Is Visible     ${search_input}       30s

Search By contact
     Input Text   ${search_input}  Zz
     Press Keys  ${search_input}  RETURN
     sleep    2s
   ${expected_result}  get value    ${search_input}
    ${table_rows}  Get Element Count     xpath=${customer_contact_table}
     IF     ${table_rows} == 0
               Wait Until Element Is Visible  css:.sob-v2-empty-data-title    10s
      ELSE
          Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
                 ${col}    set variable    [${row}]/td[1]
                  ${xpath_tab}    set variable     ${customer_contact_table}${col}
                    ${cell_text}  get text   xpath= ${xpath_tab}
                Should Contain  ${cell_text}  ${expected_result}
           END
      END

Click contact Row And Verify Selection
      sleep     5s
       ${col}    set variable    /td[1]
        ${xpath_tab}    set variable     ${customer_contact_table}${col}
          ${cell_text}  get text   xpath= ${xpath_tab}
       click element     xpath= ${xpath_tab}
      Wait Until Element Is Visible  ${contact_input}   2s
      ${contact_value}    get value   ${contact_input}
      should contain     ${contact_value}    ${cell_text}

select Product
      #search by zone
      Click Element    ${SEARCH_FIELD_ZONE}
        wait until element is visible      css=.sob-v2-select__option:nth-child(4)     10s
     Click Element    css=.sob-v2-select__option:nth-child(4)
     wait until element is visible     xpath=${table}     15s


Verify pop up product tva
     click element     xpath=${table}
      wait until element is visible    ${product_ppv_popup}     30s
       click element       ${product_ppv_popup}

Verify pop up product multi price
      ${col}    set variable    [3]/td[1]
        ${xpath_tab}    set variable     ${table}${col}
       click element     xpath= ${xpath_tab}
     wait until element is visible    ${product_ppv_popup}     30s
       click element      ${product_ppv_popup}


Verify pop up product price and tva
      ${col}    set variable    [2]/td[1]
        ${xpath_tab}    set variable     ${table}${col}
       click element     xpath= ${xpath_tab}
     wait until element is visible   ${product_ppv_popup}     30s
       click element      ${product_ppv_popup}

Verify pop up product with multi date
      ${col}    set variable    [5]/td[1]
        ${xpath_tab}    set variable     ${table}${col}
       click element     xpath= ${xpath_tab}
     wait until element is visible   ${product_ppv_popup}     30s
       click element      ${product_ppv_popup}
       wait until element is visible     id=delete
         FOR  ${i}  IN RANGE  1  5
             click element   id=delete
             sleep    1s
         END
Select Products
     [Arguments]     ${product1}
    Input Text    ${SEARCH_FIELD_DCI}    ${product1}
    Press Keys    ${SEARCH_FIELD_DCI}    RETURN
    sleep    2s
    Wait Until Element Is Visible    xpath=${table}    30s
    Click Element    xpath=${table}

Verify pop up Utiliser avec précaution
    wait until page contains    À utiliser avec précaution     15s
    click element    ${continuer_BUTTON}

Verify pop up À prendre en compte
    wait until page contains   À prendre en compte    15s
    click element    ${continuer_BUTTON}

Verify pop up Association déconseillée
    wait until page contains   Association déconseillée   15s
    click element    ${continuer_BUTTON}

Verify pop up Contre-indication
    wait until page contains    Contre-indication    15s
    click element    ${continuer_BUTTON}


delete product from product list
      click element   id=delete
       sleep    1s
       click element   id=delete
       sleep    1s
       Reload Page
       sleep     2s
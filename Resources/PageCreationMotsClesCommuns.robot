*** Settings ***
Documentation
Library           SeleniumLibrary
Resource          Variables.robot
Library    Collections


*** Variables ***
# --- pop up client  ---
${REFRESH_BUTTON}       css=button.sob-v2-btn-tertiary:nth-child(2)
${REFRESH_BUTTONv2}      css=.sob-v2-tableHeader-btn

${search_input}          id=q
${ADD_CUSTOMER_BUTTON}      xpath=//*[@data-testid="nouveau_client"]

${CUSTOMER8_NAME}        css=#QuickCreateModal > div:nth-child(1) > div:nth-child(2) > input:nth-child(1)
${CUSTOMER_TYPE}        css=#type
${CUSTOMER_MAIL}    xpath=//*[@id="email"]
${CUSTOMER_PHONE}    xpath=//*[@id="phone"]
${CUSTOMER_Adres}    xpath=//*[@id="address"]
${CUSTOMER_VILLE}    xpath=//*[@id="city"]
${CUSTOMER_pay}      css=#country
${CUSTOMER_SAVE_BUTTON}        xpath=//*[@data-testid="sauvegarder"]
${customer_contact_table}        /html/body/div[3]/div/div/div[2]/div/div[2]/table/tbody/tr

${SEARCH_FIELD_CODEBARRE}      xpath=//*[@id="barcode"]
@{PU_LIST}
${table2}                 //table[contains(@class, 'sob-v2-table')]//tbody//tr


*** Keywords ***

Sélectionner des produits par code barre
     [Arguments]     ${product1}
    Input Text    ${SEARCH_FIELD_CODEBARRE}    ${product1}
    Press Keys    ${SEARCH_FIELD_CODEBARRE}    RETURN
    sleep    2s
      # ${col}    set variable       [2]/td[3]
        #  ${xpath_tab}    set variable     ${table2}${col}
       #   ${product_ppv_from_list}  get text   xpath=${xpath_tab}
       # Append To List    ${PU_LIST}    ${product_ppv_from_list}

Verify pop up product multi price
      sleep    1s
      wait until page contains    Ce produit a plusieurs prix, lequel vous souhaitez utiliser
     wait until element is visible    ${product_ppv_popup}     30s
       click element      ${product_ppv_popup}

# --- pop up client : selecte cient   ---

Cliquer sur le champ
      [Arguments]    ${CHAMP}
     sleep       1s
    wait until element is visible      ${CHAMP}   10s
    click element     ${CHAMP}

Sélectionner dans le popup
         sleep     2s
      Wait Until Element Is Visible    css=tr.zoom:nth-child(1)     30s
    click element    css=tr.zoom:nth-child(1)
    sleep    1s

Vérifier que le X sélectionné est correct
      [Arguments]    ${CHAMP}
    wait until element is visible    ${CHAMP}
    ${nom}=    Get Value    ${CHAMP}
    Should Not Be Empty    ${nom}
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
       sleep    4s
       Submit Form
        sleep    2s
    ${is_duplicate}=    Run Keyword And Return Status    Wait Until Page Contains    Ce client existe déjà ?    5s
    IF    ${is_duplicate}
        click element      xpath=//*[@data-testid="créer_un_nouveau_client"]
    END



Rechercher Par client
     Input Text   ${search_input}    client with contact
     Press Keys  ${search_input}  RETURN
     sleep    2s
   ${expected_result}  get value    ${search_input}
    sleep      2s
    ${table_rows}  Get Element Count    xpath=${customer_contact_table}

          Should Be True  ${table_rows} > 0
          FOR  ${row}  IN RANGE  1  ${table_rows} + 1
                 ${col}    set variable    [${row}]/td[1]
                  ${xpath_tab}    set variable     ${customer_contact_table}${col}
                    ${cell_text}  get text   xpath= ${xpath_tab}
                Should Contain  ${cell_text}  ${expected_result}
           END



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
Valider La transaction
    wait until element is visible      ${DRAFT_button}
    click element      ${DRAFT_button}
    sleep    1s


Appouve La transaction
     wait until element is visible      ${APPROUVE_button}
    click element      ${APPROUVE_button}
    sleep    1s

valide le compte user par ecurity_code
       [Arguments]    ${security_code}
       sleep    2s
   wait until element is visible    id=switch_security_code     20s
   input text    id=switch_security_code     ${security_code}
   click element     ${CHANGE__button}
   sleep    1s